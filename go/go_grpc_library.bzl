"""Generated definition of go_grpc_library."""

load("//go:go_proto_library.bzl", "PROTO_DEPS")
load("//go:go_grpc_compile.bzl", "go_grpc_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

def go_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    go_grpc_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + [
                key for key in proto_compile_attrs.keys() if key != "prefix_path"
            ]
        }  # Forward args
    )

    # Create go library
    go_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        importpath = kwargs.get("importpath"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@org_golang_google_grpc//:go_default_library",
    "@org_golang_google_grpc//codes:go_default_library",
    "@org_golang_google_grpc//status:go_default_library",
] + PROTO_DEPS
