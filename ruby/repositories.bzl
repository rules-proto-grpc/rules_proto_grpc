load(
    "//:repositories.bzl",
    "com_github_grpc_grpc",
    "com_github_yugui_rules_ruby",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def ruby_repos(**kwargs):
    protobuf_repos(**kwargs)
    com_github_grpc_grpc(**kwargs)
    com_github_yugui_rules_ruby(**kwargs)
