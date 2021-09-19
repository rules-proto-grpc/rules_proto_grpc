"""Generated definition of fsharp_grpc_library."""

load("//fsharp:fsharp_grpc_compile.bzl", "fsharp_grpc_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "fsharp_library")

def fsharp_grpc_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    fsharp_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create fsharp library
    fsharp_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@google.protobuf//:lib",
    "@grpc.core//:lib",
    "@fsharp.core//:lib",
    "@protobuf.fsharp//:lib",
    "@core_sdk_stdlib//:libraryset",
]
