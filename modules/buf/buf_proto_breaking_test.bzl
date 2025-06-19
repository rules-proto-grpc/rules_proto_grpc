"""Generated definition of buf_proto_breaking_test."""

load("@protobuf//bazel/common:proto_info.bzl", "ProtoInfo")
load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_toolchains",
)
load("@rules_shell//shell:sh_test.bzl", "sh_test")
load(
    ":buf.bzl",
    "TEST_ATTRS",
    "buf_proto_breaking_test_script_impl",
)

buf_proto_breaking_test_script = rule(
    implementation = buf_proto_breaking_test_script_impl,
    attrs = dict(
        protos = attr.label_list(
            providers = [ProtoInfo],
            default = [],
            mandatory = True,
            doc = "List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``@protobuf``)",
        ),
        against_input = attr.label(
            allow_single_file = [".bin", ".json"],
            mandatory = True,
            doc = "Label of an existing input image file to check against (.json or .bin)",
        ),
        use_rules = attr.string_list(
            default = ["FILE"],
            mandatory = False,
            doc = "List of Buf breaking rule IDs or categories to use",
        ),
        except_rules = attr.string_list(
            default = [],
            mandatory = False,
            doc = "List of Buf breaking rule IDs or categories to drop",
        ),
        ignore_unstable_packages = attr.bool(
            default = False,
            mandatory = False,
            doc = "Whether to ignore breaking changes in unstable package versions",
        ),
        options = attr.string_list(
            doc = "Extra options to pass to plugins",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//:breaking_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = proto_compile_toolchains,
)

def buf_proto_breaking_test(name, **kwargs):
    buf_proto_breaking_test_script(
        name = name + ".sh",
        **{k: v for k, v in kwargs.items() if k not in TEST_ATTRS}
    )

    sh_test(
        name = name,
        srcs = [name + ".sh"],
        **{k: v for k, v in kwargs.items() if k in TEST_ATTRS}
    )
