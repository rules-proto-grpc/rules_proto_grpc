"""Generated definition of ruby_grpc_library."""

load("//ruby:ruby_grpc_compile.bzl", "ruby_grpc_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@bazelruby_rules_ruby//ruby:defs.bzl", "ruby_library")

def ruby_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    ruby_grpc_compile(
        name = name_pb,
        **{
            k: v for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    # Create ruby library
    ruby_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = ["@rules_proto_grpc_bundle//:gems"] + (kwargs.get("deps", []) if "protos" in kwargs else []),
        includes = [native.package_name() + "/" + name_pb],
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )
