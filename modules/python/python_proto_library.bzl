"""Generated definition of python_proto_library."""

load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "filter_files", "proto_compile_attrs")
load("@rules_python//python:defs.bzl", "py_library")
load("//:python_proto_compile.bzl", "python_proto_compile")

def python_proto_library(name, generate_pyi = False, **kwargs):
    """
    python_proto_library generates Python code from proto and creates a py_library for them.

    Args:
        name: the name of the target.
        generate_pyi: flag to specify whether .pyi files should be created.
        **kwargs: common Bazel attributes will be passed to both python_proto_compile and py_library;
        python_proto_compile attributes will be passed to python_proto_compile only.
    """

    # Compile protos
    name_pb = name + "_pb"
    python_proto_compile(
        name = name_pb,
        extra_plugins = [Label("//:pyi_plugin")] if generate_pyi else [],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Filter .pyi files when generating pyi to add to pyi_srcs
    pyi_srcs = []
    if generate_pyi:
        name_pyi_files = name_pb + "_pyi_files"
        filter_files(
            name = name_pyi_files,
            target = name_pb,
            extensions = ["pyi"],
        )
        pyi_srcs = [name_pyi_files]

    # For other code to import generated code with prefix_path if it's given
    output_mode = kwargs.get("output_mode", "PREFIXED")
    if output_mode == "PREFIXED":
        imports = [name_pb]
    else:
        imports = ["."]

    # Create python library
    py_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        data = kwargs.get("data", []),  # See https://github.com/rules-proto-grpc/rules_proto_grpc/issues/257 for use case
        imports = imports,
        pyi_srcs = pyi_srcs,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

PROTO_DEPS = [
    Label("@protobuf//:protobuf_python"),
]
