"""go protobuf and grpc rules."""

load(":go_grpc_compile.bzl", _go_grpc_compile = "go_grpc_compile")
load(":go_grpc_library.bzl", _go_grpc_library = "go_grpc_library")
load(":go_proto_compile.bzl", _go_proto_compile = "go_proto_compile")
load(":go_proto_library.bzl", _go_proto_library = "go_proto_library")
load(":go_proto_library.bzl", _PROTO_DEPS = "PROTO_DEPS")  # buildifier: disable=same-origin-load # buildifier: disable=out-of-order-load
load(":go_grpc_library.bzl", _GRPC_DEPS = "GRPC_DEPS")  # buildifier: disable=same-origin-load # buildifier: disable=out-of-order-load

# Export go rules
go_proto_compile = _go_proto_compile
go_grpc_compile = _go_grpc_compile
go_proto_library = _go_proto_library
go_grpc_library = _go_grpc_library

# Extra defs
GRPC_DEPS = _GRPC_DEPS
PROTO_DEPS = _PROTO_DEPS
