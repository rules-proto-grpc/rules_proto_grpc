"""Common dependencies for rules_proto_grpc Documentation rules."""

load(
    "//:repositories.bzl",
    "protoc_gen_doc_darwin",
    "protoc_gen_doc_linux",
    "protoc_gen_doc_windows",
    "rules_proto_grpc_repos",
)

def doc_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    protoc_gen_doc_darwin(**kwargs)
    protoc_gen_doc_linux(**kwargs)
    protoc_gen_doc_windows(**kwargs)
