"""Common dependencies for rules_proto_grpc Go rules."""

load(
    "//:repositories.bzl",
    "GRPC_VERSION",
    "rules_proto_grpc_repos",
)
load("@bazel_gazelle//:deps.bzl", "go_repository")

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

def go_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    protobuf_deps()

    go_repository(
        name = "org_golang_google_protobuf",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/protobuf",
        sum = "h1:d0NfwRgPtno5B1Wa6L2DAG+KivqkdutMf1UhdNx175w=",
        version = "v1.28.1",
    )

    go_repository(
        name = "org_golang_google_grpc",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/grpc",
        sum = "h1:32JY8YpPMSR45K+c3o6b8VL73V+rR8k+DeMIr4vRH8o=",
        version = "v{}".format(GRPC_VERSION),
    )

    go_repository(
        name = "org_golang_google_grpc_cmd_protoc_gen_go_grpc",
        importpath = "google.golang.org/grpc/cmd/protoc-gen-go-grpc",
        sum = "h1:TLkBREm4nIsEcexnCjgQd5GQWaHcqMzwQV0TX9pq8S0=",
        version = "v1.2.0",
    )

    # For validate
    go_repository(
        name = "com_github_envoyproxy_protoc_gen_validate",
        importpath = "github.com/envoyproxy/protoc-gen-validate",
        sum = "h1:FPFO7LWZ2pfphahSUMX8L5p/6FqSzRYRxq6V74eG8ZI=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_lyft_protoc_gen_star",
        importpath = "github.com/lyft/protoc-gen-star/v2",
        sum = "h1:/3+/2sWyXeMLzKd1bX+ixWKgEMsULrIivpDsuaF441o=",
        version = "v2.0.3",
    )

    go_repository(
        name = "com_github_iancoleman_strcase",
        importpath = "github.com/iancoleman/strcase",
        sum = "h1:05I4QRnGpI0m37iZQRuskXh+w77mr6Z41lwQzuHLwW0=",
        version = "v0.2.0",
    )

    go_repository(
        name = "com_github_spf13_afero",
        importpath = "github.com/spf13/afero",
        sum = "h1:41FoI0fD7OR7mGcKE/aOiLkGreyf8ifIOQmJANWogMk=",
        version = "v1.9.3",
    )
