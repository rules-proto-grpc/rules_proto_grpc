load(
    "//:repositories.bzl",
    "build_bazel_rules_swift",
    "rules_proto_grpc_dependencies",
)

def swift_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    build_bazel_rules_swift(**kwargs)
