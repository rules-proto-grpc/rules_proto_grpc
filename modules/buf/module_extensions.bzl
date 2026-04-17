"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.68.2", "darwin-arm64", "3101bab06719daea9423a8db4d87a1a05ac7cca33bc245a300bc6fbf74115122"),
        ("v1.68.2", "darwin-x86_64", "a12e48bfe08669ed15e1cb7b40088f5cfd5bf6de170c5d5e14f0c18994a7e8be"),
        ("v1.68.2", "linux-arm64", "6723331991ec0da9407b7eaad0db32ca0b445b4ac04b871ec5e70182bca3e166"),
        ("v1.68.2", "linux-x86_64", "0293c8e61cdd3b0ca5d252371fda912b92652a346ba13093269f9fe09f845e35"),
        ("v1.68.2", "windows-arm64", "8f52302ec1366ba26ba02abc96f4939bafa6ae24140d2c90c890322baf05175f"),
        ("v1.68.2", "windows-x86_64", "7da64abb1161842831c164ff27382b747eacacc68a135c719c26bf5ef29470da"),
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
        ("v1.68.2", "darwin-arm64", "ab5cfe2ce0c3850a3811c9d557fac8159f32597ce46b1fc4dcc5d076af6c2122"),
        ("v1.68.2", "darwin-x86_64", "ef5513f6304c75c49e3f5f439131921c5de2698873c27bcf7798a674ec08e399"),
        ("v1.68.2", "linux-arm64", "1772878877c6f8b49a7fb49ae3cdf984c26851da55a5481845693caa9bba3c93"),
        ("v1.68.2", "linux-x86_64", "59fbc5a055dc85f0730a294c70b97c118a262d7a9381f54b420659c0bff462cd"),
        ("v1.68.2", "windows-arm64", "27dd521c10d95c94949be77ab854343eaf00423959c1c86bc18d2eb348e54940"),
        ("v1.68.2", "windows-x86_64", "f3ebb2b929db8bdb3402ab66f1a3d2e304185520939671d1bd38e1c3c9a5f357"),
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
