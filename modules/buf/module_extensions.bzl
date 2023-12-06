"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for platform, hash in [
        ("darwin-arm64", "a5929461e23192ea04e8f97ed514b5ceff48c4a6194f3fc2516f205480c97eec"),
        ("darwin-x86_64", "9068a57353b125edde2975f958a83765511aa1f112310a6dc931c776b49f06d4"),
        ("linux-arm64", "85a9c602f87ef320ef8753751b1fb6ca646761e7e5dde1ec91e778e6ad955466"),
        ("linux-x86_64", "6cb7fc3adf9cd439cb47625d00055bd0e6d3d6a9f2e4208a07547724a2d8f01f"),
        ("windows-arm64", "25dec21dbc9d611aba63165621672eda0bc0554e88dbdd15d4f03cd5544ccb73"),
        ("windows-x86_64", "6a3600d531e6cf83278a3103d5423f13342348121bd0c25781ef00d005071bb0"),
    ]:
        http_file(
            name = "buf_breaking_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/v1.28.1/protoc-gen-buf-breaking-{}{}".format(
                platform.title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    # Lint plugin
    for platform, hash in [
        ("darwin-arm64", "d9a431b75f80f77b188ff824e42cadc1ed5d0a85283560012c21ed0a3b9b5a0a"),
        ("darwin-x86_64", "17b6e2c03ac5a5d2d4a94ef08241d1971a89c465454deeb190948b4cd9862d3a"),
        ("linux-arm64", "565b3738f9df064aa782998465458d86078f4e68b61138b65d5fbd9a23f1f331"),
        ("linux-x86_64", "d2d5f59fb847942166bffd1b757181fbe72bfd12f025ff4a094c98ab484ab060"),
        ("windows-arm64", "cd704651b76c92dc58d40718bad3a2c098429259714c51a93743c43a9aa633c0"),
        ("windows-x86_64", "e13228611e5ac63f3694aa33cbbf2a4cd7b59a2d6a888db84ea519081105b2ad"),
    ]:
        http_file(
            name = "buf_lint_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/v1.28.1/protoc-gen-buf-lint-{}{}".format(
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
