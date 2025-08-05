"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _download_plugins(module_ctx):
    """Download plugins."""
    for version, platform, hash in [
        # renovate-plugin: pseudomuto/protoc-gen-doc
        ("v1.5.1", "darwin_arm64", "6e8c737d9a67a6a873a3f1d37ed8bb2a0a9996f6dcf6701aa1048c7bd798aaf9"),
        ("v1.5.1", "darwin_x86_64", "f429e5a5ddd886bfb68265f2f92c1c6a509780b7adcaf7a8b3be943f28e144ba"),
        ("v1.5.1", "linux_arm64", "172e6a191daced8eb31ebcd90d4523a1affa6d07900a89b548421823dda796fe"),
        ("v1.5.1", "linux_x86_64", "47cd72b07e6dab3408d686a65d37d3a6ab616da7d8b564b2bd2a2963a72b72fd"),
        ("v1.5.1", "windows_arm64", "bf8bc651c17e64bfec663192e660655c2bcc415f6dff9e88201d8b07fb23d493"),
        ("v1.5.1", "windows_x86_64", "8acf0bf64eda29183b4c6745c3c6a12562fd9a8ab08d61788cf56e6659c66b3b"),
    ]:
        http_archive(
            name = "protoc_gen_doc_plugins_{}".format(platform.replace("-", "_")),
            sha256 = hash,
            url = "https://github.com/pseudomuto/protoc-gen-doc/releases/download/{0}/protoc-gen-doc_{1}_{2}.tar.gz".format(
                version,
                version[1:],
                platform.replace("x86_64", "amd64"),
            ),
            build_file_content = """exports_files(glob(["protoc-gen-doc*"]))""",
        )

    return module_ctx.extension_metadata(
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

download_plugins = module_extension(
    implementation = _download_plugins,
)
