open System
open System.Collections.Generic
open System.Diagnostics
open System.Threading.Tasks

open Grpc.Core

module Server =

    type RouteGuideImpl(features: RouteGuide.Feature seq) =
        inherit RouteGuide.RouteGuide.RouteGuideBase()
        let myLock = new Object();
        let routeNotes: Dictionary<RouteGuide.Point, List<RouteGuide.RouteNote>> = new Dictionary<RouteGuide.Point, List<RouteGuide.RouteNote>>();
        member private this.checkFeature (location: RouteGuide.Point): RouteGuide.Feature option =
            features |> Seq.tryFind (fun f -> f.Location = ValueSome(location))

        member private this.addNoteForLocation (location: RouteGuide.Point) (note: RouteGuide.RouteNote): List<RouteGuide.RouteNote> =
            lock myLock (fun _ -> 
                let mutable notes: List<RouteGuide.RouteNote> = null 
                if not (routeNotes.TryGetValue(location, &notes)) then
                    notes <- List<RouteGuide.RouteNote>()
                    routeNotes.Add(location, notes)
                else
                    ()
                
                let preexistingNotes = notes
                notes.Add(note)
                preexistingNotes
            )
        override this.GetFeature(request: RouteGuide.Point) (context: ServerCallContext): Task<RouteGuide.Feature> = 
            match this.checkFeature request with
            | Some(f) -> Task.FromResult(f)
            | None -> Task.FromResult(RouteGuide.Feature.empty ())
        override this.ListFeatures(request: RouteGuide.Rectangle) (responseStream: IServerStreamWriter<RouteGuide.Feature>) (context: ServerCallContext): Task = 
            async {
                let foundFeatures = 
                    features 
                    |> Seq.filter(fun f -> RouteGuideUtil.contains request (f.Location |> ValueOption.defaultWith RouteGuide.Point.empty)) 
                
                for f in foundFeatures do
                    do! responseStream.WriteAsync(f) |> Async.AwaitTask
            } |> Async.StartAsTask :> Task
            

        override this.RecordRoute(requestStream: IAsyncStreamReader<RouteGuide.Point>) (context: ServerCallContext): Task<RouteGuide.RouteSummary> =
            async {
                let mutable pointCount = 0
                let mutable featureCount = 0
                let mutable distance = 0
                let mutable previous: RouteGuide.Point option = None
                let stopwatch = Stopwatch()
                stopwatch.Start()

                let mutable hasNext = true
                do! requestStream.MoveNext() |> Async.AwaitTask |> Async.Ignore
                while hasNext do
                    let point = requestStream.Current
                    pointCount <- pointCount + 1

                    match this.checkFeature point with
                    | Some(p) ->
                        featureCount <- featureCount + 1
                    | None -> ()

                    match previous with
                    | Some(prev) -> 
                        distance <- (RouteGuideUtil.getDistance prev point) |> int
                        previous <- Some(point)
                    | None ->
                        previous <- Some(point)
                    
                    let! next = requestStream.MoveNext() |> Async.AwaitTask
                    hasNext <- next
                
                stopwatch.Stop()

                let summary: RouteGuide.RouteSummary = { PointCount = ValueSome(pointCount); FeatureCount = ValueSome(featureCount); Distance = ValueSome(distance); ElapsedTime = ValueSome(((stopwatch.ElapsedMilliseconds / int64(1000)) |> int)); _UnknownFields = null}
                return summary
            } |> Async.StartAsTask
     
        override this.RouteChat(requestStream: IAsyncStreamReader<RouteGuide.RouteNote>) (responseStream: IServerStreamWriter<RouteGuide.RouteNote>) (context: ServerCallContext): Task = 
            async {
                let mutable hasNext = true
                do! requestStream.MoveNext() |> Async.AwaitTask |> Async.Ignore
                while hasNext do
                    let note = requestStream.Current
                    let prevNotes = this.addNoteForLocation (note.Location |> ValueOption.defaultWith RouteGuide.Point.empty) note
                    for prevNote in prevNotes do
                        do! responseStream.WriteAsync(prevNote) |> Async.AwaitTask
                    let! next = requestStream.MoveNext() |> Async.AwaitTask
                    hasNext <- next
                    

            } |> Async.StartAsTask :> Task

open Server

[<EntryPoint>]
let main argv =
    let port =
        let portVar =
            System.Environment.GetEnvironmentVariable("SERVER_PORT")

        if not (String.IsNullOrEmpty(portVar)) then
            Int32.Parse(portVar)
        else
            50051
    let features = RouteGuideUtil.parseFeatures "fsharp/example/routeguide/server.exe/routeguide_features.json"

    let server = Server()

    let serviceDefinition =
        RouteGuide.RouteGuide.RouteGuideMethodBinder.BindService(RouteGuideImpl(features))

    server.Services.Add(serviceDefinition)

    server.Ports.Add(ServerPort("127.0.0.1", port, ServerCredentials.Insecure))
    |> ignore

    server.Start()
    Console.WriteLine("F# server listening on port " + (port.ToString()) + ". CTRL+C to stop.")
    Console.ReadLine() |> ignore
    server.ShutdownAsync().Wait();
    0
