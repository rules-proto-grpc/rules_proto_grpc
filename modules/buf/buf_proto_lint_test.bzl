"""Generated definition of buf_proto_lint_test."""

load("@rules_proto//proto:defs.bzl", "ProtoInfo")
load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
)
load(
    ":buf.bzl",
    "TEST_ATTRS",
    "buf_proto_lint_test_script_impl",
)

buf_proto_lint_test_script = rule(
    implementation = buf_proto_lint_test_script_impl,
    attrs = dict(
        protos = attr.label_list(
            providers = [ProtoInfo],
            mandatory = True,
            doc = "List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``rules_proto``)",
        ),
        use_rules = attr.string_list(
            default = ["DEFAULT"],
            mandatory = False,
            doc = "List of Buf lint rule IDs or categories to use",
        ),
        except_rules = attr.string_list(
            default = [],
            mandatory = False,
            doc = "List of Buf lint rule IDs or categories to drop",
        ),
        enum_zero_value_suffix = attr.string(
            default = "_UNSPECIFIED",
            mandatory = False,
            doc = "Specify the allowed suffix for the zero enum value",
        ),
        rpc_allow_same_request_response = attr.bool(
            default = False,
            mandatory = False,
            doc = "Allow request and response message to be reused in a single RPC",
        ),
        rpc_allow_google_protobuf_empty_requests = attr.bool(
            default = False,
            mandatory = False,
            doc = "Allow request message to be ``google.protobuf.Empty``",
        ),
        rpc_allow_google_protobuf_empty_responses = attr.bool(
            default = False,
            mandatory = False,
            doc = "Allow response message to be ``google.protobuf.Empty``",
        ),
        service_suffix = attr.string(
            default = "Service",
            mandatory = False,
            doc = "The suffix to allow for services",
        ),
        options = attr.string_list(
            doc = "Extra options to pass to plugins",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//:lint_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("@rules_proto_grpc//protoc:toolchain_type"))],
)

def buf_proto_lint_test(name, **kwargs):
    buf_proto_lint_test_script(
        name = name + ".sh",
        **{k: v for k, v in kwargs.items() if k not in TEST_ATTRS}
    )

    native.sh_test(
        name = name,
        srcs = [name + ".sh"],
        **{k: v for k, v in kwargs.items() if k in TEST_ATTRS}
    )
