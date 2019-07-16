load(":repositories.bzl", "scala_repos")

# NOTE: THE RULES IN THIS FILE ARE KEPT FOR BACKWARDS COMPATIBILITY ONLY.
#       Please use the rules in repositories.bzl

def scala_proto_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    scala_repos(**kwargs)

def scala_grpc_compile(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    scala_repos(**kwargs)

def scala_proto_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    scala_repos(**kwargs)

def scala_grpc_library(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    scala_repos(**kwargs)
