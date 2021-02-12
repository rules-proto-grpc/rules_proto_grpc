load("//ruby:ruby_grpc_compile.bzl", "ruby_grpc_compile")
load("@bazelruby_rules_ruby//ruby:defs.bzl", "ruby_library")

def ruby_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    ruby_grpc_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create ruby library
    ruby_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = ["@rules_proto_grpc_bundle//:gems"],
        includes = [name_pb], # This does not presently work as expected, as it is workspace relative. See https://github.com/yugui/rules_ruby/pull/8
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )
