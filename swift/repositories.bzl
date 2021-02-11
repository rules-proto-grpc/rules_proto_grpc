load(
    "//:repositories.bzl",
    "build_bazel_apple_support",
    "build_bazel_rules_swift",
    "com_github_grpc_grpc_swift_patched",
    "rules_proto_grpc_repos",
)

def swift_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    build_bazel_rules_swift(**kwargs)
    build_bazel_apple_support(**kwargs)
    com_github_grpc_grpc_swift_patched(**kwargs)
