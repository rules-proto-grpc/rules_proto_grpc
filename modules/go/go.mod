module github.com/rules-proto-grpc/rule_proto_grpc

go 1.25.0

tool (
	// Prevent go mod tidy from deleting dependencies it thinks are unused
	google.golang.org/grpc
	google.golang.org/grpc/cmd/protoc-gen-go-grpc
	google.golang.org/protobuf
)

require (
	golang.org/x/net v0.48.0 // indirect
	golang.org/x/sys v0.39.0 // indirect
	golang.org/x/text v0.32.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260226221140-a57be14db171 // indirect
	google.golang.org/grpc v1.79.2 // indirect
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.6.1 // indirect
	google.golang.org/protobuf v1.36.11 // indirect
)
