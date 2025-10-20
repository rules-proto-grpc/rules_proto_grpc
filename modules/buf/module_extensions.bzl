"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.58.0", "darwin-arm64", "683e4ca08ff0ac83b74e328717206249aeff91559a7e3072e5967a88b97d1630"),
        ("v1.58.0", "darwin-x86_64", "acd51b8b17b0748e6629b06d6579f205a892ac0f3079f2777670389a689784ed"),
        ("v1.58.0", "linux-arm64", "6c43e8fc5313197780e0a2e6ae1b85195ebe47f04e61fb431235fc9024efa7bc"),
        ("v1.58.0", "linux-x86_64", "d532fc05126373be37b2eda11fbeab9cc68f311fdb6140d8e8ff0c4b076b4b12"),
        ("v1.58.0", "windows-arm64", "c924021ad6c2acde097d24e90a5bd43c195d226dd48156d755d8d4f51382c7b8"),
        ("v1.58.0", "windows-x86_64", "f0bd65e2a78bf5e7bc3a7a1bb5ef14888ceffd6acc248222819c95a8e1728993"),
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
        ("v1.58.0", "darwin-arm64", "4ed0b01c45fa71aea29abfc616e7f919b3fd01f3dcb79544f14803795d19f15f"),
        ("v1.58.0", "darwin-x86_64", "5a7b5a6656f936fc939512c25e75f3123b73f3e8ad4d9fb313d06344d98dad3d"),
        ("v1.58.0", "linux-arm64", "70c18c8b6e6937886b446dcbd7aa687ce33b6792976bd2251c9c11dfa8cdc524"),
        ("v1.58.0", "linux-x86_64", "a07b1f3d5a3e86cf5c6e5951df06c5e64afbbe5bfbd8038f554051c4991deb32"),
        ("v1.58.0", "windows-arm64", "a4c2ca87f0f7bd5efe5e0a9d55d3ee658fe4325c8c944e7e570ead35377ce8c8"),
        ("v1.58.0", "windows-x86_64", "09c50899bc8359ebced11f026e1756ab18ddeddb33ec91824ff8691baa1955e3"),
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
