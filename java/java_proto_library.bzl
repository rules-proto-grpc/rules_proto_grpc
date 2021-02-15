"""Generated definition of java_proto_library."""

load("//java:java_proto_compile.bzl", "java_proto_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@rules_java//java:defs.bzl", "java_library")

def java_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    java_proto_compile(
        name = name_pb,
        **{
            k: v for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create java library
    java_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        exports = PROTO_DEPS + kwargs.get("exports", []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf_java",
]
