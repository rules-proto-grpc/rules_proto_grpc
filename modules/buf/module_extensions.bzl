"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for platform, hash in [
        ("darwin-arm64", "be1827ac7800534b621e91d487861b63b1373661c8ee44823f6a58073a18da3e"),
        ("darwin-x86_64", "0483d562c7ddaf992867ff325e8c0a44920870f94b2511bafc11930b5e0d5950"),
        ("linux-arm64", "6b36d2f551e0519229e5fcf4b76f2efc0a42fe1a7f0f2047bceaf583f127d60d"),
        ("linux-x86_64", "d07507a89ad13145e3469656271439e504f8a409ab07fb5c67d8c1eb1a91a50b"),
        ("windows-arm64", "430dca8233007387c4bff484c0a03792421097e7540914c3e72d4421b590da28"),
        ("windows-x86_64", "40e19f744d965c22bb300d497db58c7467c288127b202105a13fc8769280026d"),
    ]:
        http_file(
            name = "buf_breaking_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/v1.46.0/protoc-gen-buf-breaking-{}{}".format(
                platform.title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    # Lint plugin
    for platform, hash in [
        ("darwin-arm64", "6f3ee28236c788c1d4ea082ae895e499e7cd7afdd3f27e653e01839d4f0a07e5"),
        ("darwin-x86_64", "4fe24eaab20adf60f9a8002e46735d4274d728f710b2f9cf033ea216e0dc5b58"),
        ("linux-arm64", "8f684494b69b2542fa1ee0ba8a8a6105ed815076a0e35120bf97d5e6b1b476ad"),
        ("linux-x86_64", "b88f711535492d94dc813f86d78294593af7f8147e48dcf11b36c25f56547466"),
        ("windows-arm64", "e03286b354897a83434e78d993b811fe01f6a3a20bcd03990b4fbddaf1e06ff1"),
        ("windows-x86_64", "fe0efce687741caa6d832d0a2e744f2854d39b45321b15441250a7b1c0de78bb"),
    ]:
        http_file(
            name = "buf_lint_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/v1.46.0/protoc-gen-buf-lint-{}{}".format(
                platform,
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
