"""Generated definition of go_validate_library."""

load("//go:go_grpc_library.bzl", "GRPC_DEPS")
load("//go:go_validate_compile.bzl", "go_validate_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

def go_validate_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    go_validate_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + [
                key
                for key in proto_compile_attrs.keys()
                if key != "prefix_path"
            ]
        }  # Forward args
    )

    # Create go library
    go_library(
        name = name,
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + VALIDATE_DEPS + kwargs.get("deps", []),
        importpath = kwargs.get("importpath"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

VALIDATE_DEPS = [] + GRPC_DEPS
