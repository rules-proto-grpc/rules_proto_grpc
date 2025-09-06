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
        ("2.0.1", "darwin-arm64", "09be260940beafba227117d1300e178b901bcedcfca87526aac01dd4bbfc8e21"),
        ("2.0.1", "darwin-x86_64", "c66f7b0c8335254e558b8746e4299228da90323c2f5457f6745fc6b96b090a0e"),
        ("2.0.1", "linux-arm64", "8c0b43f3251e501e2d3acbc1d1f9325044eeea3a431313044b4fae383655d2d9"),
        ("2.0.1", "linux-x86_64", "805375d272bf8384698f78b1f21bde24b0e3ea1fd70ce727470620e39a8b44d4"),
        ("2.0.1", "windows-arm64", "3145cfeb81d909a82a6efc4875ebb0a6ba1f29a7dc54bcb7676fa1294e37d5e7"),
        ("2.0.1", "windows-x86_64", "9ca8a59e5f3ec24291ee7d9d4a71f0c45a2b4989cbd9bd411b62c51ec748444d"),
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
