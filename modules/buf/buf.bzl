"""Common rule implemenation for applying Buf plugins."""

load("@bazel_skylib//lib:shell.bzl", "shell")
load("@protobuf//bazel/common:proto_info.bzl", "ProtoInfo")
load("@rules_proto_grpc//internal:common.bzl", "descriptor_proto_path")
load("@rules_proto_grpc//internal:protoc.bzl", "build_protoc_args")
load("@rules_proto_grpc//internal:providers.bzl", "ProtoPluginInfo")

TEST_ATTRS = [
    # From https://bazel.build/reference/be/common-definitions#common-attributes-tests
    "args",
    "env",
    "env_inherit",
    "size",
    "timeout",
    "flaky",
    "shard_count",
    "local",
]

def buf_test_script_impl(ctx, options):
    """
    Common implementation function for buf rules.

    Args:
        ctx: The Bazel rule execution context object.
        options: The generated options to pass to the plugins.

    Returns:
        Providers:
            - DefaultInfo

    """

    # Load toolchain
    protoc_toolchain_info = ctx.toolchains[str(Label("@protobuf//bazel/private:proto_toolchain_type"))]
    protoc = protoc_toolchain_info.proto.proto_compiler.executable

    # Create test script header
    script_file = ctx.actions.declare_file(ctx.label.name)
    content = """#!/usr/bin/env bash
set -uo pipefail

"""

    # Load providers
    proto_infos = [dep[ProtoInfo] for dep in ctx.attr.protos]
    plugins = [plugin[ProtoPluginInfo] for plugin in ctx.attr._plugins]

    # Add a command for each plugin
    plugin_executables = []
    all_inputs = [ctx.file.against_input] if hasattr(ctx.file, "against_input") else []
    for plugin in plugins:
        # Get plugin
        plugin_executables.append(plugin.tool_provider.files_to_run.executable)

        # Get proto paths
        proto_paths = []  # The paths passed to protoc
        for proto_info in proto_infos:
            for proto in proto_info.direct_sources:
                proto_paths.append(descriptor_proto_path(proto, proto_info))

        # Build command
        args_list, cmd_inputs = build_protoc_args(
            ctx,
            plugin,
            proto_infos,
            ".",
            short_paths = True,
            extra_options = options,
        )
        all_inputs += cmd_inputs

        # Add source proto files as descriptor paths
        for proto_path in proto_paths:
            args_list.append(proto_path)

        content += "{} {}\n".format(shell.quote(protoc.short_path), " ".join([shell.quote(arg) for arg in args_list]))

    # Write test script
    ctx.actions.write(script_file, content, is_executable = True)

    return [
        DefaultInfo(
            runfiles = ctx.runfiles(
                files = [protoc] + plugin_executables + all_inputs,
            ),
            executable = script_file,
        ),
    ]

def buf_proto_breaking_test_script_impl(ctx):
    return buf_test_script_impl(ctx, [json.encode({
        "against_input": ctx.file.against_input.short_path,
        "limit_to_input_files": True,
        "input_config": {
            "version": "v1",
            "breaking": {
                "use": ctx.attr.use_rules,
                "except": ctx.attr.except_rules,
            },
        },
    })])

def buf_proto_lint_test_script_impl(ctx):
    return buf_test_script_impl(ctx, [json.encode({
        "input_config": {
            "version": "v1",
            "lint": {
                "use": ctx.attr.use_rules,
                "except": ctx.attr.except_rules,
                "enum_zero_value_suffix": ctx.attr.enum_zero_value_suffix,
                "rpc_allow_same_request_response": ctx.attr.rpc_allow_same_request_response,
                "rpc_allow_google_protobuf_empty_requests": ctx.attr.rpc_allow_google_protobuf_empty_requests,
                "rpc_allow_google_protobuf_empty_responses": ctx.attr.rpc_allow_google_protobuf_empty_responses,
                "service_suffix": ctx.attr.service_suffix,
            },
        },
    })])
