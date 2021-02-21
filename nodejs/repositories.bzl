"""Backwards compat aliases for rules_proto_grpc Node.js repo rules."""

# TODO(4.0.0): Remove this folder
load(
    "//js:repositories.bzl",
    "js_repos",
)

def nodejs_repos(**kwargs):  # buildifier: disable=function-docstring
    print("Loading Javascript rules from @rules_proto_grpc//nodejs:repositories.bzl has been deprecated, please use @rules_proto_grpc//js:repositories.bzl instead")  # buildifier: disable=print
    js_repos(**kwargs)
