"""Generated definition of csharp_proto_library."""

load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:csharp_proto_compile.bzl", "csharp_proto_compile")

def csharp_proto_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    csharp_proto_compile(
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
        target_frameworks = kwargs.get("target_frameworks", ["net8.0"]),
        deps = PROTO_DEPS + kwargs.get("deps", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

PROTO_DEPS = [
    Label("@paket.main//google.protobuf"),
]
