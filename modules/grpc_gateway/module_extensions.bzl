"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Gateway plugin
    for platform, hash in [
        ("darwin-arm64", "64a723cc08a88569505c56b6a40bc893dfb12869db40ea71dc4d1a9e649c4aad"),
        ("darwin-x86_64", "c9e173343b081ea723ec0fa4e857d47092f7b566a0dbed2f19e2b361a6e1f7f9"),
        ("linux-arm64", "77443889f7d0e1ecb00bf940795f9dc45d947c12cde03c19d8c5bf3926240ee7"),
        ("linux-x86_64", "3c21171d880f44e50223a3415d81cc3e359ac40360a58aabc3a6d7325d75ebc9"),
        ("windows-x86_64", "dfa50a9854e2f8c991dcbe999a4306804b9f021107762386929d866d7b61c2e2"),
    ]:
        http_file(
            name = "grpc_gateway_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.18.1/protoc-gen-grpc-gateway-v2.18.1-{}{}".format(
                platform,
                ".exe" if "windows" in platform else "",
            ),
        )

    # Openapi plugin
    for platform, hash in [
        ("darwin-arm64", "41d90c7c6ce769d73628c3b4659f2af6040b700a7cee791d1b6751cab43e0a51"),
        ("darwin-x86_64", "787a054ca402e44de2626be1a2094bff440a03a9b452b9cac459f5dbedb68c4c"),
        ("linux-arm64", "d3e4cd54e1b2052c71ebe52291bb78b08e9227bc5361f29dcb3cb94912f6defd"),
        ("linux-x86_64", "00103c1893a7eb089d3f961b9f642637997cacb8b37b3521a261e508fc3eb04e"),
        ("windows-x86_64", "19ab08d4b6d50a4518c3956f47a0410a99452abffb84623d4905da9c2db340b7"),
    ]:
        http_file(
            name = "openapiv2_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.18.1/protoc-gen-openapiv2-v2.18.1-{}{}".format(
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
