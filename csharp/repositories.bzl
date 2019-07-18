load(
    "//:repositories.bzl",
    "io_bazel_rules_dotnet",
)
load(
    "//grpc:repositories.bzl",
    "grpc_repos",
)

def csharp_repos(**kwargs):
    grpc_repos(**kwargs)
    io_bazel_rules_dotnet(**kwargs)
