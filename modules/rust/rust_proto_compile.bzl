"""Generated definition of rust_proto_compile."""

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_toolchains",
)
load(":common.bzl", "RustProtoInfo", "rust_compile_attrs", "rust_proto_compile_impl")

# Create compile rule
rust_proto_compile = rule(
    implementation = rust_proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        proto_deps = attr.label_list(
            providers = [RustProtoInfo],
            mandatory = False,
            doc = "Other Rust proto compile targets that this proto directly depends upon. Used to generate extern_path options.",
        ),
        declared_proto_packages = attr.string_list(
            mandatory = True,
            doc = "List of proto packages that this rule generates Rust bindings for.",
        ),
        crate_name = attr.string(
            mandatory = False,
            doc = "Name of the Rust crate these protos will be compiled into later using rust_library.",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//:rust_proto_plugin"),
                Label("//:rust_crate_plugin"),
                Label("//:rust_serde_plugin"),
            ],
            cfg = "exec",
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = proto_compile_toolchains,
)
