"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.66.0", "darwin-arm64", "c5580f0eb9202644bc29c774ced39dd8e5c96f701c69e9edb109c419be163330"),
        ("v1.66.0", "darwin-x86_64", "dd580578638ce0036a9581889e9af182ae4bf570155c18e9f3aa52899a4cfb94"),
        ("v1.66.0", "linux-arm64", "19ac04d38b2cec2cf8d5b13b1317b354987291d63a2f5c63c1d836aa8f910d25"),
        ("v1.66.0", "linux-x86_64", "feaab9ee6bfb0a74de79c519767d62543b30bff09a16efc95642e8c1e1339990"),
        ("v1.66.0", "windows-arm64", "6a0feae716523a97be0f3c8423241b0c04cd9077ad5fc48b27e7f0582b4eae40"),
        ("v1.66.0", "windows-x86_64", "5ef6e79b9802c99927854123df6dc162471ef7694c1b313dcc80bd86356b627e"),
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
        ("v1.66.0", "darwin-arm64", "30a8ff2cd578d84cedc400fe13e189643d5352f4d7f6002140a80d0e116185a1"),
        ("v1.66.0", "darwin-x86_64", "16a5fdfe8a18be3485b41ded41b015bb18b0391f48793b446cee8035372cfabb"),
        ("v1.66.0", "linux-arm64", "7b6878fde2136c822d1e70f01becb5bcd595d83096ca8ca93396a68f81f5876d"),
        ("v1.66.0", "linux-x86_64", "f19f7288c9afdb6fcb34ec022aa4e347f49dc8ce9cc5a5d166b6251619d45d13"),
        ("v1.66.0", "windows-arm64", "980d8abbf9c44dfdc64b51cfed36acab8e73237e8bb3773df34721673d25000a"),
        ("v1.66.0", "windows-x86_64", "22e0ec3e4a53be8e856408a886ac6c0bf19364dff9164e3cb4fdbe22c5ff1da0"),
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
