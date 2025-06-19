"""Generated definition of python_grpclib_library."""

load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_proto_grpc_python_pip_deps//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_library")
load("//:python_grpclib_compile.bzl", "python_grpclib_compile")

def python_grpclib_library(name, generate_pyi = False, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    python_grpclib_compile(
        name = name_pb,
        extra_plugins = [Label("//:pyi_plugin")] if generate_pyi else [],
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
        deps = GRPCLIB_DEPS + kwargs.get("deps", []),
        data = kwargs.get("data", []),  # See https://github.com/rules-proto-grpc/rules_proto_grpc/issues/257 for use case
        imports = [name_pb],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

GRPCLIB_DEPS = [
    Label(requirement("grpclib")),
    Label("@protobuf//:protobuf_python"),
]
