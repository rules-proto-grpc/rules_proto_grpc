"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.57.2", "darwin-arm64", "0076bf9842bb16b9519553faa7860f815449820d9514b35ed8b00b2c987743aa"),
        ("v1.57.2", "darwin-x86_64", "d423796226472b7389be20e62a8860af2048e06977cb4227ef8a7bd927c22387"),
        ("v1.57.2", "linux-arm64", "5ae166f479e8cfb935950034d556b46495dfe315a1a368219924068e75637ccd"),
        ("v1.57.2", "linux-x86_64", "c5d1dde68bfe82302fae14186f8aee766f4e20b48d15e9e5793c202e35be22c0"),
        ("v1.57.2", "windows-arm64", "1d1347052f68404ff7c73765d85b13603e2550d814ecce2b800f1807cba97129"),
        ("v1.57.2", "windows-x86_64", "da32f4b215da357645a6a05ab5f52077cf0695b47be28bd7b60653da1dc72c5a"),
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
        ("v1.57.2", "darwin-arm64", "6d64fbc5f60d8c952e793ff1b21138f1a23dfab1d5a3b58cd7053e985511ff41"),
        ("v1.57.2", "darwin-x86_64", "458635f0265914371d2cb44af0a62e54c8a81000f968e918beacb4668e93917b"),
        ("v1.57.2", "linux-arm64", "a525a904f27f07872b969ab5f625faf3030814c42a0ffac97fe86b706cba9ebc"),
        ("v1.57.2", "linux-x86_64", "f3990cd6323ec33c677172e03fed45018a6bc7cbbc2544fad0d63f87d467b48c"),
        ("v1.57.2", "windows-arm64", "28c5102b401c11f35d3607e63cdde0841f5ef24e712337270550d522689eecf6"),
        ("v1.57.2", "windows-x86_64", "87f70fa1e5e9103e03c14774a0d2b7506e6608068b455b3acd758c9102f53347"),
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
