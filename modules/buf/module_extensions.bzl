"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.57.0", "darwin-arm64", "53ee2f5f113f3101782e2109a10c3cd80ad56b8198b8f0a774d3c7b505000d5e"),
        ("v1.57.0", "darwin-x86_64", "2b0fc81df249ae48a630f2c0de562c48289770b3b86ce147ede4841b86867320"),
        ("v1.57.0", "linux-arm64", "858570f2c9c6658359e77b80747abd91567f8bfc1b3178ba0fe25bd90f37b9c4"),
        ("v1.57.0", "linux-x86_64", "aff57cee161b39536184763638fd2ff4ae4d4897b2e3f38983ea8330629db103"),
        ("v1.57.0", "windows-arm64", "60304423eb5eabf1b05d278f539bd3fde7762c4c848a30c9111e50c623db211e"),
        ("v1.57.0", "windows-x86_64", "173ef6988238c6a0eaa731e20b0381a3ae06c9a8b90ed6d89fccf5ecd78be993"),
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
        ("v1.57.0", "darwin-arm64", "edb4f407f230a3b6546344a9480c9e7c5bd8da6a39055b3b2d346b9cebe034a7"),
        ("v1.57.0", "darwin-x86_64", "fd8fd86e7dcc9a4c5556e2e1c7e88eeaacdf90464d398e0b5f9ced3b6ee46c30"),
        ("v1.57.0", "linux-arm64", "33446afab3e502617c571640f3d897af2cfbc727c27eb2e6611286b7f22d7468"),
        ("v1.57.0", "linux-x86_64", "a5cd325ca44d1e97bfc3f4062fcf04c18d73841a913debd23f5c87b91848118f"),
        ("v1.57.0", "windows-arm64", "4030ae08fdae26806dabfb938913bb95a4ae5bc2a21ee278d81872a5f1ab7dd8"),
        ("v1.57.0", "windows-x86_64", "8b026405766d4ce635bf02386e5286f59845dbbd8ede2dbacd2754058564513e"),
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
