"""Generated definition of cpp_proto_library."""

load("@rules_cc//cc:defs.bzl", "cc_library")
load("//cpp:cpp_proto_compile.bzl", "cpp_proto_compile")

def cpp_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    cpp_proto_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("protos" if "protos" in kwargs else "deps", "verbose")}  # Forward args
    )

    # Create cpp library
    cc_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        includes = [name_pb],
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf",
]
