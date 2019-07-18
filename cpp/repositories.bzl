load(
    "//grpc:repositories.bzl",
    "grpc_repos",
)

def cpp_repos(**kwargs):
    grpc_repos(**kwargs)
