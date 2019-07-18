load(
    "//grpc:repositories.bzl",
    "grpc_repos",
)

def objc_repos(**kwargs):
    grpc_repos(**kwargs)
