"""Generated definition of csharp_proto_library."""

load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "filter_files", "proto_compile_attrs")
load("//:csharp_proto_compile.bzl", "csharp_proto_compile")
load("//:common.bzl", "csharp_library_attrs")
load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")


passthrough_attrs = bazel_build_rule_common_attrs + csharp_library_attrs

def csharp_proto_library(name, **kwargs):  # buildifier: disable=function-docstring
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
        deps = PROTO_DEPS + kwargs.get("deps", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in passthrough_attrs
        }  # Forward Bazel common args
    )

PROTO_DEPS = [
    Label("@protobuf//:protobuf"),
    # Label("@core_sdk_stdlib//:libraryset"),  # TODO needed?
]
