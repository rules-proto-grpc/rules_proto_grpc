load(":repositories.bzl", "cpp_repos")

# NOTE: THE RULES IN THIS FILE ARE KEPT FOR BACKWARDS COMPATIBILITY ONLY.
#       Please use the rules in repositories.bzl

def cpp_proto_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    cpp_repos(**kwargs)

def cpp_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    cpp_repos(**kwargs)

def cpp_proto_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    cpp_repos(**kwargs)

def cpp_grpc_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    cpp_repos(**kwargs)
