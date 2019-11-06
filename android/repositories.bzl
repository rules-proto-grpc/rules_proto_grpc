load(
    "//:repositories.bzl",
    "build_bazel_rules_android",
    "com_google_protobuf_javalite",
    "com_google_guava_guava_android",
    "com_google_protobuf",
    "io_grpc_grpc_java",
    "rules_proto_grpc_repos",
)

def android_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    com_google_protobuf_javalite(**kwargs)
    io_grpc_grpc_java(**kwargs)
    build_bazel_rules_android(**kwargs)
    com_google_guava_guava_android(**kwargs)
