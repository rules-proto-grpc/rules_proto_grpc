"""Generated definition of scala_proto_library."""

load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_scala//scala:scala.bzl", "scala_library")
load("@rules_scala_config//:config.bzl", "SCALA_VERSIONS")
load("//:scala_proto_compile.bzl", "scala_proto_compile")

def scala_proto_library(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    scala_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create scala library
    scala_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        exports = PROTO_DEPS + kwargs.get("exports", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

PROTO_DEPS = [
    Label("@rules_proto_grpc_scala_maven_common//:com_google_protobuf_protobuf_java"),
] + select({
    Label("@rules_scala_config//:scala_version_{}".format(scala_version.replace(".", "_"))): [
        Label("@rules_proto_grpc_scala_maven_{0}//:{1}_{0}".format(
            scala_version.replace(".", "_").rpartition("_")[0],
            package,
        )) for package in [
            "com_thesamet_scalapb_lenses",
            "com_thesamet_scalapb_scalapb_runtime",
        ]
    ]
    for scala_version in SCALA_VERSIONS
})
