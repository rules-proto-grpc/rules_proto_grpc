"""Common dependencies for rules_proto_grpc Documentation rules."""

load(
    "//:repositories.bzl",
    "rules_proto_grpc_repos",
)
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def doc_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)

    # protoc-gen-doc plugin
    protoc_gen_doc_version = "1.4.1"
    go_version = "1.15.2"
    build_file_content = """exports_files(glob(["protoc-gen-doc*"]))"""
    http_archive(
        name = "protoc_gen_doc_darwin",
        urls = ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v{}/protoc-gen-doc-{}.darwin-amd64.go{}.tar.gz".format(protoc_gen_doc_version, protoc_gen_doc_version, go_version)],
        sha256 = "a5f7ad62d495b5a97a907b5445c23524a9cc312eeab486a79299819286a3f6b0",
        strip_prefix = "protoc-gen-doc-{}.darwin-amd64.go{}".format(protoc_gen_doc_version, go_version),
        build_file_content = build_file_content,
    )

    http_archive(
        name = "protoc_gen_doc_linux",
        urls = ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v{}/protoc-gen-doc-{}.linux-amd64.go{}.tar.gz".format(protoc_gen_doc_version, protoc_gen_doc_version, go_version)],
        sha256 = "2e476c67063af55a5608f7ef876260eb4ca400b330b762a4f59096db501c5c8c",
        strip_prefix = "protoc-gen-doc-{}.linux-amd64.go{}".format(protoc_gen_doc_version, go_version),
        build_file_content = build_file_content,
    )

    http_archive(
        name = "protoc_gen_doc_windows",
        urls = ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v{}/protoc-gen-doc-{}.windows-amd64.go{}.tar.gz".format(protoc_gen_doc_version, protoc_gen_doc_version, go_version)],
        sha256 = "6ac742671b81d339768a683dfb9a4c03ea5eaa0b6880d47df46819ea1ddb2653",
        strip_prefix = "protoc-gen-doc-{}.windows-amd64.go{}".format(protoc_gen_doc_version, go_version),
        build_file_content = build_file_content,
    )
