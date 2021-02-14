"""Common dependencies for rules_proto_grpc Closure rules."""

load(
    "//:repositories.bzl",
    "io_bazel_rules_closure",
    "rules_proto_grpc_repos",
)

def closure_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    io_bazel_rules_closure(**kwargs)
