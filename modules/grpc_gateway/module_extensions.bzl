"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Gateway plugin
    for version, platform, hash in [
        # renovate-gh-plugin: grpc-ecosystem/grpc-gateway
        ("v2.27.1", "darwin-arm64", "6ab92035bd36b53aee1042c5a8171262b4e1454291eeee236abc784de8b4d93c"),
        ("v2.27.1", "darwin-x86_64", "a45802ac181faf06f0052bf2f60d827a1ae29e5d453399f7445df10accc3a37c"),
        ("v2.27.1", "linux-arm64", "837e835946219837064ce691c007d045d10977ea3a4ea70b0ea5e2ead196bcda"),
        ("v2.27.1", "linux-x86_64", "74b7f8711097d544de49f4db0894941f8952139b5e75106365f3af1c47696649"),
        ("v2.27.1", "windows-arm64", "6b36d5d997eed1165f36d79c151b3b4a2f6aaaa4403dced328eceb90fe92c5dc"),
        ("v2.27.1", "windows-x86_64", "dcab0a838e4be5d2ad930f69f45bc22ecfd084bdd5a513abb4ea485a9bb0c36f"),
    ]:
        http_file(
            name = "grpc_gateway_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/{0}/protoc-gen-grpc-gateway-{0}-{1}{2}".format(
                version,
                platform,
                ".exe" if "windows" in platform else "",
            ),
        )

    # Openapi plugin
    for version, platform, hash in [
        # renovate-gh-plugin: grpc-ecosystem/grpc-gateway
        ("v2.27.1", "darwin-arm64", "3b73e2b833c2183bbc2419bdaed067155d2d7c34eaf7d4596366430a9f19f18f"),
        ("v2.27.1", "darwin-x86_64", "ea0d6b31fe5301c4b516851ecd13aaac42d5e763be8525a234f35fc69facbaa6"),
        ("v2.27.1", "linux-arm64", "3510db1ea197d4ff9456cdac90ecfdbadd018858d6d73b9e5031257474aac284"),
        ("v2.27.1", "linux-x86_64", "d163c53e0f1506c109ed4452f6cedf2440af6ff15d621be34144da7e996e2327"),
        ("v2.27.1", "windows-arm64", "92c9ad298f3732fb3821bf7621d5e8358f691a7ccef1a4714b736a409a4bb0d2"),
        ("v2.27.1", "windows-x86_64", "57531b762f6db6d03e65dafb691cad1aeb853f477ceda372c5a2809984e54926"),
    ]:
        http_file(
            name = "openapiv2_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/{0}/protoc-gen-openapiv2-{0}-{1}{2}".format(
                version,
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
