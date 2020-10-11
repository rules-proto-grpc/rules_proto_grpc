load("//d:d_proto_compile.bzl", "d_proto_compile")
load("@io_bazel_rules_d//d:d.bzl", "d_library")

def d_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    d_proto_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create d library
    d_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS,
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_github_dcarp_protobuf_d//:protobuf",
]
