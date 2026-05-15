"""Helpers for assembling Rust crates from isolated protoc plugin output.

rules_proto_grpc runs each protoc plugin in a separate action and then merges
the resulting output trees. The Rust plugin stack emits sibling files such as
`foo.rs`, `foo.serde.rs`, and `foo.tonic.rs`; Rust does not discover those
siblings automatically. The fixer rule copies the merged tree and appends the
needed `include!` statements so serde and gRPC code is part of the crate.
"""

load("@rules_proto_grpc//:defs.bzl", "ProtoCompileInfo")

def _rust_proto_crate_root(ctx):
    """Writes a crate root that includes the fixed Rust output tree.

    Args:
        ctx: Rule context.

    Returns:
        A `DefaultInfo` provider containing the generated crate root file.
    """
    name = ctx.attr.crate_dir
    lib_rs = ctx.actions.declare_file("%s_lib.rs" % name)
    ctx.actions.write(
        lib_rs,
        '#![allow(clippy::all)]\ninclude!("%s/mod.rs");' % name,
        False,
    )
    return [DefaultInfo(
        files = depset([lib_rs]),
    )]

def _rust_proto_crate_fixer(ctx):
    """Adds module includes for sibling Rust files emitted by plugins.

    The core merger materializes tree artifacts as symlinks, so the copy must
    dereference links before editing. Each base `*.rs` file is updated to
    include matching `*.serde.rs` and `*.tonic.rs` siblings when they exist.

    Args:
        ctx: Rule context.

    Returns:
        A `DefaultInfo` provider containing the fixed output tree.
    """
    compilation = ctx.attr.compilation[ProtoCompileInfo]
    in_dir = compilation.output_dirs.to_list()[0]
    out_dir = ctx.actions.declare_directory("%s_fixed" % compilation.label.name)

    ctx.actions.run_shell(
        outputs = [out_dir],
        inputs = [in_dir],
        arguments = [in_dir.path, out_dir.path],
        command = """
set -eu

cp -RL "$1"/. "$2"/
chmod -R +w "$2"

find "$2" -type f ! -name 'mod.rs' ! -name '*.serde.rs' ! -name '*.tonic.rs' | while read -r base; do
    dir="$(dirname "$base")"
    module="$(basename "${base%.rs}")"
    for generated in "$dir/$module".serde.rs "$dir/$module".tonic.rs; do
        if [ -f "$generated" ]; then
            printf 'include!("%s");\n' "$(basename "$generated")" >> "$base"
        fi
    done
done
""",
    )

    return [DefaultInfo(
        files = depset([out_dir]),
    )]

rust_proto_crate_root = rule(
    doc = "Writes the crate root used by Rust proto and gRPC library rules.",
    implementation = _rust_proto_crate_root,
    attrs = {
        "crate_dir": attr.string(
            doc = "Directory containing the fixed generated Rust module tree.",
            mandatory = True,
        ),
    },
)

rust_proto_crate_fixer = rule(
    doc = "Copies generated Rust output and wires serde/gRPC sibling files into each module.",
    implementation = _rust_proto_crate_fixer,
    attrs = {
        "compilation": attr.label(
            doc = "Rust proto compile target whose output tree should be fixed.",
            providers = [ProtoCompileInfo],
            mandatory = True,
        ),
    },
)
