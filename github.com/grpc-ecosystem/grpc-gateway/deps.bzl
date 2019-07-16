load(":repositories.bzl", "gateway_repos")

# NOTE: THE RULES IN THIS FILE ARE KEPT FOR BACKWARDS COMPATIBILITY ONLY.
#       Please use the rules in repositories.bzl

def gateway_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    gateway_repos(**kwargs)

def gateway_grpc_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    gateway_repos(**kwargs)

def gateway_swagger_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    gateway_repos(**kwargs)
