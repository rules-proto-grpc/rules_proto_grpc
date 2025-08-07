"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""
    for version, platform, hash in [
        # renovate-maven-plugin: io.grpc:protoc-gen-grpc-java
        ("1.74.0", "darwin-arm64", "<insert new hash here>"),
        ("1.74.0", "darwin-x86_64", "<insert new hash here>"),
        ("1.74.0", "linux-arm64", "<insert new hash here>"),
        ("1.74.0", "linux-x86_64", "<insert new hash here>"),
        ("1.74.0", "windows-x86_64", "<insert new hash here>"),
    ]:
        http_file(
            name = "grpc_java_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/{0}/protoc-gen-grpc-java-{0}-{1}.exe".format(
                version,
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
