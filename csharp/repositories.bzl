load(
    "//:repositories.bzl",
    "io_bazel_rules_dotnet",
    "rules_proto_grpc_dependencies",
)

def csharp_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    io_bazel_rules_dotnet(**kwargs)
