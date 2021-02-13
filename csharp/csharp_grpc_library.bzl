load("//csharp:csharp_grpc_compile.bzl", "csharp_grpc_compile")
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_library")

def csharp_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    csharp_grpc_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create csharp library
    csharp_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = GRPC_DEPS,
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@google.protobuf//:lib",
    "@grpc.core//:lib",
    "@core_sdk_stdlib//:libraryset",
]
