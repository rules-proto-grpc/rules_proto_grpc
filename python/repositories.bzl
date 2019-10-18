load(
    "//:repositories.bzl",
    "com_apt_itude_rules_pip",
    "subpar",
    "six",
    "rules_proto_grpc_dependencies",
)

def python_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    subpar(**kwargs)
    six(**kwargs)
    com_apt_itude_rules_pip(**kwargs)
