"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.72.0", "darwin-arm64", "7c6c0fbd20719527ab069e776e49b4ffb8a399e1744e8703e4ba40c2e1b0d01c"),
        ("v1.72.0", "darwin-x86_64", "085ad2e223b737b814c812420c789a7d3086c2022b39406f837eb22696700f71"),
        ("v1.72.0", "linux-arm64", "b356827be126bdadcbcef32607e93ec9aaeae0cce07bd24268b6b482540ac104"),
        ("v1.72.0", "linux-x86_64", "58cece373a057f6031bcbab1fdab1a774206b2ad15617fe61ae7bb1adda2b745"),
        ("v1.72.0", "windows-arm64", "42db61b56423ed415695a994fabaf846f6ddeb772ba521f793250e751d576b81"),
        ("v1.72.0", "windows-x86_64", "0f5982ac58302c59d137f0504bd98c0479d2ee49576faecf63c2fa02976d3de1"),
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
        ("v1.72.0", "darwin-arm64", "d0d21d1919dcc60959dfdf0ca3d7858c9526d4fbbd4fbaf76d55dc5d70a72aa2"),
        ("v1.72.0", "darwin-x86_64", "d59b7a7be7d2f1943e4d79cd5f139085c26a024336e4c1d21d1504235dbc6648"),
        ("v1.72.0", "linux-arm64", "c30b669685398e0b8816db7bd070560276bb5bf067d1bb9a30efc194545c4936"),
        ("v1.72.0", "linux-x86_64", "6b50ee2ef0876c73ad430522ee98c7070e41eaabeba649256278bd8dc92571a1"),
        ("v1.72.0", "windows-arm64", "e5a7082dcf0f56fab22d37dc65a5a9746847feaca835e7beeb2ec026afb8ea4d"),
        ("v1.72.0", "windows-x86_64", "cd8d0a22916eca74fa69bfbb4a709e90425044c7e682ffabe01e628aa40f0b0b"),
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
