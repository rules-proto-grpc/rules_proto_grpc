"""Generated definition of nodejs_grpc_library."""

load("//nodejs:nodejs_grpc_compile.bzl", "nodejs_grpc_compile")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def nodejs_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    nodejs_grpc_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("protos" if "protos" in kwargs else "deps", "verbose")}  # Forward args
    )

    # Create nodejs library
    js_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = kwargs.get("name"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@nodejs_modules//google-protobuf",
    "@nodejs_modules//@grpc/grpc-js",
]
