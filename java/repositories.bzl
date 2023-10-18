"""Common dependencies for rules_proto_grpc Java rules."""

load(
    "//:repositories.bzl",
    "io_grpc_grpc_java",
    "rules_jvm_external",
    "rules_proto_grpc_repos",
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

def java_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    protobuf_deps()
    io_grpc_grpc_java(**kwargs)
    rules_jvm_external(**kwargs)
