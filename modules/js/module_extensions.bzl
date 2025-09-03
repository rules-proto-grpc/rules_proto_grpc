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
        ("1.5.0", "darwin-arm64", "a12b759629b943ebac5528f58fac5039d9aa2fb7abb9e9684d1b481b35afbfc6"),
        ("1.5.0", "darwin-x86_64", "1fa3ef92194d06c03448a5cba82759e9773e43d8b188866a1f1d4fc23bb1ecb7"),
        ("1.5.0", "linux-arm64", "522e958568cdeabdd20ef3c97394fc067ff8e374a728c08b7410bf5de8f57783"),
        ("1.5.0", "linux-x86_64", "2e6e074497b221045a14d5a54e9fc910945bfdd1198b12b9fc23686a95671d64"),
        ("1.5.0", "windows-arm64", "749a183f9c36325be220bba34877a695fbfe52b17b7107c7049a041297d30590"),
        ("1.5.0", "windows-x86_64", "c8f6191072d09344555fb12d45e82cff9f8b8f29200b0d6497680e696feaf8a1"),
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
