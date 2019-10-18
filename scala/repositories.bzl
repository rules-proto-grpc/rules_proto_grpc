load(
    "//:repositories.bzl",
    "com_github_scalapb_scalapb",
    "io_bazel_rules_go",
    "io_bazel_rules_scala",
    "rules_proto_grpc_dependencies",
)

def scala_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    io_bazel_rules_go(**kwargs)
    io_bazel_rules_scala(**kwargs)
    com_github_scalapb_scalapb(**kwargs)
