load(
    "//:repositories.bzl",
    "build_bazel_rules_nodejs",
    "rules_proto_grpc_repos",
)

def nodejs_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    build_bazel_rules_nodejs(**kwargs)
