"""Backwards compat aliases for rules_proto_grpc Node.js rules."""

load("//js:defs.bzl", "js_grpc_node_compile", "js_grpc_node_library", "js_proto_compile", "js_proto_library")

def nodejs_proto_compile(**kwargs):
    print("Rule nodejs_proto_compile from @rules_proto_grpc//nodejs:defs.bzl has been deprecated, please use js_proto_compile from @rules_proto_grpc//js:defs.bzl instead")  # buildifier: disable=print
    js_proto_compile(**kwargs)

def nodejs_grpc_compile(**kwargs):
    print("Rule nodejs_grpc_compile from @rules_proto_grpc//nodejs:defs.bzl has been deprecated, please use js_grpc_node_compile from @rules_proto_grpc//js:defs.bzl instead")  # buildifier: disable=print
    js_grpc_node_compile(**kwargs)

def nodejs_proto_library(**kwargs):
    print("Rule nodejs_proto_library from @rules_proto_grpc//nodejs:defs.bzl has been deprecated, please use js_proto_library from @rules_proto_grpc//js:defs.bzl instead")  # buildifier: disable=print
    js_proto_library(**kwargs)

def nodejs_grpc_library(**kwargs):
    print("Rule nodejs_grpc_library from @rules_proto_grpc//nodejs:defs.bzl has been deprecated, please use js_grpc_node_library from @rules_proto_grpc//js:defs.bzl instead")  # buildifier: disable=print
    js_grpc_node_library(**kwargs)
