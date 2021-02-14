"""Generated definition of gateway_grpc_library."""

load("//grpc-gateway:gateway_grpc_compile.bzl", "gateway_grpc_compile")
load("@io_bazel_rules_go//go:def.bzl", "go_library")
load("//go:go_grpc_library.bzl", "GRPC_DEPS")

def gateway_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    gateway_grpc_compile(
        name = name_pb,
        prefix_path = kwargs.get("importpath", ""),
        **{k: v for (k, v) in kwargs.items() if k in ("protos" if "protos" in kwargs else "deps", "verbose")}  # Forward args
    )

    # Create go library
    go_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + GATEWAY_DEPS + GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        importpath = kwargs.get("importpath"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GATEWAY_DEPS = [
    "@org_golang_google_protobuf//proto:go_default_library",
    "@org_golang_google_grpc//grpclog:go_default_library",
    "@org_golang_google_grpc//metadata:go_default_library",
    "@grpc_ecosystem_grpc_gateway//runtime:go_default_library",
    "@grpc_ecosystem_grpc_gateway//utilities:go_default_library",
    "@go_googleapis//google/api:annotations_go_proto",
]
