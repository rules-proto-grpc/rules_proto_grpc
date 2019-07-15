load(
    "//:repositories.bzl",
    "com_github_scalapb_scalapb",
    "io_bazel_rules_go",
    "io_bazel_rules_scala",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_deps",
)

def scala_deps(**kwargs):
    protobuf_deps(**kwargs)
    io_bazel_rules_go(**kwargs)
    io_bazel_rules_scala(**kwargs)
    com_github_scalapb_scalapb(**kwargs)

def scala_proto_compile(**kwargs): # Kept for backwards compatibility
    scala_deps(**kwargs)

def scala_grpc_compile(**kwargs): # Kept for backwards compatibility
    scala_deps(**kwargs)

def scala_proto_library(**kwargs): # Kept for backwards compatibility
    scala_deps(**kwargs)

def scala_grpc_library(**kwargs): # Kept for backwards compatibility
    scala_deps(**kwargs)
