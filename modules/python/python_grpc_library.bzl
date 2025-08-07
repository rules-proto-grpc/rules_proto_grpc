"""Generated definition of python_grpc_library."""

load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_python//python:defs.bzl", "py_library")
load("//:python_grpc_compile.bzl", "python_grpc_compile")

def python_grpc_library(name, generate_pyi = False, **kwargs):
    """
    python_grpc_library generates Python code from proto and gRPC, and creates a py_library for them.

    Args:
        name: the name of the target.
        generate_pyi: flag to specify whether .pyi files should be created.
        **kwargs: common Bazel attributes will be passed to both python_grpc_compile and py_library;
        python_grpc_compile attributes will be passed to python_grpc_compile only.
    """

    # Compile protos
    name_pb = name + "_pb"
    python_grpc_compile(
        name = name_pb,
        extra_plugins = [Label("//:pyi_plugin")] if generate_pyi else [],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # For other code to import generated code with prefix_path if it's given
    output_mode = kwargs.get("output_mode", "PREFIXED")
    if output_mode == "PREFIXED":
        imports = [name_pb]
    else:
        imports = ["."]

    # for pb2_grpc.py to import pb2.py
    prefix_path = kwargs.get("prefix_path", None)
    if prefix_path:
        imports.append(imports[0] + "/" + prefix_path)

    # Create python library
    py_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        data = kwargs.get("data", []),  # See https://github.com/rules-proto-grpc/rules_proto_grpc/issues/257 for use case
        imports = imports,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

GRPC_DEPS = [
    Label("@grpc//src/python/grpcio/grpc:grpcio"),
    Label("@protobuf//:protobuf_python"),
]
