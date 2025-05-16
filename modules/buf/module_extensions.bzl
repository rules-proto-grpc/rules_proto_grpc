"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for platform, hash in [
        ("darwin-arm64", "55db6cb7bbc11674691f6bbdb1fd5722a9ad6d2d4b4d250264f021b222a165e6"),
        ("darwin-x86_64", "cab3136c12006ccd211b47d5a169a8c2457438afa6d03fc21a9c82c26ce9b7e1"),
        ("linux-arm64", "84a028f2544e66817ce31c695077c2b71c18204a4e5747d6edb0852b7889ba35"),
        ("linux-x86_64", "1629346e6b113b2ea50d5567e5b94f5b661024da965fc05623956b6ce7dd01b8"),
        ("windows-arm64", "22721a0036cdeee30fe7ab01e8e9a9b584ff61b5c354adc0afede9428f667060"),
        ("windows-x86_64", "8575bc576ea7e3187b8214edaa46ae652039a6bf5298bd0d188c8dd4b83130af"),
    ]:
        http_file(
            name = "buf_breaking_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/v1.54.0/protoc-gen-buf-breaking-{}{}".format(
                ("linux-aarch64" if platform == "linux-arm64" else platform).title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    # Lint plugin
    for platform, hash in [
        ("darwin-arm64", "bdda2d433220354eca60d48bd24ed6fdea14e5bf04ebe5152ea41aabcdf37ff7"),
        ("darwin-x86_64", "7d8d70dcd9b28ad1bdb8ec5aabc4e1cfbd8f5b6e2f1dc7332461450c71470023"),
        ("linux-arm64", "9ec0b561dcebd29a3f72748f4d005d763ae469edfa32d8e9e81df0d04ec54234"),
        ("linux-x86_64", "b73dd6d2b00c33b5301232d059989d7a6ce0b9143045cffbff560bccba74db72"),
        ("windows-arm64", "04db73ebf8a04c3030f4427512d9b7552f25a90243123af7f1a652f8b31113ab"),
        ("windows-x86_64", "d6f44314126544f2696b9072bc703f73faee8ae0e5c4799a25e30252a8dab141"),
    ]:
        http_file(
            name = "buf_lint_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/v1.54.0/protoc-gen-buf-lint-{}{}".format(
                ("linux-aarch64" if platform == "linux-arm64" else platform).title(),
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
