"""Common dependencies for rules_proto_grpc gRPC web rules."""

load(
    "//:repositories.bzl",
    "com_github_grpc_grpc_web",
)
load(
    "//closure:repositories.bzl",
    "closure_repos",
)

def grpc_web_repos(**kwargs):  # buildifier: disable=function-docstring
    closure_repos(**kwargs)
    com_github_grpc_grpc_web(**kwargs)
