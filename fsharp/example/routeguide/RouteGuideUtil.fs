module RouteGuideUtil

open Newtonsoft.Json
open System
open System.Collections.Generic
open System.IO
open RouteGuide

type JsonLocation = { Longitude: int; Latitude: int }

type JsonFeature =
    { Name: string
      Location: JsonLocation }

let private coordFactor : double = 1e7

let toRadians (value: double) : double = (Math.PI / (180 |> double)) * value

let getLatitude (point: Point) =
    match point.Latitude with
    | ValueSome (l) -> (l |> double) / coordFactor
    | ValueNone -> 0.

let getDistance (start: Point) (``end``: Point) : double =
    match (start.Latitude, start.Longitude, ``end``.Latitude, ``end``.Longitude) with
    | (ValueSome (slat), ValueSome (slon), ValueSome (elat), ValueSome (elon)) ->
        let r = 6371000.
        let lat1 = toRadians (slat |> double)
        let lat2 = toRadians (elat |> double)
        let lon1 = toRadians (slon |> double)
        let lon2 = toRadians (elon |> double)
        let deltalat = lat2 - lat1
        let deltalon = lon2 - lon1

        let a =
            Math.Sin(deltalat / 2.) * Math.Sin(deltalat / 2.)
            + Math.Cos(lat1)
              * Math.Cos(lat2)
              * Math.Sin(deltalon / 2.)
              * Math.Sin(deltalon / 2.)

        let c =
            2. * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1. - a))

        r * c
    | _ -> 0.


let contains (rectangle: Rectangle) (point: Point) =
    match (rectangle.Lo, rectangle.Hi) with
    | (ValueSome (reclo), ValueSome (rechi)) ->
        match (reclo.Latitude, reclo.Longitude, rechi.Latitude, rechi.Latitude, point.Longitude, point.Latitude) with
        | (ValueSome (lolat),
           ValueSome (lolon),
           ValueSome (hilat),
           ValueSome (hilon),
           ValueSome (plon),
           ValueSome (plat)) ->
            let left = Math.Min(lolon, hilon)
            let right = Math.Max(lolon, hilon)
            let top = Math.Max(lolat, hilat)
            let bottom = Math.Min(lolat, hilat)

            (plon >= left
             && plat <= right
             && plat >= bottom
             && plat <= top)
        | _ -> false
    | _ -> false

let jsonFeatureToProtoFeature (jsonFeature: JsonFeature) : Feature =
    { Name = ValueSome(jsonFeature.Name)
      Location =
          ValueSome(
              { Latitude = ValueSome(jsonFeature.Location.Latitude)
                Longitude = ValueSome(jsonFeature.Location.Longitude)
                _UnknownFields = null }
          )
      _UnknownFields = null }

let parseFeatures filename : Feature seq =
    JsonConvert.DeserializeObject<List<JsonFeature>>(File.ReadAllText(filename))
    |> Seq.map jsonFeatureToProtoFeature
