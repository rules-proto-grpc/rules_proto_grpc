load(
    "//:repositories.bzl",
    "io_bazel_rules_go",
    "rules_proto_grpc_dependencies",
)

def go_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    io_bazel_rules_go(**kwargs)
