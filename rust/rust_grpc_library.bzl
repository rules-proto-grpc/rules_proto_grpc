"""Generated definition of rust_grpc_library."""

load("//rust:rust_grpc_compile.bzl", "rust_grpc_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("//rust:rust_proto_lib.bzl", "rust_proto_lib")
load("@rules_rust//rust:rust.bzl", "rust_library")

def rust_grpc_library(**kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    name_lib = kwargs.get("name") + "_lib"
    rust_grpc_compile(
        name = name_pb,
        **{
            k: v for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create lib file
    rust_proto_lib(
        name = name_lib,
        compilation = name_pb,
        grpc = True,
    )

    # Create rust library
    rust_library(
        name = kwargs.get("name"),
        srcs = [name_pb, name_lib],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    Label("//rust/raze:futures"),
    Label("//rust/raze:grpcio"),
    Label("//rust/raze:protobuf"),
    Label("//rust:ares"),
    Label("//rust:upb_libdescriptor_proto"),
]
