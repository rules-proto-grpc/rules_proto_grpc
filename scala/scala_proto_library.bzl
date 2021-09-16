"""Generated definition of scala_proto_library."""

load("//scala:scala_proto_compile.bzl", "scala_proto_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
load("@io_bazel_rules_scala//scala_proto/default:default_deps.bzl", "DEFAULT_SCALAPB_COMPILE_DEPS", "DEFAULT_SCALAPB_GRPC_DEPS")  # buildifier: disable=load

def scala_proto_library(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    scala_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create scala library
    scala_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        exports = PROTO_DEPS + kwargs.get("exports", []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    # One dependency in this list is not valid outside of rules_scala workspace, fix up. The '//external' check is for
    # older rules_scala prior to
    # https://github.com/bazelbuild/rules_scala/commit/e9dfbe39fa44a8dc7ab0b9aef46488f215646d9c
    "@io_bazel_rules_scala" + dep if not dep.startswith("//external") and not dep.startswith("@") else dep
    for dep in DEFAULT_SCALAPB_COMPILE_DEPS
]
