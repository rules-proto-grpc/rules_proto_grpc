"""Generated definition of closure_proto_library."""

load("//closure:closure_proto_compile.bzl", "closure_proto_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")

def closure_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    closure_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create closure library
    closure_js_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
        suppress = [],
    )

PROTO_DEPS = [
    "@io_bazel_rules_closure//closure/protobuf:jspb",
]
