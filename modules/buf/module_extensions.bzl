"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for platform, hash in [
        ("darwin-arm64", "f244140c3459782b65bd2bd29a12972f116ddd2ed0c1d2a189cdd1b2c0aab1ba"),
        ("darwin-x86_64", "03ccd305ebd1f9bd8af67084628797bbaf3aa6ac33048b4e4d329efc8d7bae7e"),
        ("linux-arm64", "e317d99943f5f363c82fb31b33b845d8a01ffcbebe0e94e072fb3b8c0699f3f9"),
        ("linux-x86_64", "a1b754fb589f4362bc57b605645c29f7a3b8aca442c7ddca4c15c98f71fecbf6"),
        ("windows-arm64", "5f6ad60fb8cf86e944ee524d66ab5370459fd95e0f3c01e312d80a123be98ae0"),
        ("windows-x86_64", "9d8845eb234515f62efb362e6d7d9d77e6eb12f6a97679754709de3f31968130"),
    ]:
        http_file(
            name = "buf_breaking_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/v1.34.0/protoc-gen-buf-breaking-{}{}".format(
                platform.title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    # Lint plugin
    for platform, hash in [
        ("darwin-arm64", "dea822195a4b092b84cfd531ba6b95923a131f2c4537b7ed29f9905619153060"),
        ("darwin-x86_64", "45b3faeb82948a4876ec9ffa1f44a1ffe67845ce5d2959210c4e7d74a24b9e14"),
        ("linux-arm64", "8a7a6fc1b95780f61c92136748fb95a2ccebce56e57ed4a0ca22acb96638c9aa"),
        ("linux-x86_64", "af3140ab9872dc7cb0fc14f7b5577d5433d17c1c07a8ed990be1d24222877d32"),
        ("windows-arm64", "1681e7ab55fbf1b6b1ef54e1def9904e30dd63d405a803a9a1debdb118b66e75"),
        ("windows-x86_64", "c23ba1f7450abb64dc91652e9f67a75fe6189dc63b2e02d56eb4f9b44ddf6bc2"),
    ]:
        http_file(
            name = "buf_lint_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/v1.34.0/protoc-gen-buf-lint-{}{}".format(
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
