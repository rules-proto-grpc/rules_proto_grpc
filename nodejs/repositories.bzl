load(
    "//:repositories.bzl",
    "build_bazel_rules_nodejs",
    "rules_proto_grpc_dependencies",
)

def nodejs_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    build_bazel_rules_nodejs(**kwargs)
