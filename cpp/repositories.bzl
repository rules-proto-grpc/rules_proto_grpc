load(
    "//:repositories.bzl",
    "rules_proto_grpc_dependencies",
)

def cpp_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
