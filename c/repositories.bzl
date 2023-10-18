"""Common dependencies for rules_proto_grpc C rules."""

load(
    "//:repositories.bzl",
    "rules_proto_grpc_repos",
)
load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

def c_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    protobuf_deps()
