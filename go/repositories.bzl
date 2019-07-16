load(
    "//:repositories.bzl",
    "io_bazel_rules_go",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def go_repos(**kwargs):
    protobuf_repos(**kwargs)
    io_bazel_rules_go(**kwargs)
