"""Generated definition of kotlin_grpc_library."""

load("//kotlin:kotlin_grpc_compile.bzl", "kotlin_grpc_compile")
load("//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//java:defs.bzl", "java_grpc_library")
load("@io_bazel_rules_kotlin//kotlin:jvm.bzl", "kt_jvm_library")

def kotlin_grpc_library(name, java_grpc_target = None, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    kotlin_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create kotlin Java dependency library, if not provided
    if java_grpc_target == None:
        java_grpc_target = ":%s_DO_NOT_DEPEND_java_grpc" % name

        java_grpc_library(
            name = java_grpc_target[1:],
            **{
                k: v
                for (k, v) in kwargs.items()
                if k in proto_compile_attrs.keys() or
                   k in bazel_build_rule_common_attrs
            }  # Forward args
        )

    # Create kotlin library
    kt_jvm_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + [java_grpc_target] + kwargs.get("deps", []),
        exports = GRPC_DEPS + [java_grpc_target] + kwargs.get("exports", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

GRPC_DEPS = [
    # From https://github.com/grpc/grpc-java/blob/f6c2d221e2b6c975c6cf465d68fe11ab12dabe55/BUILD.bazel#L32-L38
    "@io_grpc_grpc_java//api",
    "@io_grpc_grpc_java//protobuf",
    "@io_grpc_grpc_java//stub",
    "@io_grpc_grpc_java//stub:javax_annotation",
    "@com_github_grpc_grpc_kotlin//stub/src/main/java/io/grpc/kotlin:stub",
    "@com_github_grpc_grpc_kotlin//stub/src/main/java/io/grpc/kotlin:context",
    "@com_google_code_findbugs_jsr305//jar",
    "@com_google_guava_guava//jar",
    "@com_google_protobuf//:protobuf_java",
    "@com_google_protobuf//:protobuf_java_util",
    "@com_google_protobuf//java/kotlin:shared_runtime",
]
