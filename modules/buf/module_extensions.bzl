"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.61.0", "darwin-arm64", "24bd843440e3c74c49e86d8620b3f4ac80970b1f928d5eaad4710bdea9200646"),
        ("v1.61.0", "darwin-x86_64", "68a1ead598c528f48479e83263f900dc512f90a976fdb5dac684667e7668f8bd"),
        ("v1.61.0", "linux-arm64", "2cee7c6df4aef58b5cc4f1908381337254b03df9b7a08dd0b8d62e24c980722a"),
        ("v1.61.0", "linux-x86_64", "ee12f5fc372dc5d3aaaede9a6ab7c223b747817ec5ca0c080449270b94bf7cc1"),
        ("v1.61.0", "windows-arm64", "dd6d489a9b7449a3751df2d7ad1c9b29887c1a439f998dad85c7034692b907e4"),
        ("v1.61.0", "windows-x86_64", "8d32e7022fe6d966e4958c625ce3d6bac9ccea03c61f71779344944d6c8e588c"),
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
        ("v1.61.0", "darwin-arm64", "b02d731007bb1bb112e3c36dc1e8622dd345cbc25bc3e7fa9ea976f2fa740a72"),
        ("v1.61.0", "darwin-x86_64", "e395dcdb16a1d0324cfd7f4b7a09369283e392f931201261ab630c9bd3719680"),
        ("v1.61.0", "linux-arm64", "db2bb244d150f01f775b0ba6d824992bbacea8a6f0dc18e4231e7ad648e8caba"),
        ("v1.61.0", "linux-x86_64", "9530104f79325a26b0320548e7f749b4ae18115adb41c06ac9a871d58534a176"),
        ("v1.61.0", "windows-arm64", "527496e7dc43f8e8d5c1569deca83f00ba362305be91e9d39de2c184b6fe953e"),
        ("v1.61.0", "windows-x86_64", "264b0077102bc8813c1fc50f4a1eef5767bad8e906b1b04fb14fa1082bdc404a"),
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
