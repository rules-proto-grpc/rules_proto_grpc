"""Common dependencies for rules_proto_grpc grpc-gateway rules."""

load(
    "//:repositories.bzl",
    "grpc_ecosystem_grpc_gateway",
)
load("//go:repositories.bzl", "go_repos")

def gateway_repos(**kwargs):  # buildifier: disable=function-docstring
    go_repos(**kwargs)
    grpc_ecosystem_grpc_gateway(**kwargs)
