"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Gateway plugin
    for platform, hash in [
        ("darwin-arm64", "58ded9b9e09c3675e6f7c8aff92888d4ec9d0f2f43e9064a31b96b1209f1cb21"),
        ("darwin-x86_64", "374dedecd796fa25ea799be2185541973958b9eab6508e1b74dd574a8cd9ddb4"),
        ("linux-arm64", "29e70d1be44b9ef67fab752ded51a6454671f4df6f8d1a8c4c4609ec88d86402"),
        ("linux-x86_64", "5b7745161cfb118905fa38734c701f4e542cdaa918fbb40060f8a22ab051e4cb"),
        ("windows-arm64", "761cd4252ed51bf2f8e458d994644d22d6a45fb78f2256e23bab82d2c6b456d3"),
        ("windows-x86_64", "9c7ee1adf99d84388ae66865e255a999052dd77351485de3670106cff059fbd8"),
    ]:
        http_file(
            name = "grpc_gateway_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.20.0/protoc-gen-grpc-gateway-v2.20.0-{}{}".format(
                platform,
                ".exe" if "windows" in platform else "",
            ),
        )

    # Openapi plugin
    for platform, hash in [
        ("darwin-arm64", "19f600e89ba7e8da3ef10df008bb4f732635901ef621621df209c20eef1288a4"),
        ("darwin-x86_64", "ad0ed31197aca464a1244660063928678afa57e69db67980e0c15314f4463c31"),
        ("linux-arm64", "f86b18c2771ca9965c1c6f1ac27f0a60e19e3a081e438162b438a3dba95f9030"),
        ("linux-x86_64", "34a47f85f9b009e01a366eb59a27542dca1177b6909727bc0d0ede2a5a1a74d2"),
        ("windows-arm64", "d8457397ea241e4d03b52ff0c5b7ac35f72aad87b77b942c6b276cf56de73b5f"),
        ("windows-x86_64", "4c78b8e80501925a539136f23e82379cd1d03c6b444965b16cbc5322d3a53b60"),
    ]:
        http_file(
            name = "openapiv2_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.20.0/protoc-gen-openapiv2-v2.20.0-{}{}".format(
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
