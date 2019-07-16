load(
    "//:repositories.bzl",
    "io_bazel_rules_closure"
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def closure_repos(**kwargs):
    protobuf_repos(**kwargs)
    io_bazel_rules_closure(**kwargs)
