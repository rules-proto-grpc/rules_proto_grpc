load(
    "//:repositories.bzl",
    "rules_proto_grpc_dependencies",
)

def objc_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
