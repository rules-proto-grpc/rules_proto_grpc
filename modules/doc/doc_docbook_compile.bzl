"""Generated definition of doc_docbook_compile."""

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_impl",
    "proto_compile_toolchains",
)

# Create compile rule
doc_docbook_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//:docbook_plugin"),
            ],
            cfg = "exec",
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = proto_compile_toolchains,
)
