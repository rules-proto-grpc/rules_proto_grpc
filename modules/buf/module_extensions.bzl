"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.75.0", "darwin-arm64", "54749276ecb6f50d8bedc4f38a0a629bc69c9093044da551fb1595a06baf6ac6"),
        ("v1.75.0", "darwin-x86_64", "6dfcbd2d616fa84779d9bfb6388d0848a324979bf87aa0edcab129954c062d6e"),
        ("v1.75.0", "linux-arm64", "b5a394682105bbb4ba773cdffac8d1a184e4acce278b24899e90e2867008b22a"),
        ("v1.75.0", "linux-x86_64", "369ea71da6054161c53f0d447099e4b87652f6593dc7df44778e71f85423cdce"),
        ("v1.75.0", "windows-arm64", "6973fd1eeeb388eed8eb8f0e90a898a2a20d92733a51a26defecc9f300fb7449"),
        ("v1.75.0", "windows-x86_64", "5364896456a25e40ff2129e47c6179df5a89c877199cc99140666c1b55e62eea"),
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
        ("v1.75.0", "darwin-arm64", "d0b55335768908a8d20677d0465f46f7cc49f2a925f022ae9f58141654abbec0"),
        ("v1.75.0", "darwin-x86_64", "63e77e34bfba5b51aa4077c3943669e007f0761bbc4bb806a14dcd4b53a37d05"),
        ("v1.75.0", "linux-arm64", "0b37c11be47907771b70c4b1cd8b4eae951eb52b990ebd6460b1f3ab85393afb"),
        ("v1.75.0", "linux-x86_64", "162b91d73cfd99cd39bd2d740f1b99b2afe9309f2cfb568a15e53f7837604250"),
        ("v1.75.0", "windows-arm64", "5a8e5fb74e43ef8b1ba04a70633865b4edd779d732004ae06aa48c7aa7c8d8ab"),
        ("v1.75.0", "windows-x86_64", "84f7458808c02037d34864e28f525434c7cabffe91a46f517ac9a97128018826"),
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
