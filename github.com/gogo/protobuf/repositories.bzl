load(
    "//:repositories.bzl",
    "io_bazel_rules_go",
)

def gogo_repos(**kwargs):
    # Same as rules_go as rules_go is already loading gogo protobuf
    io_bazel_rules_go(**kwargs)
