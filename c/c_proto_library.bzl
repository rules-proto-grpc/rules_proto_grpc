"""Generated definition of c_proto_library."""

load("//c:c_proto_compile.bzl", "c_proto_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("//internal:filter_files.bzl", "filter_files")
load("@rules_cc//cc:defs.bzl", "cc_library")

def c_proto_library(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    c_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Filter files to sources and headers
    filter_files(
        name = name_pb + "_srcs",
        target = name_pb,
        extensions = ["c"],
    )

    filter_files(
        name = name_pb + "_hdrs",
        target = name_pb,
        extensions = ["h"],
    )

    # Create c library
    cc_library(
        name = name,
        srcs = [name_pb + "_srcs"],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        hdrs = [name_pb + "_hdrs"],
        includes = [name_pb],
        alwayslink = kwargs.get("alwayslink"),
        copts = kwargs.get("copts"),
        defines = kwargs.get("defines"),
        include_prefix = kwargs.get("include_prefix"),
        linkopts = kwargs.get("linkopts"),
        linkstatic = kwargs.get("linkstatic"),
        local_defines = kwargs.get("local_defines"),
        nocopts = kwargs.get("nocopts"),
        strip_include_prefix = kwargs.get("strip_include_prefix"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@upb//:upb",
]
