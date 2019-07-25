load("//ruby:ruby_proto_compile.bzl", "ruby_proto_compile")
load("@com_github_yugui_rules_ruby//ruby:def.bzl", "ruby_library")

def ruby_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    ruby_proto_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create ruby library
    ruby_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = ["@rules_proto_grpc_gems//:libs"],
        includes = [name_pb], # This does not presently work as expected, as it is workspace relative. See https://github.com/yugui/rules_ruby/pull/8
        visibility = kwargs.get("visibility"),
    )
