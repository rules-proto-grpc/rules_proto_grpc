"""Generated definition of java_proto_library."""

load("@rules_java//java:defs.bzl", "java_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:java_proto_compile.bzl", "java_proto_compile")

def java_proto_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    java_proto_compile(
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
        deps = PROTO_DEPS + kwargs.get("deps", []),
        exports = PROTO_DEPS + kwargs.get("exports", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

PROTO_DEPS = [
    Label("@maven//:com_google_protobuf_protobuf_java"),
]
