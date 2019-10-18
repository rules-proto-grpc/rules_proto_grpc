load(
    "//:repositories.bzl",
    "io_bazel_rules_closure",
    "rules_proto_grpc_dependencies",
)

def closure_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    io_bazel_rules_closure(**kwargs)
