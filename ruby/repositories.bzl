load(
    "//:repositories.bzl",
    "com_github_yugui_rules_ruby",
    "rules_proto_grpc_dependencies",
)

def ruby_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    com_github_yugui_rules_ruby(**kwargs)
