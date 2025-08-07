"""Generated definition of csharp_grpc_library."""

load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:csharp_grpc_compile.bzl", "csharp_grpc_compile")

def csharp_grpc_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    csharp_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create csharp library
    csharp_library(
        name = name,
        srcs = [name_pb],
        target_frameworks = kwargs.get("target_frameworks", ["net8.0"]),
        deps = GRPC_DEPS + kwargs.get("deps", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs or k in [
                "resources",
                "out",
                "additionalfiles",
                "allow_unsafe_blocks",
                "analyzer_configs",
                "compile_data",
                "compiler_options",
                "defines",
                "exports",
                "generate_documentation_file",
                "internals_visible_to",
                "is_analyzer",
                "is_language_specific_analyzer",
                "keyfile",
                "langversion",
                "nowarn",
                "nullable",
                "project_sdk",
                "run_analyzers",
                "treat_warnings_as_errors",
                "warning_level",
                "warnings_as_errors",
                "warnings_not_as_errors",
            ]
        }  # Forward Bazel common args and rules_dotnet args
    )

GRPC_DEPS = [
    Label("@paket.main//google.protobuf"),
    Label("@paket.main//grpc.core.api"),
]

GRPC_CLIENT_DEPS = GRPC_DEPS + [
    Label("@paket.main//grpc.net.client"),
]

GRPC_SERVER_DEPS = GRPC_DEPS + [
    Label("@paket.main//grpc.aspnetcore.server"),
]
