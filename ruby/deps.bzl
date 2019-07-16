load(":repositories.bzl", "ruby_repos")

# NOTE: THE RULES IN THIS FILE ARE KEPT FOR BACKWARDS COMPATIBILITY ONLY.
#       Please use the rules in repositories.bzl

def ruby_proto_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    ruby_repos(**kwargs)

def ruby_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    ruby_repos(**kwargs)

def ruby_proto_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    ruby_repos(**kwargs)

def ruby_grpc_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    ruby_repos(**kwargs)
