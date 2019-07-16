load(
    "//:repositories.bzl",
    "com_github_grpc_grpc",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def objc_repos(**kwargs):
    protobuf_repos(**kwargs)
    com_github_grpc_grpc(**kwargs)
