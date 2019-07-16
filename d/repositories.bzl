load(
    "//:repositories.bzl",
    "io_bazel_rules_d",
    "com_github_dcarp_protobuf_d",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def d_repos(**kwargs):
    protobuf_repos(**kwargs)
    com_github_dcarp_protobuf_d(**kwargs)
    io_bazel_rules_d(**kwargs)
