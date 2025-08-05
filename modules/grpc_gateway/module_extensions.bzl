"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Gateway plugin
    for version, platform, hash in [
        # renovate-plugin: grpc-ecosystem/grpc-gateway
        ("v2.26.3", "darwin-arm64", "407fc00c44151a140bce4cd42311ff67b5c8bf2b32eb0c42aae315310eea4a16"),
        ("v2.26.3", "darwin-x86_64", "5876b7b9c96149f8bd5847f4d91154b8902f9854eedbf1a7c5c1f1ebb10ff0c5"),
        ("v2.26.3", "linux-arm64", "c07ecc2f0ea723b1a8e92281c3d3f37289ee0fc29fbd2219f3fdf7f974233e94"),
        ("v2.26.3", "linux-x86_64", "f7698dfa878b83d6a6387d03984afa419bed4b0c1439f1092db89034cd708318"),
        ("v2.26.3", "windows-arm64", "1bede7d7047affd2d27fc8faba01e378acf12429f3c6aa5038bd3251fcd83193"),
        ("v2.26.3", "windows-x86_64", "f9cbf31c32f220e267262df49d6469b3b06219f8c032820117cd71550687ff7b"),
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
        # renovate-plugin: grpc-ecosystem/grpc-gateway
        ("v2.26.3", "darwin-arm64", "370a77b54e71ad38831332b98747b138bd45f54f01b2c54798f8e4069e0152a8"),
        ("v2.26.3", "darwin-x86_64", "5c5afb23e819a33c942ad1c888d7913c4d766434e2db1b96a92931e5c2d6dc5a"),
        ("v2.26.3", "linux-arm64", "488e64eb06165545e213efc1fd9e06196dc88c9e2344c4b2b0d8e7a09538bd6a"),
        ("v2.26.3", "linux-x86_64", "a4eec19cfced95a71994c000f68b72038fba381a08266f0e9bb1931165a8aede"),
        ("v2.26.3", "windows-arm64", "532f7ea5994ee4a4a5bf9d05b974273e7b1bf1c1cc0a69af3bbb28de85388781"),
        ("v2.26.3", "windows-x86_64", "6a3027cbc39c258c66625f1b32c2b9ffcc42910e21cef00378ca65c200a31f51"),
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
