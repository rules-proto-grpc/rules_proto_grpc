load(
    "//:repositories.bzl",
    "com_github_grpc_grpc",
    "build_bazel_rules_nodejs",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def nodejs_repos(**kwargs):
    protobuf_repos(**kwargs)
    com_github_grpc_grpc(**kwargs)
    build_bazel_rules_nodejs(**kwargs)
