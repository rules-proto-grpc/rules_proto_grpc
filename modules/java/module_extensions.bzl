"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""
    for version, platform, hash in [
        # renovate-maven-plugin: io.grpc:protoc-gen-grpc-java
        ("1.74.0", "darwin-arm64", "7f286de20e82ea674a5cdf59b6012f056a6d0ee57eb2a85eda0cec4bc3db4761"),
        ("1.74.0", "darwin-x86_64", "7f286de20e82ea674a5cdf59b6012f056a6d0ee57eb2a85eda0cec4bc3db4761"),
        ("1.74.0", "linux-arm64", "b4d0525c624e38efbec104d027a555e7a256a96eaf3e409972777d659a4b1eb6"),
        ("1.74.0", "linux-x86_64", "bb6f37cbacea579cba9916d07b05b15beaaf9abdea271323fabdea4b6568f18c"),
        ("1.74.0", "windows-x86_64", "6c265e8cefbb2158b044807af1188ad303d35e973f562209f337f93a8198fa37"),
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
