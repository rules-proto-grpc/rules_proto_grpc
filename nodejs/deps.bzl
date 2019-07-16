load(":repositories.bzl", "nodejs_repos")

# NOTE: THE RULES IN THIS FILE ARE KEPT FOR BACKWARDS COMPATIBILITY ONLY.
#       Please use the rules in repositories.bzl

def nodejs_proto_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    nodejs_repos(**kwargs)

def nodejs_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    nodejs_repos(**kwargs)

def nodejs_proto_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    nodejs_repos(**kwargs)

def nodejs_grpc_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    nodejs_repos(**kwargs)
