"""Generated definition of rust_grpc_library."""

load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_rust//rust:defs.bzl", "rust_library")
load(":common.bzl", "crate_label", "prepare_rust_proto_deps", "rust_compile_attrs")
load(":rust_fixer.bzl", "rust_proto_crate_fixer", "rust_proto_crate_root")
load(":rust_grpc_compile.bzl", "rust_grpc_compile")

def rust_grpc_library(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    name_fixed = name_pb + "_fixed"
    name_root = name + "_root"

    proto_deps = kwargs.get("proto_deps", [])
    rust_proto_compiled_targets = prepare_rust_proto_deps(proto_deps)

    rust_grpc_compile(
        name = name_pb,
        crate_name = kwargs.get("crate_name", name),
        proto_deps = rust_proto_compiled_targets,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs or
               (k in rust_compile_attrs and k not in ["crate_name", "proto_deps"])
        }  # Forward args
    )

    # Fix up includes emitted by plugins that run in isolated protoc invocations.
    rust_proto_crate_fixer(
        name = name_fixed,
        compilation = name_pb,
    )

    rust_proto_crate_root(
        name = name_root,
        crate_dir = name_fixed,
    )

    # Create rust library
    rust_library(
        name = name,
        crate_name = kwargs.get("crate_name", name),
        crate_root = name_root,
        edition = kwargs.get("edition", "2021"),
        srcs = [name_fixed],
        deps = [crate_label("prost"), crate_label("prost-types")] +
               [crate_label("pbjson"), crate_label("pbjson-types")] +
               [crate_label("serde")] +
               [crate_label("tonic")] +
               kwargs.get("deps", []) +
               proto_deps,
        proc_macro_deps = kwargs.get("proc_macro_deps", []) + [
            crate_label("prost-derive"),
        ],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )
