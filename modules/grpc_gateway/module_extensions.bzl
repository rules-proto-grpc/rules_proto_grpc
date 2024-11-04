"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Gateway plugin
    for platform, hash in [
        ("darwin-arm64", "0e48d6e3e4fb963c10f473f59a3c25c26c43a0f243e3e58c8f60dd3c04b5edbe"),
        ("darwin-x86_64", "0ef400a43122717fef281a489c25b130afe073684ca4c7cbfd9903c45fdf62aa"),
        ("linux-arm64", "81af17fcd419f1259b42cdc016510d31cb245af859e07139c2f39b507de67e17"),
        ("linux-x86_64", "41c23df0e16766d3e2cfe4fbb42686fcf5e0eaa80f783ae724e66f8cbbeef4f1"),
        ("windows-arm64", "5132768f1d2783a2f3ea4330724975f619acb0305c4b28c0ab596bf2a92c1ea3"),
        ("windows-x86_64", "dc491c31bef60638b435384eaa1cd061b96fdfe28e761060a66df31905c81cda"),
    ]:
        http_file(
            name = "grpc_gateway_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.23.0/protoc-gen-grpc-gateway-v2.23.0-{}{}".format(
                platform,
                ".exe" if "windows" in platform else "",
            ),
        )

    # Openapi plugin
    for platform, hash in [
        ("darwin-arm64", "18bf438db4ea2aa627301718f634c279c83fd0a9ef950a0c427eb1767a62552e"),
        ("darwin-x86_64", "026effdd0134ac9984f7e2c6dd0ee5378fcd34d0b0727b1cd56ebed6e1cf239d"),
        ("linux-arm64", "d9de45b86bbe9347280247ec74937fb207e155e23e14f0a836428506d7f855a7"),
        ("linux-x86_64", "1d0a39fecc4fed7f90eeee1206f80e7dd6f566c265e55735d2e427da5db567d1"),
        ("windows-arm64", "8a1eab10a355a8a9e6b74c7079220f612122fbf5ac9f6a114f06619c55a5abe5"),
        ("windows-x86_64", "e04d4bbaf5c15ad2e94330d69c0f5e2af8472b32af851875966e55086140353e"),
    ]:
        http_file(
            name = "openapiv2_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.23.0/protoc-gen-openapiv2-v2.23.0-{}{}".format(
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
