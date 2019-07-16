load(
    "//:repositories.bzl",
    "com_github_grpc_grpc",
    "io_bazel_rules_dotnet",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def csharp_repos(**kwargs):
    protobuf_repos(**kwargs)
    com_github_grpc_grpc(**kwargs)
    io_bazel_rules_dotnet(**kwargs)
