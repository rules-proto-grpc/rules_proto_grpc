"""Generated definition of android_proto_library."""

load("//android:android_proto_compile.bzl", "android_proto_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_android//android:rules.bzl", "android_library")

def android_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    android_proto_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create android library
    android_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        exports = PROTO_DEPS + kwargs.get("exports", []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf_javalite",
    Label("//android:well_known_protos"),  # Lite is missing gen_well_known_protos_java from protobuf, compile them manually
]
