"""Generated definition of js_grpc_web_library."""

load("//js:js_grpc_web_compile.bzl", "js_grpc_web_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def js_grpc_web_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    js_grpc_web_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create js library
    js_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = kwargs.get("name"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@js_modules//google-protobuf",
    "@js_modules//grpc-web",
]
