"""Generated definition of python_proto_library."""

load("//python:python_proto_compile.bzl", "python_proto_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@rules_python//python:defs.bzl", "py_library")

def python_proto_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    python_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create python library
    py_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        imports = [name_pb],
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf_python",
]
