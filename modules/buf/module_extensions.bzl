"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.67.0", "darwin-arm64", "46301b403c9a17da393b176ab85818d4bc291cacbf95e026d10ab26226a9316a"),
        ("v1.67.0", "darwin-x86_64", "5dcd2c6354f29ee20931a59c266953b33aa1171f8bc8fa7e422c0ea201da6257"),
        ("v1.67.0", "linux-arm64", "6ab60cfadef516d3e0676628c729f2fe3384f2a40e19fc6b9a743d33d8c9fdc2"),
        ("v1.67.0", "linux-x86_64", "8179f4100d1998c4edfff10d006c53e2c4b7ee366ed75af450ba3144578e0277"),
        ("v1.67.0", "windows-arm64", "4734c60548da21c5ed5b9b15a23cd2a34d522c1ce17ee914108beba2d72e3300"),
        ("v1.67.0", "windows-x86_64", "b287b4e04771d49870c0b317d1f95dc71c4568d94446721b4bcab45bf033f5ec"),
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
        ("v1.67.0", "darwin-arm64", "831e67af26bf63dc79db8568723c3d48528d0951daf9abe36e1c9994949b455b"),
        ("v1.67.0", "darwin-x86_64", "864a868ab4b3bb348c60e13a07e2d4cd2b38de80f2346bc0700bf7cbb812b510"),
        ("v1.67.0", "linux-arm64", "bf2a5fb49e5627b9aaeaa85ee7db6aaf8bf18625f406756f079854a55134b350"),
        ("v1.67.0", "linux-x86_64", "9faa4c709cb086201b9f61ddbd160c18cdd57e02c9d7237a1ac728e43b7dedf2"),
        ("v1.67.0", "windows-arm64", "e628915ca38a693634d97c6aea8667387a8d634f5ef1ced05f4468b8ad635e79"),
        ("v1.67.0", "windows-x86_64", "2dd7b3f395d3e9efa436344c2275ff6f550ed47e976be25b45f008a9fdc3a0c7"),
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
