"""Generated definition of csharp_grpc_library."""

load("//csharp:csharp_grpc_compile.bzl", "csharp_grpc_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_library")

def csharp_grpc_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    csharp_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create csharp library
    csharp_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@google.protobuf//:lib",
    "@grpc.core//:lib",
    "@core_sdk_stdlib//:libraryset",
]
