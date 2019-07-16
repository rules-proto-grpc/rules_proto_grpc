load(":repositories.bzl", "protobuf_repos")

# NOTE: THE RULES IN THIS FILE ARE KEPT FOR BACKWARDS COMPATIBILITY ONLY.
#       Please use the rules in repositories.bzl

def protobuf(**kwargs):
    print("Import of rules in deps.bzl is deprecated, please use repositories.bzl")
    protobuf_repos(**kwargs)
