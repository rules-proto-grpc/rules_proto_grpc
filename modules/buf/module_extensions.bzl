"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.69.0", "darwin-arm64", "8e9f35344f88a702ae8e66d26de423d718a27ec533dae4953001289238d32fe3"),
        ("v1.69.0", "darwin-x86_64", "f1ef10521f4b1b989ffd2b20fd6e74c69ed6f169dfda40ce06f497318b380a8d"),
        ("v1.69.0", "linux-arm64", "f26075522ae19394d122c4ad26a4b5d24e043f308bac6c50dbf40f9651e5d7a4"),
        ("v1.69.0", "linux-x86_64", "52071a228745ed7fb96e628c2390938a97ad8cfa737dc3250442de7649d799fb"),
        ("v1.69.0", "windows-arm64", "e60fd1efb1f55ba5dcca8209c09aa4c0eda4076a371a4566b174553d8bfab87e"),
        ("v1.69.0", "windows-x86_64", "63c51f0ede21a8fe3637d62594260018f9cb65974e2db55e4b6576c11eb79807"),
    ]:
        http_file(
            name = "buf_breaking_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/{0}/protoc-gen-buf-breaking-{1}{2}".format(
                version,
                ("linux-aarch64" if platform == "linux-arm64" else platform).title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    # Lint plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.69.0", "darwin-arm64", "a22c6af04172387a992d14c6b881c3d38a316a8172457ed47b63dabd866b9ca2"),
        ("v1.69.0", "darwin-x86_64", "3777f36b1dea2f7062d8fad8423c092c514268d21bd4b00d705d1c6aed778cda"),
        ("v1.69.0", "linux-arm64", "10aec96386e3dd8b515e3da006b805f0c7e68de66242eb9f21a85ec0c33ec5f1"),
        ("v1.69.0", "linux-x86_64", "ea77b92fc8b6f3f725cbff1d81dd8cd391ded47993016214f3f6cafed1a3cd6e"),
        ("v1.69.0", "windows-arm64", "3284dcb0f54972f590aab7c2ccdb2c1f5563e4a77e3e468be7d3375ffa5461ff"),
        ("v1.69.0", "windows-x86_64", "1be50c3bc6290efcc9ff438d761364d7d92f261abfda7d02966edc0953a9f7c1"),
    ]:
        http_file(
            name = "buf_lint_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/{0}/protoc-gen-buf-lint-{1}{2}".format(
                version,
                ("linux-aarch64" if platform == "linux-arm64" else platform).title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    return module_ctx.extension_metadata(
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

download_plugins = module_extension(
    implementation = _download_plugins,
)
