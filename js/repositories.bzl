"""Common dependencies for rules_proto_grpc JavaScript rules."""

load(
    "//:repositories.bzl",
    "build_bazel_rules_nodejs",
    "rules_proto_grpc_repos",
)

def js_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    build_bazel_rules_nodejs(**kwargs)