"""Internal rules to fix up Rust protoc output."""

load("@rules_proto_grpc//:defs.bzl", "ProtoCompileInfo")

def _rust_proto_crate_root(ctx):
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
    implementation = _rust_proto_crate_root,
    attrs = {
        "crate_dir": attr.string(
            mandatory = True,
        ),
    },
)

rust_proto_crate_fixer = rule(
    implementation = _rust_proto_crate_fixer,
    attrs = {
        "compilation": attr.label(
            providers = [ProtoCompileInfo],
            mandatory = True,
        ),
    },
)
