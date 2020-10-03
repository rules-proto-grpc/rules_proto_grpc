load("//nodejs:nodejs_proto_compile.bzl", "nodejs_proto_compile")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def nodejs_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    nodejs_proto_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create nodejs library
    js_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS,
        visibility = kwargs.get("visibility"),
    )

PROTO_DEPS = [
    "@nodejs_modules//google-protobuf",
]