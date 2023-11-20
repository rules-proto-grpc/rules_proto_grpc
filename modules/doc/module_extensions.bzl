"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Gateway plugin
    for platform, hash in [
        ("darwin_arm64", "6e8c737d9a67a6a873a3f1d37ed8bb2a0a9996f6dcf6701aa1048c7bd798aaf9"),
        ("darwin_amd64", "f429e5a5ddd886bfb68265f2f92c1c6a509780b7adcaf7a8b3be943f28e144ba"),
        ("linux_amd64", "47cd72b07e6dab3408d686a65d37d3a6ab616da7d8b564b2bd2a2963a72b72fd"),
        ("windows_amd64", "8acf0bf64eda29183b4c6745c3c6a12562fd9a8ab08d61788cf56e6659c66b3b"),
    ]:
        http_archive(
            name = "protoc_gen_doc_plugins_{}".format(platform.replace("-", "_").replace("amd64", "x86_64")),
            sha256 = hash,
            url = "https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.1/protoc-gen-doc_1.5.1_{}.tar.gz".format(
                platform,
            ),
            build_file_content = """exports_files(glob(["protoc-gen-doc*"]))"""
        )

    return module_ctx.extension_metadata(
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

download_plugins = module_extension(
    implementation = _download_plugins,
)
