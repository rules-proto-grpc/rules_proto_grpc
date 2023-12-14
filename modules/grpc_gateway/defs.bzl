"""grpc_gateway protobuf and grpc rules."""

load(":gateway_grpc_compile.bzl", _gateway_grpc_compile = "gateway_grpc_compile")
load(":gateway_grpc_library.bzl", _gateway_grpc_library = "gateway_grpc_library")
load(":gateway_openapiv2_compile.bzl", _gateway_openapiv2_compile = "gateway_openapiv2_compile")
load(":gateway_grpc_library.bzl", _GATEWAY_DEPS = "GATEWAY_DEPS")  # buildifier: disable=same-origin-load # buildifier: disable=out-of-order-load

# Export grpc_gateway rules
gateway_grpc_compile = _gateway_grpc_compile
gateway_openapiv2_compile = _gateway_openapiv2_compile
gateway_grpc_library = _gateway_grpc_library

# Extra defs
GATEWAY_DEPS = _GATEWAY_DEPS
