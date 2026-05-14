"""Common support for rules_proto_grpc Rust rules."""

load("@rules_proto_grpc//:defs.bzl", "proto_compile")

RustProtoInfo = provider(
    doc = "Additional information needed by Rust proto compilation rules.",
    fields = {
        "crate_name": "Name of the crate that wraps this module.",
        "declared_proto_packages": "All proto packages that this compile rule generates bindings for.",
    },
)

rust_compile_attrs = [
    "declared_proto_packages",
    "crate_name",
    "proto_deps",
]

def crate_label(name):
    """Convert a crate package name into its generated crate-universe label."""
    return Label("@rules_proto_grpc_rust_crates//:" + name)

def prepare_rust_proto_deps(proto_deps):
    """Return compile targets for Rust proto deps passed to Rust library macros."""
    rust_proto_compiled_targets = []

    for dep in proto_deps:
        dep = str(dep)
        if dep.endswith("_pb"):
            rust_proto_compiled_targets.append(dep)
        else:
            rust_proto_compiled_targets.append(dep + "_pb")

    return rust_proto_compiled_targets

def rust_proto_compile_impl(ctx):
    """Implements Rust proto compile rules."""
    externs = []
    for dep in ctx.attr.proto_deps:
        if RustProtoInfo not in dep:
            continue

        proto_info = dep[RustProtoInfo]
        dep_crate = proto_info.crate_name

        for package in proto_info.declared_proto_packages:
            externs.append("extern_path={}=::{}::{}".format(
                "." + package,
                dep_crate,
                package.replace(".", "::"),
            ))

    options = dict(ctx.attr.options)
    proto_plugin = "@rules_proto_grpc_rust//:rust_proto_plugin"
    options[proto_plugin] = options.get(proto_plugin, []) + externs

    compile_result = proto_compile(
        ctx,
        options,
        getattr(ctx.attr, "extra_protoc_args", []),
        ctx.files.extra_protoc_files,
    )

    return compile_result + [RustProtoInfo(
        declared_proto_packages = ctx.attr.declared_proto_packages,
        crate_name = ctx.attr.crate_name or ctx.attr.name,
    )]
