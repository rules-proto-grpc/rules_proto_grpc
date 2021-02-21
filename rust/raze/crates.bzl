"""
@generated
cargo-raze generated Bazel file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")  # buildifier: disable=load
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")  # buildifier: disable=load
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")  # buildifier: disable=load

def raze_fetch_remote_crates():
    """This function defines a collection of repos and should be called in a WORKSPACE file"""
    maybe(
        http_archive,
        name = "raze__aho_corasick__0_7_15",
        url = "https://crates.io/api/v1/crates/aho-corasick/0.7.15/download",
        type = "tar.gz",
        strip_prefix = "aho-corasick-0.7.15",
        build_file = Label("//rust/raze/remote:BUILD.aho-corasick-0.7.15.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__bindgen__0_51_1",
        url = "https://crates.io/api/v1/crates/bindgen/0.51.1/download",
        type = "tar.gz",
        strip_prefix = "bindgen-0.51.1",
        build_file = Label("//rust/raze/remote:BUILD.bindgen-0.51.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__bitflags__1_2_1",
        url = "https://crates.io/api/v1/crates/bitflags/1.2.1/download",
        type = "tar.gz",
        strip_prefix = "bitflags-1.2.1",
        build_file = Label("//rust/raze/remote:BUILD.bitflags-1.2.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__boringssl_src__0_1_0",
        url = "https://crates.io/api/v1/crates/boringssl-src/0.1.0/download",
        type = "tar.gz",
        strip_prefix = "boringssl-src-0.1.0",
        build_file = Label("//rust/raze/remote:BUILD.boringssl-src-0.1.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__bytes__1_0_1",
        url = "https://crates.io/api/v1/crates/bytes/1.0.1/download",
        type = "tar.gz",
        strip_prefix = "bytes-1.0.1",
        build_file = Label("//rust/raze/remote:BUILD.bytes-1.0.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cc__1_0_66",
        url = "https://crates.io/api/v1/crates/cc/1.0.66/download",
        type = "tar.gz",
        strip_prefix = "cc-1.0.66",
        build_file = Label("//rust/raze/remote:BUILD.cc-1.0.66.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cexpr__0_3_6",
        url = "https://crates.io/api/v1/crates/cexpr/0.3.6/download",
        type = "tar.gz",
        strip_prefix = "cexpr-0.3.6",
        build_file = Label("//rust/raze/remote:BUILD.cexpr-0.3.6.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cfg_if__0_1_10",
        url = "https://crates.io/api/v1/crates/cfg-if/0.1.10/download",
        type = "tar.gz",
        strip_prefix = "cfg-if-0.1.10",
        build_file = Label("//rust/raze/remote:BUILD.cfg-if-0.1.10.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cfg_if__1_0_0",
        url = "https://crates.io/api/v1/crates/cfg-if/1.0.0/download",
        type = "tar.gz",
        strip_prefix = "cfg-if-1.0.0",
        build_file = Label("//rust/raze/remote:BUILD.cfg-if-1.0.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__clang_sys__0_28_1",
        url = "https://crates.io/api/v1/crates/clang-sys/0.28.1/download",
        type = "tar.gz",
        strip_prefix = "clang-sys-0.28.1",
        build_file = Label("//rust/raze/remote:BUILD.clang-sys-0.28.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cmake__0_1_45",
        url = "https://crates.io/api/v1/crates/cmake/0.1.45/download",
        type = "tar.gz",
        strip_prefix = "cmake-0.1.45",
        build_file = Label("//rust/raze/remote:BUILD.cmake-0.1.45.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures__0_3_12",
        url = "https://crates.io/api/v1/crates/futures/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_channel__0_3_12",
        url = "https://crates.io/api/v1/crates/futures-channel/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-channel-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-channel-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_core__0_3_12",
        url = "https://crates.io/api/v1/crates/futures-core/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-core-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-core-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_executor__0_3_12",
        url = "https://crates.io/api/v1/crates/futures-executor/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-executor-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-executor-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_io__0_3_12",
        url = "https://crates.io/api/v1/crates/futures-io/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-io-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-io-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_macro__0_3_12",
        url = "https://crates.io/api/v1/crates/futures-macro/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-macro-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-macro-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_sink__0_3_12",
        url = "https://crates.io/api/v1/crates/futures-sink/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-sink-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-sink-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_task__0_3_12",
        url = "https://crates.io/api/v1/crates/futures-task/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-task-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-task-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_util__0_3_12",
        url = "https://crates.io/api/v1/crates/futures-util/0.3.12/download",
        type = "tar.gz",
        strip_prefix = "futures-util-0.3.12",
        build_file = Label("//rust/raze/remote:BUILD.futures-util-0.3.12.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__glob__0_3_0",
        url = "https://crates.io/api/v1/crates/glob/0.3.0/download",
        type = "tar.gz",
        strip_prefix = "glob-0.3.0",
        build_file = Label("//rust/raze/remote:BUILD.glob-0.3.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__grpcio__0_7_1",
        url = "https://crates.io/api/v1/crates/grpcio/0.7.1/download",
        type = "tar.gz",
        strip_prefix = "grpcio-0.7.1",
        build_file = Label("//rust/raze/remote:BUILD.grpcio-0.7.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__grpcio_compiler__0_7_0",
        url = "https://crates.io/api/v1/crates/grpcio-compiler/0.7.0/download",
        type = "tar.gz",
        strip_prefix = "grpcio-compiler-0.7.0",
        build_file = Label("//rust/raze/remote:BUILD.grpcio-compiler-0.7.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__grpcio_sys__0_7_2",
        url = "https://crates.io/api/v1/crates/grpcio-sys/0.7.2/download",
        type = "tar.gz",
        strip_prefix = "grpcio-sys-0.7.2",
        build_file = Label("//rust/raze/remote:BUILD.grpcio-sys-0.7.2.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__instant__0_1_9",
        url = "https://crates.io/api/v1/crates/instant/0.1.9/download",
        type = "tar.gz",
        strip_prefix = "instant-0.1.9",
        build_file = Label("//rust/raze/remote:BUILD.instant-0.1.9.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__itoa__0_4_7",
        url = "https://crates.io/api/v1/crates/itoa/0.4.7/download",
        type = "tar.gz",
        strip_prefix = "itoa-0.4.7",
        build_file = Label("//rust/raze/remote:BUILD.itoa-0.4.7.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__lazy_static__1_4_0",
        url = "https://crates.io/api/v1/crates/lazy_static/1.4.0/download",
        type = "tar.gz",
        strip_prefix = "lazy_static-1.4.0",
        build_file = Label("//rust/raze/remote:BUILD.lazy_static-1.4.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__libc__0_2_85",
        url = "https://crates.io/api/v1/crates/libc/0.2.85/download",
        type = "tar.gz",
        strip_prefix = "libc-0.2.85",
        build_file = Label("//rust/raze/remote:BUILD.libc-0.2.85.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__libloading__0_5_2",
        url = "https://crates.io/api/v1/crates/libloading/0.5.2/download",
        type = "tar.gz",
        strip_prefix = "libloading-0.5.2",
        build_file = Label("//rust/raze/remote:BUILD.libloading-0.5.2.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__libz_sys__1_1_2",
        url = "https://crates.io/api/v1/crates/libz-sys/1.1.2/download",
        type = "tar.gz",
        strip_prefix = "libz-sys-1.1.2",
        build_file = Label("//rust/raze/remote:BUILD.libz-sys-1.1.2.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__lock_api__0_4_2",
        url = "https://crates.io/api/v1/crates/lock_api/0.4.2/download",
        type = "tar.gz",
        strip_prefix = "lock_api-0.4.2",
        build_file = Label("//rust/raze/remote:BUILD.lock_api-0.4.2.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__log__0_4_6",
        url = "https://crates.io/api/v1/crates/log/0.4.6/download",
        type = "tar.gz",
        strip_prefix = "log-0.4.6",
        build_file = Label("//rust/raze/remote:BUILD.log-0.4.6.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__memchr__2_3_4",
        url = "https://crates.io/api/v1/crates/memchr/2.3.4/download",
        type = "tar.gz",
        strip_prefix = "memchr-2.3.4",
        build_file = Label("//rust/raze/remote:BUILD.memchr-2.3.4.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__nom__4_2_3",
        url = "https://crates.io/api/v1/crates/nom/4.2.3/download",
        type = "tar.gz",
        strip_prefix = "nom-4.2.3",
        build_file = Label("//rust/raze/remote:BUILD.nom-4.2.3.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__once_cell__1_5_2",
        url = "https://crates.io/api/v1/crates/once_cell/1.5.2/download",
        type = "tar.gz",
        strip_prefix = "once_cell-1.5.2",
        build_file = Label("//rust/raze/remote:BUILD.once_cell-1.5.2.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__parking_lot__0_11_1",
        url = "https://crates.io/api/v1/crates/parking_lot/0.11.1/download",
        type = "tar.gz",
        strip_prefix = "parking_lot-0.11.1",
        build_file = Label("//rust/raze/remote:BUILD.parking_lot-0.11.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__parking_lot_core__0_8_2",
        url = "https://crates.io/api/v1/crates/parking_lot_core/0.8.2/download",
        type = "tar.gz",
        strip_prefix = "parking_lot_core-0.8.2",
        build_file = Label("//rust/raze/remote:BUILD.parking_lot_core-0.8.2.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__peeking_take_while__0_1_2",
        url = "https://crates.io/api/v1/crates/peeking_take_while/0.1.2/download",
        type = "tar.gz",
        strip_prefix = "peeking_take_while-0.1.2",
        build_file = Label("//rust/raze/remote:BUILD.peeking_take_while-0.1.2.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__pin_project_lite__0_2_4",
        url = "https://crates.io/api/v1/crates/pin-project-lite/0.2.4/download",
        type = "tar.gz",
        strip_prefix = "pin-project-lite-0.2.4",
        build_file = Label("//rust/raze/remote:BUILD.pin-project-lite-0.2.4.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__pin_utils__0_1_0",
        url = "https://crates.io/api/v1/crates/pin-utils/0.1.0/download",
        type = "tar.gz",
        strip_prefix = "pin-utils-0.1.0",
        build_file = Label("//rust/raze/remote:BUILD.pin-utils-0.1.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__pkg_config__0_3_19",
        url = "https://crates.io/api/v1/crates/pkg-config/0.3.19/download",
        type = "tar.gz",
        strip_prefix = "pkg-config-0.3.19",
        build_file = Label("//rust/raze/remote:BUILD.pkg-config-0.3.19.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__proc_macro_hack__0_5_19",
        url = "https://crates.io/api/v1/crates/proc-macro-hack/0.5.19/download",
        type = "tar.gz",
        strip_prefix = "proc-macro-hack-0.5.19",
        build_file = Label("//rust/raze/remote:BUILD.proc-macro-hack-0.5.19.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__proc_macro_nested__0_1_7",
        url = "https://crates.io/api/v1/crates/proc-macro-nested/0.1.7/download",
        type = "tar.gz",
        strip_prefix = "proc-macro-nested-0.1.7",
        build_file = Label("//rust/raze/remote:BUILD.proc-macro-nested-0.1.7.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__proc_macro2__1_0_24",
        url = "https://crates.io/api/v1/crates/proc-macro2/1.0.24/download",
        type = "tar.gz",
        strip_prefix = "proc-macro2-1.0.24",
        build_file = Label("//rust/raze/remote:BUILD.proc-macro2-1.0.24.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__protobuf__2_20_0",
        url = "https://crates.io/api/v1/crates/protobuf/2.20.0/download",
        type = "tar.gz",
        strip_prefix = "protobuf-2.20.0",
        build_file = Label("//rust/raze/remote:BUILD.protobuf-2.20.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__protobuf_codegen__2_20_0",
        url = "https://crates.io/api/v1/crates/protobuf-codegen/2.20.0/download",
        type = "tar.gz",
        strip_prefix = "protobuf-codegen-2.20.0",
        build_file = Label("//rust/raze/remote:BUILD.protobuf-codegen-2.20.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__quote__1_0_8",
        url = "https://crates.io/api/v1/crates/quote/1.0.8/download",
        type = "tar.gz",
        strip_prefix = "quote-1.0.8",
        build_file = Label("//rust/raze/remote:BUILD.quote-1.0.8.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__redox_syscall__0_1_57",
        url = "https://crates.io/api/v1/crates/redox_syscall/0.1.57/download",
        type = "tar.gz",
        strip_prefix = "redox_syscall-0.1.57",
        build_file = Label("//rust/raze/remote:BUILD.redox_syscall-0.1.57.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__regex__1_4_3",
        url = "https://crates.io/api/v1/crates/regex/1.4.3/download",
        type = "tar.gz",
        strip_prefix = "regex-1.4.3",
        build_file = Label("//rust/raze/remote:BUILD.regex-1.4.3.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__regex_syntax__0_6_22",
        url = "https://crates.io/api/v1/crates/regex-syntax/0.6.22/download",
        type = "tar.gz",
        strip_prefix = "regex-syntax-0.6.22",
        build_file = Label("//rust/raze/remote:BUILD.regex-syntax-0.6.22.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__rustc_hash__1_1_0",
        url = "https://crates.io/api/v1/crates/rustc-hash/1.1.0/download",
        type = "tar.gz",
        strip_prefix = "rustc-hash-1.1.0",
        build_file = Label("//rust/raze/remote:BUILD.rustc-hash-1.1.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__ryu__1_0_5",
        url = "https://crates.io/api/v1/crates/ryu/1.0.5/download",
        type = "tar.gz",
        strip_prefix = "ryu-1.0.5",
        build_file = Label("//rust/raze/remote:BUILD.ryu-1.0.5.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__same_file__1_0_6",
        url = "https://crates.io/api/v1/crates/same-file/1.0.6/download",
        type = "tar.gz",
        strip_prefix = "same-file-1.0.6",
        build_file = Label("//rust/raze/remote:BUILD.same-file-1.0.6.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__scopeguard__1_1_0",
        url = "https://crates.io/api/v1/crates/scopeguard/1.1.0/download",
        type = "tar.gz",
        strip_prefix = "scopeguard-1.1.0",
        build_file = Label("//rust/raze/remote:BUILD.scopeguard-1.1.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__serde__1_0_123",
        url = "https://crates.io/api/v1/crates/serde/1.0.123/download",
        type = "tar.gz",
        strip_prefix = "serde-1.0.123",
        build_file = Label("//rust/raze/remote:BUILD.serde-1.0.123.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__serde_json__1_0_62",
        url = "https://crates.io/api/v1/crates/serde_json/1.0.62/download",
        type = "tar.gz",
        strip_prefix = "serde_json-1.0.62",
        build_file = Label("//rust/raze/remote:BUILD.serde_json-1.0.62.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__shlex__0_1_1",
        url = "https://crates.io/api/v1/crates/shlex/0.1.1/download",
        type = "tar.gz",
        strip_prefix = "shlex-0.1.1",
        build_file = Label("//rust/raze/remote:BUILD.shlex-0.1.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__slab__0_4_2",
        url = "https://crates.io/api/v1/crates/slab/0.4.2/download",
        type = "tar.gz",
        strip_prefix = "slab-0.4.2",
        build_file = Label("//rust/raze/remote:BUILD.slab-0.4.2.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__smallvec__1_6_1",
        url = "https://crates.io/api/v1/crates/smallvec/1.6.1/download",
        type = "tar.gz",
        strip_prefix = "smallvec-1.6.1",
        build_file = Label("//rust/raze/remote:BUILD.smallvec-1.6.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__syn__1_0_60",
        url = "https://crates.io/api/v1/crates/syn/1.0.60/download",
        type = "tar.gz",
        strip_prefix = "syn-1.0.60",
        build_file = Label("//rust/raze/remote:BUILD.syn-1.0.60.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__thread_local__1_1_3",
        url = "https://crates.io/api/v1/crates/thread_local/1.1.3/download",
        type = "tar.gz",
        strip_prefix = "thread_local-1.1.3",
        build_file = Label("//rust/raze/remote:BUILD.thread_local-1.1.3.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__unicode_xid__0_2_1",
        url = "https://crates.io/api/v1/crates/unicode-xid/0.2.1/download",
        type = "tar.gz",
        strip_prefix = "unicode-xid-0.2.1",
        build_file = Label("//rust/raze/remote:BUILD.unicode-xid-0.2.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__vcpkg__0_2_11",
        url = "https://crates.io/api/v1/crates/vcpkg/0.2.11/download",
        type = "tar.gz",
        strip_prefix = "vcpkg-0.2.11",
        build_file = Label("//rust/raze/remote:BUILD.vcpkg-0.2.11.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__version_check__0_1_5",
        url = "https://crates.io/api/v1/crates/version_check/0.1.5/download",
        type = "tar.gz",
        strip_prefix = "version_check-0.1.5",
        build_file = Label("//rust/raze/remote:BUILD.version_check-0.1.5.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__walkdir__2_3_1",
        url = "https://crates.io/api/v1/crates/walkdir/2.3.1/download",
        type = "tar.gz",
        strip_prefix = "walkdir-2.3.1",
        build_file = Label("//rust/raze/remote:BUILD.walkdir-2.3.1.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__winapi__0_3_9",
        url = "https://crates.io/api/v1/crates/winapi/0.3.9/download",
        type = "tar.gz",
        strip_prefix = "winapi-0.3.9",
        build_file = Label("//rust/raze/remote:BUILD.winapi-0.3.9.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates.io/api/v1/crates/winapi-i686-pc-windows-gnu/0.4.0/download",
        type = "tar.gz",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = Label("//rust/raze/remote:BUILD.winapi-i686-pc-windows-gnu-0.4.0.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__winapi_util__0_1_5",
        url = "https://crates.io/api/v1/crates/winapi-util/0.1.5/download",
        type = "tar.gz",
        strip_prefix = "winapi-util-0.1.5",
        build_file = Label("//rust/raze/remote:BUILD.winapi-util-0.1.5.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download",
        type = "tar.gz",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = Label("//rust/raze/remote:BUILD.winapi-x86_64-pc-windows-gnu-0.4.0.bazel"),
    )
