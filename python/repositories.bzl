load(
    "//:repositories.bzl",
    "com_github_grpc_grpc",
    "com_apt_itude_rules_pip",
    "subpar",
    "six",
)
load(
    "//grpc:repositories.bzl",
    "grpc_repos",
)

def python_repos(**kwargs):
    grpc_repos(**kwargs)
    subpar(**kwargs)
    six(**kwargs)
    com_apt_itude_rules_pip(**kwargs)
