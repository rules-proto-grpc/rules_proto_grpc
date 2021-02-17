"""js protobuf and grpc rules."""

load(":js_proto_compile.bzl", _js_proto_compile = "js_proto_compile")
load(":nodejs_grpc_compile.bzl", _nodejs_grpc_compile = "nodejs_grpc_compile")
load(":js_proto_library.bzl", _js_proto_library = "js_proto_library")
load(":nodejs_grpc_library.bzl", _nodejs_grpc_library = "nodejs_grpc_library")

# Export js rules
js_proto_compile = _js_proto_compile
nodejs_grpc_compile = _nodejs_grpc_compile
js_proto_library = _js_proto_library
nodejs_grpc_library = _nodejs_grpc_library

# Aliases
nodejs_proto_compile = _js_proto_compile
nodejs_proto_library = _js_proto_library
