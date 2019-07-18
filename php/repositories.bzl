load(
    "//grpc:repositories.bzl",
    "grpc_repos",
)

def php_repos(**kwargs):
    grpc_repos(**kwargs)
