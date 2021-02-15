"""Generated definition of objc_proto_library."""

load("//objc:objc_proto_compile.bzl", "objc_proto_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@rules_cc//cc:defs.bzl", "objc_library")

def objc_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    objc_proto_compile(
        name = name_pb,
        **{
            k: v for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create objc library
    objc_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        includes = [name_pb],
        copts = kwargs.get("copts"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf_objc",
]
