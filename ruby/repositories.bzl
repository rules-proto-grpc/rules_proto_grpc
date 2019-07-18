load(
    "//:repositories.bzl",
    "com_github_yugui_rules_ruby",
)
load(
    "//grpc:repositories.bzl",
    "grpc_repos",
)

def ruby_repos(**kwargs):
    grpc_repos(**kwargs)
    com_github_yugui_rules_ruby(**kwargs)
