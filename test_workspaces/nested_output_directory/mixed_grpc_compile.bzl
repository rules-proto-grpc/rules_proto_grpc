"""Generated definition of mixed_grpc_compile."""

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_impl",
)

# Create compile rule
mixed_grpc_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("@rules_proto_grpc_cpp//:proto_plugin"),  # TODO: this needs replacing back with plugin that uses output_directory, like PHP
                Label("@rules_proto_grpc_python//:grpc_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("@rules_proto_grpc//protoc:toolchain_type"))],
)
