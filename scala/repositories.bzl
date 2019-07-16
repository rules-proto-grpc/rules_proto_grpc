load(
    "//:repositories.bzl",
    "com_github_scalapb_scalapb",
    "io_bazel_rules_go",
    "io_bazel_rules_scala",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def scala_repos(**kwargs):
    protobuf_repos(**kwargs)
    io_bazel_rules_go(**kwargs)
    io_bazel_rules_scala(**kwargs)
    com_github_scalapb_scalapb(**kwargs)
