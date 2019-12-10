load("//github.com/grpc-ecosystem/grpc-gateway:gateway_grpc_compile.bzl", "gateway_grpc_compile")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

def gateway_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    gateway_grpc_compile(
        name = name_pb,
        prefix_path = kwargs.get("importpath", ""),
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create go library
    go_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + GRPC_DEPS,
        importpath = kwargs.get("importpath"),
        visibility = kwargs.get("visibility"),
    )

GRPC_DEPS = [
    "@com_github_golang_protobuf//descriptor:go_default_library",
    "@com_github_golang_protobuf//proto:go_default_library",
    "@com_github_golang_protobuf//protoc-gen-go/descriptor:go_default_library",
    "@org_golang_google_grpc//:go_default_library",
    "@org_golang_google_grpc//codes:go_default_library",
    "@org_golang_google_grpc//grpclog:go_default_library",
    "@org_golang_google_grpc//status:go_default_library",
    "@org_golang_x_net//context:go_default_library",
    "@grpc_ecosystem_grpc_gateway//runtime:go_default_library",
    "@grpc_ecosystem_grpc_gateway//utilities:go_default_library",
    "@go_googleapis//google/api:annotations_go_proto",
]
