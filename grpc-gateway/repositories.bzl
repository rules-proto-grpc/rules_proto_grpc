load(
    "//:repositories.bzl",
    "bazel_gazelle",
    "grpc_ecosystem_grpc_gateway",
    "io_bazel_rules_go",
    "rules_proto_grpc_repos",
)
load("@bazel_gazelle//:deps.bzl", "go_repository")

def gateway_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    io_bazel_rules_go(**kwargs)
    bazel_gazelle(**kwargs)
    grpc_ecosystem_grpc_gateway(**kwargs)

    go_repository(
        name = "org_golang_google_grpc_cmd_protoc_gen_go_grpc",
        importpath = "google.golang.org/grpc/cmd/protoc-gen-go-grpc",
        sum = "h1:M1YKkFIboKNieVO5DLUEVzQfGwJD30Nv2jfUgzb5UcE=",
        version = "v1.1.0",
    )
