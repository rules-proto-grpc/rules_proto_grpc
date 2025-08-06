// This file exists only to prevent go mod tidy from deleting dependencies
// it thinks are unused
package main

import (
	_ "google.golang.org/grpc"
	_ "google.golang.org/grpc/cmd/protoc-gen-go-grpc"
	_ "google.golang.org/protobuf"
)
