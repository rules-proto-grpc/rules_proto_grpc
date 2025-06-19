"""Generated definition of objc_grpc_library."""

load("@rules_cc//cc:defs.bzl", "objc_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "filter_files", "proto_compile_attrs")
load("//:objc_grpc_compile.bzl", "objc_grpc_compile")

def objc_grpc_library(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    objc_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Filter files to sources and headers
    filter_files(
        name = name_pb + "_srcs",
        target = name_pb,
        extensions = ["m"],
    )

    filter_files(
        name = name_pb + "_hdrs",
        target = name_pb,
        extensions = ["h"],
    )

    # Create objc library
    objc_library(
        name = name,
        non_arc_srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        includes = [name_pb],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs + [
                "alwayslink",
                "copts",
                "defines",
                "include_prefix",
                "linkopts",
                "linkstatic",
                "local_defines",
                "nocopts",
                "strip_include_prefix",
            ]
        }
    )

GRPC_DEPS = [
    Label("@protobuf//:protobuf_objc"),
    Label("@grpc//src/objective-c:proto_objc_rpc"),
]
