"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""
    for platform, hash in [
        ("darwin-arm64", "24febbebd503a564b0b257e51514f6c871ea1feb44a48b593b078616f7b0a2b5"),
        ("darwin-x86_64", "24febbebd503a564b0b257e51514f6c871ea1feb44a48b593b078616f7b0a2b5"),
        ("linux-arm64", "40e1bc64dea38a1af5a4e40e3adbf0019957719f1e2a966024d4deac90986eab"),
        ("linux-x86_64", "94e2eeea024541be8d0d47396ff4bbedc98903309b32aaf54fa93355d1016838"),
        ("windows-x86_64", "d4741560c90932a3443b234dee9e52351c368a27c37766c34cdc95cab8d2b043"),
    ]:
        http_file(
            name = "grpc_java_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.72.0/protoc-gen-grpc-java-1.72.0-{}.exe".format(
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
