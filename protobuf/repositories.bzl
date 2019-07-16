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
    native.register_toolchains(str(Label("//protobuf:protoc_toolchain")))

def protobuf(**kwargs): # Kept for backwards compatibility
    protobuf_repos(**kwargs)
