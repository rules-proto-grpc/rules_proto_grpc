"""Generated definition of cpp_proto_library."""

load("@rules_cc//cc:defs.bzl", "cc_library")
load("//:defs.bzl", "bazel_build_rule_common_attrs", "filter_files", "proto_compile_attrs")
load("//cpp:cpp_proto_compile.bzl", "cpp_proto_compile")

def cpp_proto_library(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    cpp_proto_compile(
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
        extensions = ["cc"],
    )

    filter_files(
        name = name_pb + "_hdrs",
        target = name_pb,
        extensions = ["h"],
    )

    # Create cpp library
    cc_library(
        name = name,
        srcs = [name_pb + "_srcs"],
        deps = kwargs.get("deps", [
            Label("@protobuf//:protobuf"),
        ]),
        hdrs = [name_pb + "_hdrs"],
        includes = [name_pb] if kwargs.get("output_mode", "PREFIXED") == "PREFIXED" else ["."],
        alwayslink = kwargs.get("alwayslink"),
        copts = kwargs.get("copts"),
        defines = kwargs.get("defines"),
        include_prefix = kwargs.get("include_prefix"),
        linkopts = kwargs.get("linkopts"),
        linkstatic = kwargs.get("linkstatic"),
        local_defines = kwargs.get("local_defines"),
        nocopts = kwargs.get("nocopts"),
        strip_include_prefix = kwargs.get("strip_include_prefix"),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )
