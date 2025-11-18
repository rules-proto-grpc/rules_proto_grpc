module github.com/rules-proto-grpc/rule_proto_grpc

go 1.24.5

tool (
	// Prevent go mod tidy from deleting dependencies it thinks are unused
	google.golang.org/grpc
	google.golang.org/grpc/cmd/protoc-gen-go-grpc
	google.golang.org/protobuf
)

require (
	golang.org/x/net v0.46.1-0.20251013234738-63d1a5100f82 // indirect
	golang.org/x/sys v0.37.0 // indirect
	golang.org/x/text v0.30.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20251022142026-3a174f9686a8 // indirect
	google.golang.org/grpc v1.77.0 // indirect
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.5.1 // indirect
	google.golang.org/protobuf v1.36.10 // indirect
)
