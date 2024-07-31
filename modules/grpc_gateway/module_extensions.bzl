"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Gateway plugin
    for platform, hash in [
        ("darwin-arm64", "8fdc478fddc691771bcaeb2db2d5d8a7b02abd66eff37b5b585047f244d13a81"),
        ("darwin-x86_64", "448b136143017da93ad6ed0ad6aad40a76bfcd47a443362516c31eaf1fd7bcdb"),
        ("linux-arm64", "05a34c88c48f25c0bfccc5548cd522188f6a09ae839dc442eaefd18a83420b4b"),
        ("linux-x86_64", "9435a60c0ad0f9d535cc28998087e43ebf54fb87f491408752ddec3e89a3fdf3"),
        ("windows-arm64", "e79caf845fe8cb4ad534281ba32c1b607ef64e50f94bb278d7d9514541efad2b"),
        ("windows-x86_64", "25cfbcfc9c555145e373a85cc0dfc5eaef6c9df49c556e82f526fac51070f6d6"),
    ]:
        http_file(
            name = "grpc_gateway_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.21.0/protoc-gen-grpc-gateway-v2.21.0-{}{}".format(
                platform,
                ".exe" if "windows" in platform else "",
            ),
        )

    # Openapi plugin
    for platform, hash in [
        ("darwin-arm64", "ff82e0513c99fcef2ddfc4432092bcb8fb770086bedb166811fd4c60f1b4f950"),
        ("darwin-x86_64", "4903651de013d031c33976730b2f91f82dbe116ed91af7dcc718656809ff8a9a"),
        ("linux-arm64", "92ca757d3be792b0164b07606d6b69ccd3f0f6d765c6c38c01503c72ae51dfbc"),
        ("linux-x86_64", "d17ed6eb57ba2df1fef60a60c2bbce1bd47a05152ce54666cb9333d5c35792b2"),
        ("windows-arm64", "d456387c82d37322408b2c53f0d587659e90ff7645fa62d83571d913135dc08a"),
        ("windows-x86_64", "1d2c9687cd90a58872a664691e07f4d99fb1625de6b92a60bdb5058614248fcb"),
    ]:
        http_file(
            name = "openapiv2_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.21.0/protoc-gen-openapiv2-v2.21.0-{}{}".format(
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
