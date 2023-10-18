"""Common dependencies for rules_proto_grpc Ruby rules."""

load(
    "//:repositories.bzl",
    "bazelruby_rules_ruby",
    "rules_proto_grpc_repos",
)
load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

def ruby_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    protobuf_deps()
    bazelruby_rules_ruby(**kwargs)
