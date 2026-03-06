"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""
    for version, platform, hash in [
        # renovate-maven-plugin: io.grpc:protoc-gen-grpc-java
        ("1.79.0", "darwin-arm64", "7b0dcbe2cbc02ebaf03e571eb295f43c0ba3d919b5d9e8fe34015846c9887289"),
        ("1.79.0", "darwin-x86_64", "7b0dcbe2cbc02ebaf03e571eb295f43c0ba3d919b5d9e8fe34015846c9887289"),
        ("1.79.0", "linux-arm64", "445b924ba4d3f55abd651f71017d592552be706b3918af0d7837b70468137473"),
        ("1.79.0", "linux-x86_64", "3d16b70b18854988b29c41e20d06ca3358c47008edb9e6986b926c5bca790816"),
        ("1.79.0", "windows-x86_64", "37a04cc3a35680bf17ba08e89d694d292f028e6f7ba24ef4b5bd8a1c43fa2e52"),
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
