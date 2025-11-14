"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.60.0", "darwin-arm64", "ccfcc8d34e8f0b3d5b47913f4d1c9993cff5750d4047b7af0c17a83ca8d67dc0"),
        ("v1.60.0", "darwin-x86_64", "99bb1ecc126f30f54007db0ba45486331fa342bbd6b2f7ee511416799f70b2ea"),
        ("v1.60.0", "linux-arm64", "5f727a68db0c909abfb7d661517ceb83885c00eb95bc0bd62ce20ce6167655ac"),
        ("v1.60.0", "linux-x86_64", "cd28660f958f4eb8e4ef9a49a3368d6b4eea752110000598b67eb4a6d3be10f9"),
        ("v1.60.0", "windows-arm64", "028c837ea890484fcfa818cd8a0200160ac531836f43373fa8224e5f1b4f3760"),
        ("v1.60.0", "windows-x86_64", "b12cc1ca1a9abaa3d1c26a696dcc0b05febc4485b804f24ab6d673f530ffc2cf"),
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
        ("v1.60.0", "darwin-arm64", "918c33e3850b6cc4e31a3322a5a3bb02b0055ef22e3783a8bc536a8680b807da"),
        ("v1.60.0", "darwin-x86_64", "eb87abb79ab898d06c5851e300024c72651395819898600d7d23eb00cb974838"),
        ("v1.60.0", "linux-arm64", "f95162264dec9fe61e4500bb2ec5d6a9706b14499ca0aa592509668d9e8e6f7a"),
        ("v1.60.0", "linux-x86_64", "b24045378a658de38b69093012696464ce927879f46e8410ddded66ee5f6d4a1"),
        ("v1.60.0", "windows-arm64", "b5db42cd0c0969b97cb297627682a01c747cbd653a6852c2be2be83f6f9c3b21"),
        ("v1.60.0", "windows-x86_64", "c3c79eb7609bf73f0d22122d7075ed7896775ef6a9e829afc1afae4f6891c0f5"),
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
