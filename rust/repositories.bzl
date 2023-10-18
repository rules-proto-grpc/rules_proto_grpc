"""Common dependencies for rules_proto_grpc Rust rules."""

load(
    "//:repositories.bzl",
    "rules_proto_grpc_repos",
    "rules_rust",
)
load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

def rust_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    protobuf_deps()
    rules_rust(**kwargs)
