load(
    "//:repositories.bzl",
    "com_google_protobuf",
    "io_grpc_grpc_java",
    "javax_annotation_javax_annotation_api",
    "com_google_errorprone_error_prone_annotations",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)

def java_repos(**kwargs):
    protobuf_repos(**kwargs)
    io_grpc_grpc_java(**kwargs)
    javax_annotation_javax_annotation_api(**kwargs)
    com_google_errorprone_error_prone_annotations(**kwargs)
