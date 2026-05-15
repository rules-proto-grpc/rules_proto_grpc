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
    """Converts a crate package name into its generated crate-universe label.

    Args:
        name: Crate package name as it appears in `Cargo.toml`.

    Returns:
        A label for the generated crate target.
    """
    return Label("@rules_proto_grpc_rust_crates//:" + name)

def prepare_rust_proto_deps(proto_deps):
    """Returns compile targets for Rust proto deps passed to Rust libraries.

    Args:
        proto_deps: Rust proto library or compile labels passed to a library
            macro.

    Returns:
        A list of labels pointing at Rust proto compile targets.
    """
    rust_proto_compiled_targets = []

    for dep in proto_deps:
        dep = str(dep)
        if dep.endswith("_pb"):
            rust_proto_compiled_targets.append(dep)
        else:
            rust_proto_compiled_targets.append(dep + "_pb")

    return rust_proto_compiled_targets

def rust_proto_compile_impl(ctx):
    """Implements Rust proto and gRPC compile rules.

    Rust dependencies are crate-scoped, while proto dependencies are
    package-scoped. This implementation converts `proto_deps` metadata into
    `extern_path` options for the Rust protobuf plugin so generated code can
    refer to types from dependent Rust crates.

    Args:
        ctx: Rule context.

    Returns:
        The providers returned by `proto_compile` plus `RustProtoInfo`.
    """
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
