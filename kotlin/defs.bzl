"""kotlin protobuf and grpc rules."""

load(":kotlin_proto_compile.bzl", _kotlin_proto_compile = "kotlin_proto_compile")
load(":kotlin_grpc_compile.bzl", _kotlin_grpc_compile = "kotlin_grpc_compile")
load(":kotlin_proto_library.bzl", _kotlin_proto_library = "kotlin_proto_library")
load(":kotlin_grpc_library.bzl", _kotlin_grpc_library = "kotlin_grpc_library")

# Export kotlin rules
kotlin_proto_compile = _kotlin_proto_compile
kotlin_grpc_compile = _kotlin_grpc_compile
kotlin_proto_library = _kotlin_proto_library
kotlin_grpc_library = _kotlin_grpc_library
