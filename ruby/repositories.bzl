load(
    "//:repositories.bzl",
    "bazelruby_rules_ruby",
    "rules_proto_grpc_repos",
)

def ruby_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    bazelruby_rules_ruby(**kwargs)
