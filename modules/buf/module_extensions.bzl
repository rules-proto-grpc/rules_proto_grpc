"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.73.0", "darwin-arm64", "39c7a21fd44c3d72a71485394239c3b47a621bae9155599d63c3ae0928e7909d"),
        ("v1.73.0", "darwin-x86_64", "0266db9baa915c96a812ce7ddfd11d4b67d6ce499acc0f28018e002661e92b02"),
        ("v1.73.0", "linux-arm64", "e22fbc36e11eaab6dcf467a76f18275916d910aa0e7919ae7db1843674515393"),
        ("v1.73.0", "linux-x86_64", "9d7e0566e0eb1639b61fcd45442b8307a9c671b8d7b3e50091b7f633346f632a"),
        ("v1.73.0", "windows-arm64", "29a6d966fb4b994451a901bdb16168092674241440e1cf45c9af438c101aaece"),
        ("v1.73.0", "windows-x86_64", "f1f4f7ca28bb399bef205a16d3f0be3af41416bc2c195460b2363908a2404427"),
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
        ("v1.73.0", "darwin-arm64", "4656bab020f6acf36d45b2f88c5d523f5ccd81cae2bb3a3b756e5fcd1f17e539"),
        ("v1.73.0", "darwin-x86_64", "5ae931626f77fdc831310d3ce21dde9d8093be432ef51ef52e2830b1d18b42fc"),
        ("v1.73.0", "linux-arm64", "07cab965fb2a641f1bd89d0d42a3d3cf0f3c8c2ecd849706de7bd1c72439040f"),
        ("v1.73.0", "linux-x86_64", "16b33e1fd910d633e2f18eafae724a985dce300383188e37af2441c5dbaecace"),
        ("v1.73.0", "windows-arm64", "0230f2aa8ca753df751ef912c3c03256ce6adaeff0dbb6413f32f9c5eafd4395"),
        ("v1.73.0", "windows-x86_64", "2523d874fdd00f873faba4016ef5684e150af2c6074e61e3c392524ea8380359"),
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
