load("//go:go_proto_compile.bzl", "go_proto_compile")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

def go_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    go_proto_compile(
        name = name_pb,
        prefix_path = kwargs.get("importpath", ""),
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create go library
    go_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + PROTO_DEPS,
        importpath = kwargs.get("importpath"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_github_golang_protobuf//proto:go_default_library",
    "@org_golang_google_protobuf//reflect/protoreflect:go_default_library",
    "@org_golang_google_protobuf//runtime/protoimpl:go_default_library",
]
