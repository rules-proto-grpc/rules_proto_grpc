"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # protobuf-javascript plugin
    for version, platform, hash in [
        # renovate-gh-plugin: protocolbuffers/protobuf-javascript
        ("v3.21.4", "darwin-arm64", "c8ee4890625f3eb134072ea6111b757cce541897657a50f05c5170558773acea"),
        ("v3.21.4", "darwin-x86_64", "af7665e12f6b76c9dbad9f09c3ec925f2c45b268e344de5356945bb2be098b1e"),
        ("v3.21.4", "linux-arm64", "87eb5158e8a914c47f8fda43bb04575ac2f7c68db5ee4289b3e689acf2843bfd"),
        ("v3.21.4", "linux-x86_64", "4966d0dce71a637b3b46de511aefc52c5df449159c6acbd7967ba742944012fd"),
        # ("v3.21.4", "windows-arm64", ""),
        ("v3.21.4", "windows-x86_64", "d0c701617ff0286462875ba0a6019f29de2ca3fe1740a55d6540558b39e44819"),
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
