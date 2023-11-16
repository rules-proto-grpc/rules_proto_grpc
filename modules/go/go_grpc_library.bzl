"""Generated definition of go_grpc_library."""

load("@rules_go//go:def.bzl", "go_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:go_grpc_compile.bzl", "go_grpc_compile")
load("//:go_proto_library.bzl", "PROTO_DEPS")

def go_grpc_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    go_grpc_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if (k in proto_compile_attrs.keys() and k != "prefix_path") or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create go library
    go_library(
        name = name,
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + GRPC_DEPS + kwargs.get("deps", []),
        importpath = kwargs.get("importpath"),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

GRPC_DEPS = [
    Label("@org_golang_google_grpc//:go_default_library"),
    Label("@org_golang_google_grpc//codes:go_default_library"),
    Label("@org_golang_google_grpc//status:go_default_library"),
] + PROTO_DEPS
