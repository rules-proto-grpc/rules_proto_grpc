module github.com/rules-proto-grpc/rule_proto_grpc

go 1.24.5

tool (
	// Prevent go mod tidy from deleting dependencies it thinks are unused
	google.golang.org/grpc
	google.golang.org/grpc/cmd/protoc-gen-go-grpc
	google.golang.org/protobuf
)

require (
	golang.org/x/net v0.40.0 // indirect
	golang.org/x/sys v0.33.0 // indirect
	golang.org/x/text v0.25.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20250528174236-200df99c418a // indirect
	google.golang.org/grpc v1.74.2 // indirect
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.5.1 // indirect
	google.golang.org/protobuf v1.36.10 // indirect
)
