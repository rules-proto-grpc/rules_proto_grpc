load(
    "//:repositories.bzl",
    "rules_proto_grpc_repos",
    "six",
    "subpar",
)

def python_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    subpar(**kwargs)
    six(**kwargs)
