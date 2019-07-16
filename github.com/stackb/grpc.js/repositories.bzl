load(
    "//:repositories.bzl",
    "com_github_stackb_grpc_js",
)
load(
    "//closure:repositories.bzl",
    "closure_repos",
)

def grpcjs_repos(**kwargs):
    closure_repos(**kwargs)
    com_github_stackb_grpc_js(**kwargs)
