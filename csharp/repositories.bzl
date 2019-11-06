load(
    "//:repositories.bzl",
    "io_bazel_rules_dotnet",
    "rules_proto_grpc_repos",
)

def csharp_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    io_bazel_rules_dotnet(**kwargs)
