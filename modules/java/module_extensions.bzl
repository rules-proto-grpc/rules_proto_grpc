"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""
    for platform, hash in [
        ("darwin-arm64", "800a366dcb22be30d5157e5c52fce78281e0a9300fb7edc78aeca7775eff293a"),
        ("darwin-x86_64", "800a366dcb22be30d5157e5c52fce78281e0a9300fb7edc78aeca7775eff293a"),
        ("linux-arm64", "b20759a1a48cecb80ae036db28f24edc5741037ed8017f3a99e68a0cb4223a68"),
        ("linux-x86_64", "ecb235d7913704ecf78e71dabe44016cdd21b232ae49b9d73408d7170fc3d782"),
        ("windows-x86_64", "c1953aa27ec0f387cf9bcc700fca4181293cf9f901d782ddbd66571278b3f0b5"),
    ]:
        http_file(
            name = "grpc_java_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.73.0/protoc-gen-grpc-java-1.73.0-{}.exe".format(
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
