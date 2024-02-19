"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""
    for platform, hash in [
        ("darwin-arm64", "79dc0d78d1bc6054f7c2cf6cc86094d72dc2c004d1157a91b557a1a9547c4d54"),
        ("darwin-x86_64", "79dc0d78d1bc6054f7c2cf6cc86094d72dc2c004d1157a91b557a1a9547c4d54"),
        ("linux-arm64", "ed8daa4ef2dc41cf5e598e0efb09be9ec053e567dc3c2221378446ed312c158f"),
        ("linux-x86_64", "46733ae55515cb7f41d3d687c28eb03d55c825f31cefab4059d026d04f33a07c"),
        ("windows-x86_64", "286c5d8c95ac6e26ad21c16864cc3aa36b131e5067af5664c307a3ea6dd7616f"),
    ]:
        http_file(
            name = "grpc_java_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.61.1/protoc-gen-grpc-java-1.61.1-{}.exe".format(
                platform.replace("darwin", "osx").replace("arm64", "aarch_64"),
            ),
        )

    return module_ctx.extension_metadata(
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

download_plugins = module_extension(
    implementation = _download_plugins,
)
