load(
    "//:repositories.bzl",
    "rules_proto_grpc_repos",
)

def objc_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
