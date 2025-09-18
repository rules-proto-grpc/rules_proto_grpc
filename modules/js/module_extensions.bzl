"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # protobuf-javascript plugin
    for version, platform, hash in [
        # renovate-gh-plugin: protocolbuffers/protobuf-javascript
        ("v4.0.0", "darwin-arm64", "e9c2b968bc22f5ad74fb597edde3cf43a907bb538e5a964faf7710175eb67c52"),
        ("v4.0.0", "darwin-x86_64", "e2009dcb23ec56b7c16a813afa5456596808611cebc842afdb758feb22e7224c"),
        ("v4.0.0", "linux-arm64", "9e20bcdfa4307c0d1c686c279893c6ee94535dafaaa246d837df225bfcd67d39"),
        ("v4.0.0", "linux-x86_64", "24d26a28b95d2dad8bb3588f31c4e2527d906c701f23af6c11d0375d35e44345"),
        # ("v3.21.4", "windows-arm64", ""),
        ("v4.0.0", "windows-x86_64", "b0f89f7cebd4a39a62b4539d33c77472911f6072c77eff175699dafc41a97811"),
    ]:
        repo_platform = platform.replace("windows-x86_64", "win64").replace("darwin", "osx").replace("arm64", "aarch_64")
        http_archive(
            name = "protoc_gen_protobuf_javascript_plugin_{}".format(platform.replace("-", "_")),
            sha256 = hash,
            url = "https://github.com/protocolbuffers/protobuf-javascript/releases/download/{0}/protobuf-javascript-{1}-{2}.zip".format(
                version,
                version[1:],
                repo_platform,
            ),
            build_file_content = """exports_files(glob(["**/*"]))""",
            strip_prefix = (
                # This repo is inconsistent in how its .zips are structured, as some platforms have
                # a top level folder and some don't and it's not even consistent between releases...
                "protobuf-javascript-{}-{}".format(version[1:], repo_platform) if platform in ("darwin-arm64", "darwin-x86_64", "windows-x86_64") else ""
            ),
        )

    # grpc-web plugin
    for version, platform, hash in [
        # renovate-gh-plugin: grpc/grpc-web
        ("2.0.2", "darwin-arm64", "1d8be70a078082699b5ef15bccdf42bb079a51d511b853ffc9ebd02415d37a20"),
        ("2.0.2", "darwin-x86_64", "f535c1359de2b6f49095be851bfa77bab941f6ddc124c4288c055d922d100a5d"),
        ("2.0.2", "linux-arm64", "85cb386f2e8ce8e2cdfdde593468ee9845ad6d57666b68c7d013d92aa42593d9"),
        ("2.0.2", "linux-x86_64", "10ff6c6e58018ff9e684cff1d9c008b8cc79d915c4f8be4fd47791333e1be299"),
        ("2.0.2", "windows-arm64", "f6153a2aeb3d41f44aca2f9ddbd485cc1610c85096b720f13a99f85413a67615"),
        ("2.0.2", "windows-x86_64", "9cf57127b2893f5def6f04bf70c53b190c440e4d315f068346798a43ac4834ce"),
    ]:
        http_file(
            name = "protoc_gen_grpc_web_plugin_{}".format(platform.replace("-", "_")),
            sha256 = hash,
            url = "https://github.com/grpc/grpc-web/releases/download/{0}/protoc-gen-grpc-web-{0}-{1}{2}".format(
                version,
                platform.replace("arm64", "aarch64"),
                ".exe" if "windows" in platform else "",
            ),
            executable = True,
        )

    return module_ctx.extension_metadata(
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

download_plugins = module_extension(
    implementation = _download_plugins,
)
