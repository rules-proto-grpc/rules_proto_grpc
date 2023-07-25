"""Generated definition of rust_prost_proto_library."""

load("//rust:compile.bzl", "prost_compile_attrs")
load("//rust:rust_prost_proto_compile.bzl", "rust_prost_proto_compile")
load("//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//rust:rust_fixer.bzl", "rust_proto_crate_fixer", "rust_proto_crate_root")
load("@rules_rust//rust:defs.bzl", "rust_library")

def _crate(name):
    """Convert a simple crate name into its full label."""
    return Label("//rust/3rdparty/crates:" + name)

# We assume that all targets in prost_proto_deps[] were also generated with this macro.
# For convenience we append the _pb suffix if its missing to allow users to provide the same name as they used when
# they used this macro to generate that dependency.
def _prepare_prost_proto_deps(prost_proto_deps):
    prost_proto_compiled_targets = []

    for dep in prost_proto_deps:
        if dep.endswith("_pb"):
            prost_proto_compiled_targets.append(dep)
        else:
            prost_proto_compiled_targets.append(dep + "_pb")

    return prost_proto_compiled_targets

def rust_prost_proto_library(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    name_fixed = name_pb + "_fixed"
    name_root = name + "_root"

    prost_proto_deps = kwargs.get("prost_proto_deps", [])
    prost_proto_compiled_targets = _prepare_prost_proto_deps(prost_proto_deps)

    rust_prost_proto_compile(
        name = name_pb,
        crate_name = name,
        prost_proto_deps = prost_proto_compiled_targets,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs or
               k in prost_compile_attrs
        }  # Forward args
    )

    # Fix up imports
    rust_proto_crate_fixer(
        name = name_fixed,
        compilation = name_pb,
    )

    rust_proto_crate_root(
        name = name_root,
        crate_dir = name_fixed,
    )

    # Create rust_prost library
    rust_library(
        name = name,
        edition = "2021",
        crate_root = name_root,
        crate_name = kwargs.get("crate_name"),
        srcs = [name_fixed],
        deps = kwargs.get("prost_deps", [_crate("prost"), _crate("prost-types")]) +
               kwargs.get("pbjson_deps", [_crate("pbjson-types"), _crate("pbjson")]) +
               kwargs.get("serde_deps", [_crate("serde")]) +
               kwargs.get("deps", []) +
               prost_proto_deps,
        proc_macro_deps = [kwargs.get("prost_derive_dep", _crate("prost-derive"))],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )
