"""Common dependencies for rules_proto_grpc D rules."""

load(
    "//:repositories.bzl",
    "com_github_dcarp_protobuf_d",
    "io_bazel_rules_d",
    "rules_proto_grpc_repos",
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

def d_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    protobuf_deps()
    com_github_dcarp_protobuf_d(**kwargs)
    io_bazel_rules_d(**kwargs)
