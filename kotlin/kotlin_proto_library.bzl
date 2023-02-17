"""Generated definition of kotlin_proto_library."""

load("//kotlin:kotlin_proto_compile.bzl", "kotlin_proto_compile")
load("//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//java:defs.bzl", "java_proto_library")
load("@io_bazel_rules_kotlin//kotlin:jvm.bzl", "kt_jvm_library")

def kotlin_proto_library(name, java_proto_target = None, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    kotlin_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create kotlin Java dependency library, if not provided
    if java_proto_target == None:
        java_proto_target = ":%s_DO_NOT_DEPEND_java_proto" % name

        java_proto_library(
            name = java_proto_target[1:],
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
        deps = PROTO_DEPS + [java_proto_target] + kwargs.get("deps", []),
        exports = PROTO_DEPS + [java_proto_target] + kwargs.get("exports", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf_java",
    "@com_google_protobuf//java/kotlin:shared_runtime",
]
