"""
cargo-raze crate workspace functions

DO NOT EDIT! Replaced on runs of cargo-raze
"""
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

def _new_http_archive(name, **kwargs):
    if not native.existing_rule(name):
        http_archive(name=name, **kwargs)

def _new_git_repository(name, **kwargs):
    if not native.existing_rule(name):
        new_git_repository(name=name, **kwargs)

def raze_fetch_remote_crates():

    _new_http_archive(
        name = "raze__byteorder__1_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/byteorder/byteorder-1.3.2.crate",
        type = "tar.gz",
        sha256 = "a7c3dd8985a7111efc5c80b44e23ecdd8c007de8ade3b96595387e812b957cf5",
        strip_prefix = "byteorder-1.3.2",
        build_file = Label("//rust/raze/remote:byteorder-1.3.2.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__bytes__0_4_12",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bytes/bytes-0.4.12.crate",
        type = "tar.gz",
        sha256 = "206fdffcfa2df7cbe15601ef46c813fce0965eb3286db6b56c583b814b51c81c",
        strip_prefix = "bytes-0.4.12",
        build_file = Label("//rust/raze/remote:bytes-0.4.12.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__cc__1_0_47",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cc/cc-1.0.47.crate",
        type = "tar.gz",
        sha256 = "aa87058dce70a3ff5621797f1506cb837edd02ac4c0ae642b4542dce802908b8",
        strip_prefix = "cc-1.0.47",
        build_file = Label("//rust/raze/remote:cc-1.0.47.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__cfg_if__0_1_10",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cfg-if/cfg-if-0.1.10.crate",
        type = "tar.gz",
        sha256 = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822",
        strip_prefix = "cfg-if-0.1.10",
        build_file = Label("//rust/raze/remote:cfg-if-0.1.10.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__cmake__0_1_42",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cmake/cmake-0.1.42.crate",
        type = "tar.gz",
        sha256 = "81fb25b677f8bf1eb325017cb6bb8452f87969db0fedb4f757b297bee78a7c62",
        strip_prefix = "cmake-0.1.42",
        build_file = Label("//rust/raze/remote:cmake-0.1.42.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__futures__0_1_28",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures/futures-0.1.28.crate",
        type = "tar.gz",
        sha256 = "45dc39533a6cae6da2b56da48edae506bb767ec07370f86f70fc062e9d435869",
        strip_prefix = "futures-0.1.28",
        build_file = Label("//rust/raze/remote:futures-0.1.28.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__grpcio__0_4_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpcio/grpcio-0.4.6.crate",
        type = "tar.gz",
        sha256 = "211932b84a0001a88d9443bef8a95726c6e2eb1cc50e7655592e2596060ba5e1",
        strip_prefix = "grpcio-0.4.6",
        build_file = Label("//rust/raze/remote:grpcio-0.4.6.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__grpcio_compiler__0_4_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpcio-compiler/grpcio-compiler-0.4.3.crate",
        type = "tar.gz",
        sha256 = "373a14f0f994d4c235770f4bb5558be00626844db130a82a70142b8fc5996fc3",
        strip_prefix = "grpcio-compiler-0.4.3",
        build_file = Label("//rust/raze/remote:grpcio-compiler-0.4.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__grpcio_sys__0_4_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpcio-sys/grpcio-sys-0.4.7.crate",
        type = "tar.gz",
        sha256 = "7b2f22fb0327f153acccedbe91894dd0fb15bb6f202d8195665cd206af0402b0",
        strip_prefix = "grpcio-sys-0.4.7",
        build_file = Label("//rust/raze/remote:grpcio-sys-0.4.7.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__iovec__0_1_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/iovec/iovec-0.1.4.crate",
        type = "tar.gz",
        sha256 = "b2b3ea6ff95e175473f8ffe6a7eb7c00d054240321b84c57051175fe3c1e075e",
        strip_prefix = "iovec-0.1.4",
        build_file = Label("//rust/raze/remote:iovec-0.1.4.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__itoa__0_4_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/itoa/itoa-0.4.4.crate",
        type = "tar.gz",
        sha256 = "501266b7edd0174f8530248f87f99c88fbe60ca4ef3dd486835b8d8d53136f7f",
        strip_prefix = "itoa-0.4.4",
        build_file = Label("//rust/raze/remote:itoa-0.4.4.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__libc__0_2_66",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.66.crate",
        type = "tar.gz",
        sha256 = "d515b1f41455adea1313a4a2ac8a8a477634fbae63cc6100e3aebb207ce61558",
        strip_prefix = "libc-0.2.66",
        build_file = Label("//rust/raze/remote:libc-0.2.66.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__log__0_4_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.4.6.crate",
        type = "tar.gz",
        sha256 = "c84ec4b527950aa83a329754b01dbe3f58361d1c5efacd1f6d68c494d08a17c6",
        strip_prefix = "log-0.4.6",
        build_file = Label("//rust/raze/remote:log-0.4.6.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__pkg_config__0_3_17",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pkg-config/pkg-config-0.3.17.crate",
        type = "tar.gz",
        sha256 = "05da548ad6865900e60eaba7f589cc0783590a92e940c26953ff81ddbab2d677",
        strip_prefix = "pkg-config-0.3.17",
        build_file = Label("//rust/raze/remote:pkg-config-0.3.17.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__protobuf__2_8_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/protobuf/protobuf-2.8.1.crate",
        type = "tar.gz",
        sha256 = "40361836defdd5871ff7e84096c6f6444af7fc157f8ef1789f54f147687caa20",
        strip_prefix = "protobuf-2.8.1",
        build_file = Label("//rust/raze/remote:protobuf-2.8.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__protobuf_codegen__2_8_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/protobuf-codegen/protobuf-codegen-2.8.1.crate",
        type = "tar.gz",
        sha256 = "12c6abd78435445fc86898ebbd0521a68438063d4a73e23527b7134e6bf58b4a",
        strip_prefix = "protobuf-codegen-2.8.1",
        build_file = Label("//rust/raze/remote:protobuf-codegen-2.8.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__ryu__1_0_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ryu/ryu-1.0.2.crate",
        type = "tar.gz",
        sha256 = "bfa8506c1de11c9c4e4c38863ccbe02a305c8188e85a05a784c9e11e1c3910c8",
        strip_prefix = "ryu-1.0.2",
        build_file = Label("//rust/raze/remote:ryu-1.0.2.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__serde__1_0_103",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/serde/serde-1.0.103.crate",
        type = "tar.gz",
        sha256 = "1217f97ab8e8904b57dd22eb61cde455fa7446a9c1cf43966066da047c1f3702",
        strip_prefix = "serde-1.0.103",
        build_file = Label("//rust/raze/remote:serde-1.0.103.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__serde_json__1_0_42",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/serde_json/serde_json-1.0.42.crate",
        type = "tar.gz",
        sha256 = "1a3351dcbc1f067e2c92ab7c3c1f288ad1a4cffc470b5aaddb4c2e0a3ae80043",
        strip_prefix = "serde_json-1.0.42",
        build_file = Label("//rust/raze/remote:serde_json-1.0.42.BUILD.bazel")
    )

