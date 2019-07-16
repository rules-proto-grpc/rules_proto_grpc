load(":repositories.bzl", "grpc_web_repos")

# NOTE: THE RULES IN THIS FILE ARE KEPT FOR BACKWARDS COMPATIBILITY ONLY.
#       Please use the rules in repositories.bzl

def closure_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    grpc_web_repos(**kwargs)

def commonjs_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    grpc_web_repos(**kwargs)

def commonjs_dts_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    grpc_web_repos(**kwargs)

def ts_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    grpc_web_repos(**kwargs)

def closure_grpc_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    grpc_web_repos(**kwargs)
