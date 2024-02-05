"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Gateway plugin
    for platform, hash in [
        ("darwin-arm64", "20955b51d70d2b1b087a3f5b1ea4a02205223114439b1854cc3f8bdae6663032"),
        ("darwin-x86_64", "5904c499067213c52906f5b19ec3d339317d678b3a570e7f70076be293bd148c"),
        ("linux-arm64", "069ec97a3d82522539979a68e9289a836c4564f7056de1e6e28c92c04ad5fbc4"),
        ("linux-x86_64", "2b1965cc8f0460426396237535744385442e318a59a9aac7ac7dcc02cf064676"),
        ("windows-arm64", "7be5fd9a84cf189ae1af81c9ca6449565ae6eb609d533ec4d1281dd1941b9ab4"),
        ("windows-x86_64", "37cc477a07f84aaaecef1953b662cb6fa3b862e98d7265583bff58deeca1343e"),
    ]:
        http_file(
            name = "grpc_gateway_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.19.0/protoc-gen-grpc-gateway-v2.19.0-{}{}".format(
                platform,
                ".exe" if "windows" in platform else "",
            ),
        )

    # Openapi plugin
    for platform, hash in [
        ("darwin-arm64", "0266146f5679edd2049ead78b4d6f8d58ff37be108b5452d28cc5e96d2a061c2"),
        ("darwin-x86_64", "46840e8062c11ea7d01ad8f3c5ad1e74dae3aba681f4e0f6c5756c6e322cccff"),
        ("linux-arm64", "99d03c4cc5efaf0fab38aa560e8bdb21d711f0f77c7c28a9ad864dbd63756b8d"),
        ("linux-x86_64", "41ea2f88eff81c3234675f596693353740b93ce80530f135af7702e0f6207ff8"),
        ("windows-arm64", "0709de83f8416f3ab3101eda3bedec2d5c153e33e1b69de6234291247c427b8a"),
        ("windows-x86_64", "3c4ec7b15f08814df8972adee6181e6cf6d0de810b40201d45aa2896c58dd000"),
    ]:
        http_file(
            name = "openapiv2_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.19.0/protoc-gen-openapiv2-v2.19.0-{}{}".format(
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
