"""Generated definition of rust_prost_proto_library."""

load("//rust:rust_prost_proto_compile.bzl", "rust_prost_proto_compile")
load("//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//rust:rust_fixer.bzl", "rust_proto_crate_fixer", "rust_proto_crate_root")  # @unused
load("@rules_rust//rust:defs.bzl", "rust_library")

def rust_prost_proto_library(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    name_fixed = name_pb + "_fixed"
    name_root = name + "_root"
    rust_prost_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    rust_proto_crate_root(
        name = name_root,
        crate_dir = name_pb,
    )

    # Create rust_prost library
    rust_library(
        name = name,
        edition = "2021",
        crate_root = name_root,
        crate_name = kwargs.get("crate_name"),
        srcs = [name_pb],
        deps = kwargs.get("prost_deps", [Label("//rust/crates:prost"), Label("//rust/crates:prost-types")]) + kwargs.get("deps", []),
        proc_macro_deps = [kwargs.get("prost_derive_dep", Label("//rust/crates:prost-derive"))],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )
