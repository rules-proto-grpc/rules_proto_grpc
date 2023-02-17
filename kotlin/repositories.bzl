"""Common dependencies for rules_proto_grpc Kotlin rules."""

load(
    "//:repositories.bzl",
    "com_github_grpc_grpc_kotlin",
    "io_bazel_rules_kotlin",
)

def kotlin_repos(**kwargs):  # buildifier: disable=function-docstring
    io_bazel_rules_kotlin(**kwargs)
    com_github_grpc_grpc_kotlin(**kwargs)

#    rules_proto_grpc_repos(**kwargs)
#    io_grpc_grpc_java(**kwargs)
#    rules_jvm_external(**kwargs)
