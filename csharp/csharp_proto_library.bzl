"""Generated definition of csharp_proto_library."""

load("//csharp:csharp_proto_compile.bzl", "csharp_proto_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_library")

def csharp_proto_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    csharp_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create csharp library
    csharp_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@google.protobuf//:lib",
    "@core_sdk_stdlib//:libraryset",
]
