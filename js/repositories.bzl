"""Common dependencies for rules_proto_grpc JavaScript rules."""

load(
    "//:repositories.bzl",
    "build_bazel_rules_nodejs",
    "grpc_web_plugin_darwin",
    "grpc_web_plugin_linux",
    "grpc_web_plugin_windows",
    "rules_proto_grpc_repos",
)

def js_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    build_bazel_rules_nodejs(**kwargs)
    grpc_web_plugin_darwin(**kwargs)
    grpc_web_plugin_linux(**kwargs)
    grpc_web_plugin_windows(**kwargs)
