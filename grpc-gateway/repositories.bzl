"""Common dependencies for rules_proto_grpc grpc-gateway rules."""

load(
    "//:repositories.bzl",
    "bazel_gazelle",
    "grpc_ecosystem_grpc_gateway",
    "io_bazel_rules_go",
    "rules_proto_grpc_repos",
)
load("@bazel_gazelle//:deps.bzl", "go_repository")

def gateway_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    io_bazel_rules_go(**kwargs)
    bazel_gazelle(**kwargs)
    grpc_ecosystem_grpc_gateway(**kwargs)

    go_repository(
        name = "org_golang_google_grpc_cmd_protoc_gen_go_grpc",
        importpath = "google.golang.org/grpc/cmd/protoc-gen-go-grpc",
        sum = "h1:TLkBREm4nIsEcexnCjgQd5GQWaHcqMzwQV0TX9pq8S0=",
        version = "v1.2.0",
    )
