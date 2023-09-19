"""Generated definition of python_proto_library."""

load("@rules_python//python:defs.bzl", "py_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:python_proto_compile.bzl", "python_proto_compile")

def python_proto_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    python_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create python library
    py_library(
        name = name,
        srcs = [name_pb],
        deps = kwargs.get("deps", [
            Label("@protobuf//:protobuf_python"),
        ]),
        data = kwargs.get("data", []),  # See https://github.com/rules-proto-grpc/rules_proto_grpc/issues/257 for use case
        imports = [name_pb],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )
