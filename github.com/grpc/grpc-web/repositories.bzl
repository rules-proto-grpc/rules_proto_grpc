load(
    "//:repositories.bzl",
    "com_github_grpc_grpc_web",
)
load(
    "//closure:repositories.bzl",
    "closure_repos",
)

def grpc_web_repos(**kwargs):
    closure_repos(**kwargs)
    com_github_grpc_grpc_web(**kwargs)
