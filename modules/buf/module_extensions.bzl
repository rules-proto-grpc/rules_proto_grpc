"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.74.0", "darwin-arm64", "196390f3de9df35cc4a7728d2cc43341826b6263217f3b61994984d19947d910"),
        ("v1.74.0", "darwin-x86_64", "c533f4d9feb031316d2e1974216ce715ca67977326845b7439deb766e1a0c3c4"),
        ("v1.74.0", "linux-arm64", "616a0f1686e99f933636315758c01fed0ab783e8f6a974b11e24809396d5c283"),
        ("v1.74.0", "linux-x86_64", "3c648017ff6128b7e757dcb2a172bcf2253d7fb724a4ebae8210d5ca6f954432"),
        ("v1.74.0", "windows-arm64", "1154359298db78cf2cc0a6c0d0fb7addc01772adf0e72cf6e38b06f1edce6ac4"),
        ("v1.74.0", "windows-x86_64", "a4a5be504c0674fc20c7346e073ab5979adbd2b1b929ae31b61a825b512c1e2a"),
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
        ("v1.74.0", "darwin-arm64", "635df05c29147e444a5dce3d945e2a189366831d42a65a495c1bb3a53de6b9eb"),
        ("v1.74.0", "darwin-x86_64", "c383cb1cdf958ab07be0a8967c6e8f85e5c877e9691ef1dbe95ce114bfb44201"),
        ("v1.74.0", "linux-arm64", "7af4f7c45a08ce8950d07babedd8a3093f5624f96a380a737e5a87d5c3c185fc"),
        ("v1.74.0", "linux-x86_64", "ba31eb65fc65c303ee90e332423e72d622cdb017fd4f5499cb49e09717230194"),
        ("v1.74.0", "windows-arm64", "f7fb9c9dc7585cff3c3444500ffe0d15397dcda5c0b12da5c27db00a52d8bc37"),
        ("v1.74.0", "windows-x86_64", "dcde0acd4dfc7a4e2b1c438ceb9927a7f4ad23d3eadd6194771fb949e98401f4"),
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
