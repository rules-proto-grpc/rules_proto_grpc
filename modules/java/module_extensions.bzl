"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""
    for platform, hash in [
        ("darwin-arm64", "dcee3d7720a92f247dbefc17288db878ad9981293db293c86a1afb6074935c53"),
        ("darwin-x86_64", "dcee3d7720a92f247dbefc17288db878ad9981293db293c86a1afb6074935c53"),
        ("linux-arm64", "308435e80ba288b0804b3e448b9ad97500b545f801297eb7ea142db8fe81fb9c"),
        ("linux-x86_64", "a9f9a7987be4a37c69a85e5e8885394356fd2f1a47f843c6461da4fc99f407b3"),
        ("windows-x86_64", "9d6659af976eb5ff664eb853bba25bcdf988500040227711bd87146c55241779"),
    ]:
        http_file(
            name = "grpc_java_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.65.0/protoc-gen-grpc-java-1.65.0-{}.exe".format(
                platform.replace("darwin", "osx").replace("arm64", "aarch_64"),
            ),
        )

    return module_ctx.extension_metadata(
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

download_plugins = module_extension(
    implementation = _download_plugins,
)
