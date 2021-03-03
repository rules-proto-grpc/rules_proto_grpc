"""Common dependencies for rules_proto_grpc Buf rules."""

load(
    "//:repositories.bzl",
    "protoc_gen_buf_breaking_darwin",
    "protoc_gen_buf_breaking_linux",
    "protoc_gen_buf_lint_darwin",
    "protoc_gen_buf_lint_linux",
    "rules_proto_grpc_repos",
)

def buf_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    protoc_gen_buf_breaking_darwin(**kwargs)
    protoc_gen_buf_breaking_linux(**kwargs)
    protoc_gen_buf_lint_darwin(**kwargs)
    protoc_gen_buf_lint_linux(**kwargs)
