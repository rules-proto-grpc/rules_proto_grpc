"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.56.0", "darwin-arm64", "6d48f997a910238dfc28ace08ced92d5e775160ca7c07fd225021705b6d2ea8d"),
        ("v1.56.0", "darwin-x86_64", "b13b3ebe67fb2476d207524e45d80f8a8f08ab15a653cb9175119695d60e651e"),
        ("v1.56.0", "linux-arm64", "ded17fdd59c2058e06374b6cfc42ba089324edbd1ae05b2aa8a701593313b1d1"),
        ("v1.56.0", "linux-x86_64", "e91d7541e35a4f4fde6eb259e8f81d7c86bdfca0e004f15d4c9f57ffe67a0e5b"),
        ("v1.56.0", "windows-arm64", "63017979cf9c8835285b944fa2e8ad3f5520e1ddea54efd63ed3d98a0f2c0b10"),
        ("v1.56.0", "windows-x86_64", "7af7e04b31eb776d52d1e34e05d7d4a0f4ab2537ff003989eb291fa0e9aac955"),
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
        ("v1.56.0", "darwin-arm64", "1ac428989a6853fa54608a7fde96d6737ee91997d5990dde82c6e3e3ce72b867"),
        ("v1.56.0", "darwin-x86_64", "971e94a89244f360d213c4e5e21ca1475b12178ac6ad4e7aa26db83fc7ad2175"),
        ("v1.56.0", "linux-arm64", "0f0086518c7577ba113b83259e460e29e68e9e04028be54aa23ee6dd313c180b"),
        ("v1.56.0", "linux-x86_64", "c34f537d014fec4044c6c22f04fdc38d810840fdf77c75782042ab26bcd8fa6f"),
        ("v1.56.0", "windows-arm64", "7ab9099b4538bb4627d8b5657448c66ec7970c6baf04b90fcc4b2c9f80d4786f"),
        ("v1.56.0", "windows-x86_64", "e8c2bccdf398df16c0cf7aaadca61ad42ed61ff6511d1f48bf126884c88f56bd"),
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
