"""Generated definition of csharp_grpc_library."""

load("//:csharp_grpc_compile.bzl", "csharp_grpc_compile")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "filter_files", "proto_compile_attrs")
load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")

def csharp_grpc_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    csharp_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create csharp library
    csharp_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

GRPC_DEPS = [
    Label("@protobuf//:protobuf"),
    # Label("@grpc//:grpc++"),
    # "@grpc.net.client//:lib",
    # "@grpc.aspnetcore//:lib",
    # "@core_sdk_stdlib//:libraryset",
]
