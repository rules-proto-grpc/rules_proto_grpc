"""Generated definition of mixed_grpc_compile."""

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_impl",
    "proto_compile_toolchains",
)

# Create compile rule
mixed_grpc_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("@rules_proto_grpc_csharp//:grpc_plugin"),  # Uses output_directory
                Label("@rules_proto_grpc_js//:grpc_plugin"),  # Uses fixer
                Label("@rules_proto_grpc_python//:grpc_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = proto_compile_toolchains,
)
