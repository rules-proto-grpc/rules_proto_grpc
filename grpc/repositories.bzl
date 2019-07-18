load(
    "//:repositories.bzl",
    "com_github_grpc_grpc",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def grpc_repos(**kwargs):
    protobuf_repos(**kwargs)
    com_github_grpc_grpc(**kwargs)
