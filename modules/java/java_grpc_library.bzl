"""Generated definition of java_grpc_library."""

load("@rules_java//java:defs.bzl", "java_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:java_grpc_compile.bzl", "java_grpc_compile")

def java_grpc_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    java_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create java library
    java_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        runtime_deps = [
            Label("@grpc-java//netty"),
        ],
        exports = GRPC_DEPS + kwargs.get("exports", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

GRPC_DEPS = [
    Label("@protobuf//java/core"),
    Label("@protobuf//java/util"),
    Label("@grpc-java//api"),
    Label("@grpc-java//protobuf"),
    Label("@grpc-java//stub"),
]
