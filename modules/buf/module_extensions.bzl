"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.66.1", "darwin-arm64", "de17788f01f7ec71bf2932ea68950199813df59326a8b30514d05ca5d8d2eae3"),
        ("v1.66.1", "darwin-x86_64", "2ec584f53b334fe6a189fb147f5b82f414455a92b212f234ff5653635b1da4f6"),
        ("v1.66.1", "linux-arm64", "649a7076bcd4d1f64c84a60b194c7ee40bd0f870a0717edf25c5fb370bb533ea"),
        ("v1.66.1", "linux-x86_64", "da84c94d1283384bcfdc0f6e7ccfc46cb0f6b5dcc2830d2e1b544551cf71ba67"),
        ("v1.66.1", "windows-arm64", "6b3137cc3a3b735cdd34f3c50a081368444262713db480dc572ff3c70d90f498"),
        ("v1.66.1", "windows-x86_64", "76a2ed7a44a4b3df32c398f19a52e1c28f0e37a94584f67040cc9aba005fd286"),
    ]:
        http_file(
            name = "buf_breaking_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/{0}/protoc-gen-buf-breaking-{1}{2}".format(
                version,
                ("linux-aarch64" if platform == "linux-arm64" else platform).title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    # Lint plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.66.1", "darwin-arm64", "82b2d05cb1a1e68149194f72bc8c17ab90b3e088e064adaf0d0f329b99c135b9"),
        ("v1.66.1", "darwin-x86_64", "c9fa06a4250956aeb4a95cab5c0eaa1b5fac02073ff300d3aaa5a54157df4ed1"),
        ("v1.66.1", "linux-arm64", "4a07237823a8298e74a164124749fd17febb7beb169567bc0472090bd14138de"),
        ("v1.66.1", "linux-x86_64", "3fef4634c64208e4b2f25220a6ea06aef3f32b7ebe00b79c7489ae2ea63c8d71"),
        ("v1.66.1", "windows-arm64", "8c317ea6591d13e7ad26a4026c06fbe4908b02fbc12a2f1f241c9a480dfd3699"),
        ("v1.66.1", "windows-x86_64", "02672bbbdf71c579c499cc733e9cdd8733fb44f995d96911b76adc5b65437391"),
    ]:
        http_file(
            name = "buf_lint_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/{0}/protoc-gen-buf-lint-{1}{2}".format(
                version,
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
