"""Common dependencies for rules_proto_grpc C# rules."""

load(
    "//:repositories.bzl",
    "io_bazel_rules_dotnet",
    "rules_proto_grpc_repos",
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

def csharp_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    io_bazel_rules_dotnet(**kwargs)
    protobuf_deps()
