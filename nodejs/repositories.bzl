load(
    "//:repositories.bzl",
    "build_bazel_rules_nodejs",
)
load(
    "//grpc:repositories.bzl",
    "grpc_repos",
)

def nodejs_repos(**kwargs):
    grpc_repos(**kwargs)
    build_bazel_rules_nodejs(**kwargs)
