load(":repositories.bzl", "android_repos")

# NOTE: THE RULES IN THIS FILE ARE KEPT FOR BACKWARDS COMPATIBILITY ONLY.
#       Please use the rules in repositories.bzl

def android_proto_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    android_repos(**kwargs)

def android_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    android_repos(**kwargs)

def android_proto_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    android_repos(**kwargs)

def android_grpc_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    android_repos(**kwargs)
