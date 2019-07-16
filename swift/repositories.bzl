load(
    "//:repositories.bzl",
    "build_bazel_rules_swift",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def swift_repos(**kwargs):
    protobuf_repos(**kwargs)
    build_bazel_rules_swift(**kwargs)
