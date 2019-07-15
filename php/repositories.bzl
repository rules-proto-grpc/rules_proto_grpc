load(
    "//:repositories.bzl",
    "com_github_grpc_grpc",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_deps",
)

def php_deps(**kwargs):
    protobuf_deps(**kwargs)
    com_github_grpc_grpc(**kwargs)

def php_proto_compile(**kwargs): # Kept for backwards compatibility
    php_deps(**kwargs)

def php_grpc_compile(**kwargs): # Kept for backwards compatibility
    php_deps(**kwargs)
