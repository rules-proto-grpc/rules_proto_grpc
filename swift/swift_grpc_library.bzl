"""Generated definition of swift_grpc_library."""

load("//swift:swift_grpc_compile.bzl", "swift_grpc_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

def swift_grpc_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    swift_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create swift library
    swift_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        module_name = kwargs.get("module_name"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@com_github_apple_swift_protobuf//:SwiftProtobuf",
    "@com_github_grpc_grpc_swift//:GRPC",
]
