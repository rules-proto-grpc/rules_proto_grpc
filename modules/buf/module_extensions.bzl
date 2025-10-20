"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.59.0", "darwin-arm64", "964450d042053e2fdc1b863b9754c8c29be63a3d387472aaf35e5d3e3752614e"),
        ("v1.59.0", "darwin-x86_64", "4ff9d6ca3b163690999b4d31f6d6b3e5a391931895fdd099e0446ed2c631c13a"),
        ("v1.59.0", "linux-arm64", "b24b98166975f198a303f35a329ad4e9440241406bf6941a4e7c07978e6063f6"),
        ("v1.59.0", "linux-x86_64", "b6c5fa87c7013d8c5df3a790e8dad44bc80d9f266fe427447e34a60fad15d9d4"),
        ("v1.59.0", "windows-arm64", "8459cdf34938f363dd0ced0b1fde44013d5692c2b08103db23a52b0dc1a8b3d4"),
        ("v1.59.0", "windows-x86_64", "eebe79c981e823af6e89c2e7cd23379651f6aad45b8ce37ffb11838fceea55ef"),
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
        ("v1.59.0", "darwin-arm64", "44bdfe3c3d96aba7c3ed7feccdf7c4869ccddc94be57e5d92e2e72df6be0fd10"),
        ("v1.59.0", "darwin-x86_64", "97fd2fda1f4043d97854728456bd8eeb194ee06161a17d432e33a66276bb9d63"),
        ("v1.59.0", "linux-arm64", "3d9e897ae36a09ed88873ffeb32f1e43a83e29147f57cdf95ac291b3df1b98a3"),
        ("v1.59.0", "linux-x86_64", "06a2ae27ad2b493a8be5f2bfe9a6965a02b76111a58ffcbbc92317f062dcb864"),
        ("v1.59.0", "windows-arm64", "bd29d2667b5620db83922f0127d6bbae31bf36d9e8764e5398a52cec9e2bff05"),
        ("v1.59.0", "windows-x86_64", "0868404a7093d30ed0706bb78c87ce250928eaeba3a5a99ec061c3b2e7584f21"),
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
