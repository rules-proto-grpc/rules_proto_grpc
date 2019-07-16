load(
    "//:repositories.bzl",
    "build_bazel_rules_android",
    "com_google_protobuf_javalite",
    "com_google_guava_guava_android",
    "com_google_protobuf",
    "io_grpc_grpc_java",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def android_repos(**kwargs):
    protobuf_repos(**kwargs)
    com_google_protobuf_javalite(**kwargs)
    io_grpc_grpc_java(**kwargs)
    build_bazel_rules_android(**kwargs)
    com_google_guava_guava_android(**kwargs)
