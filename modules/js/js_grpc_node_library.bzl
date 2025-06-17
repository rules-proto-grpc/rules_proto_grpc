"""Generated definition of js_grpc_node_library."""

load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:js_grpc_node_compile.bzl", "js_grpc_node_compile")

def js_grpc_node_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    js_grpc_node_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create js library
    js_library(
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
    Label("@rules_proto_grpc_js//:node_modules/@grpc/grpc-js"),
    Label("@rules_proto_grpc_js//:node_modules/google-protobuf"),
]
