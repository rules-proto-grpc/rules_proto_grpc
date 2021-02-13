# Aggregate all `nodejs` rules to one loadable file
load(":nodejs_proto_compile.bzl", _nodejs_proto_compile = "nodejs_proto_compile")
load(":nodejs_grpc_compile.bzl", _nodejs_grpc_compile = "nodejs_grpc_compile")
load(":nodejs_proto_library.bzl", _nodejs_proto_library = "nodejs_proto_library")
load(":nodejs_grpc_library.bzl", _nodejs_grpc_library = "nodejs_grpc_library")

nodejs_proto_compile = _nodejs_proto_compile
nodejs_grpc_compile = _nodejs_grpc_compile
nodejs_proto_library = _nodejs_proto_library
nodejs_grpc_library = _nodejs_grpc_library
