load(
    "//:repositories.bzl",
    "build_bazel_rules_swift",
    "rules_proto_grpc_repos",
)

def swift_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    build_bazel_rules_swift(**kwargs)
