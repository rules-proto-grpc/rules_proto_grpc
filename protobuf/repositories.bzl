load(
    "//:repositories.bzl",
    "bazel_skylib",
    "com_google_protobuf",
    "external_zlib",
)

def protobuf_repos(**kwargs):
    bazel_skylib(**kwargs)
    com_google_protobuf(**kwargs)
    external_zlib(**kwargs)
