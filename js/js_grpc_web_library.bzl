"""Generated definition of js_grpc_web_library."""

load("//js:js_grpc_web_compile.bzl", "js_grpc_web_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def js_grpc_web_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    js_grpc_web_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Resolve deps
    deps = [
        dep.replace("@npm", kwargs.get("deps_repo", "@npm"))
        for dep in GRPC_DEPS
    ]

    # Create js library
    js_library(
        name = name,
        srcs = [name_pb],
        deps = deps + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = name,
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@npm//google-protobuf",
    "@npm//grpc-web",
]
