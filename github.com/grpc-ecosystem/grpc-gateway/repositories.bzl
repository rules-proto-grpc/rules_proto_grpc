load(
    "//:repositories.bzl",
    "bazel_gazelle",
    "com_github_bazelbuild_buildtools",
    "grpc_ecosystem_grpc_gateway",
    "io_bazel_rules_go",
    "rules_proto_grpc_repos",
)
load("@bazel_gazelle//:deps.bzl", "go_repository")

def gateway_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    io_bazel_rules_go(**kwargs)
    bazel_gazelle(**kwargs)
    com_github_bazelbuild_buildtools(**kwargs)
    grpc_ecosystem_grpc_gateway(**kwargs)
