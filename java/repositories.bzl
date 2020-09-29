load(
    "//:repositories.bzl",
    "io_grpc_grpc_java",
    "rules_proto_grpc_repos",
)

def java_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    io_grpc_grpc_java(**kwargs)
