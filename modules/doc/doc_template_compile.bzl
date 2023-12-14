"""Generated definition of doc_template_compile."""

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile",
    "proto_compile_attrs",
)

# Create compile rule
def doc_template_compile_impl(ctx):  # buildifier: disable=function-docstring
    # Load attrs that we pass as args
    options = ctx.attr.options
    extra_protoc_args = getattr(ctx.attr, "extra_protoc_args", [])
    extra_protoc_files = ctx.files.extra_protoc_files

    # Make mutable
    options = {k: v for (k, v) in options.items()}
    extra_protoc_files = [] + extra_protoc_files

    # Mutate args with template
    options["*"] = [
        ctx.file.template.path,
        ctx.attr.name,
    ]
    extra_protoc_files.append(ctx.file.template)

    # Execute with extracted attrs
    return proto_compile(ctx, options, extra_protoc_args, extra_protoc_files)

doc_template_compile = rule(
    implementation = doc_template_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        template = attr.label(
            allow_single_file = True,
            doc = "The documentation template file.",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//:template_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = ["@rules_proto_grpc//protoc:toolchain_type"],
)
