"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""
    for platform, hash in [
        ("darwin-aarch64", "a12b759629b943ebac5528f58fac5039d9aa2fb7abb9e9684d1b481b35afbfc6"),
        ("darwin-x86_64", "1fa3ef92194d06c03448a5cba82759e9773e43d8b188866a1f1d4fc23bb1ecb7"),
        ("linux-aarch64", "522e958568cdeabdd20ef3c97394fc067ff8e374a728c08b7410bf5de8f57783"),
        ("linux-x86_64", "2e6e074497b221045a14d5a54e9fc910945bfdd1198b12b9fc23686a95671d64"),
        ("windows-aarch64.exe", "749a183f9c36325be220bba34877a695fbfe52b17b7107c7049a041297d30590"),
        ("windows-x86_64.exe", "c8f6191072d09344555fb12d45e82cff9f8b8f29200b0d6497680e696feaf8a1"),
    ]:
        http_file(
            name = "protoc_gen_grpc_web_plugin_{}".format(platform.replace("-", "_").replace(".exe", "")),
            sha256 = hash,
            url = "https://github.com/grpc/grpc-web/releases/download/1.5.0/protoc-gen-grpc-web-1.5.0-{}".format(platform),
            executable = True,
        )

    git_repository(
        name = "protobuf_javascript",
        commit = "eb785a9363664a402b6336dfe96aad27fb33ffa8",
        remote = "https://github.com/protocolbuffers/protobuf-javascript.git",
    )

    return module_ctx.extension_metadata(
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

download_plugins = module_extension(
    implementation = _download_plugins,
)
