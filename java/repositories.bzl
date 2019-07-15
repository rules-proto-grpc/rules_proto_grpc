load(
    "//:repositories.bzl",
    "com_google_protobuf",
    "io_grpc_grpc_java",
    "javax_annotation_javax_annotation_api",
    "com_google_errorprone_error_prone_annotations",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_deps",
)

def java_deps(**kwargs):
    protobuf_deps(**kwargs)
    io_grpc_grpc_java(**kwargs)
    javax_annotation_javax_annotation_api(**kwargs)
    com_google_errorprone_error_prone_annotations(**kwargs)

def java_proto_compile(**kwargs): # Kept for backwards compatibility
    java_deps(**kwargs)

def java_grpc_compile(**kwargs): # Kept for backwards compatibility
    java_deps(**kwargs)

def java_proto_library(**kwargs): # Kept for backwards compatibility
    java_deps(**kwargs)

def java_grpc_library(**kwargs): # Kept for backwards compatibility
    java_deps(**kwargs)
