"""
@generated
cargo-raze crate workspace functions

DO NOT EDIT! Replaced on runs of cargo-raze
"""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")  # buildifier: disable=load
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")  # buildifier: disable=load
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")  # buildifier: disable=load

def raze_fetch_remote_crates():
    """This function defines a collection of repos and should be called in a WORKSPACE file"""
    maybe(
        http_archive,
        name = "raze__aho_corasick__0_7_13",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/aho-corasick/aho-corasick-0.7.13.crate",
        type = "tar.gz",
        strip_prefix = "aho-corasick-0.7.13",
        build_file = Label("//rust/raze/remote:aho-corasick-0.7.13.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__bindgen__0_51_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bindgen/bindgen-0.51.1.crate",
        type = "tar.gz",
        strip_prefix = "bindgen-0.51.1",
        build_file = Label("//rust/raze/remote:bindgen-0.51.1.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__bitflags__1_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-1.2.1.crate",
        type = "tar.gz",
        strip_prefix = "bitflags-1.2.1",
        build_file = Label("//rust/raze/remote:bitflags-1.2.1.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__bytes__0_5_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bytes/bytes-0.5.6.crate",
        type = "tar.gz",
        strip_prefix = "bytes-0.5.6",
        build_file = Label("//rust/raze/remote:bytes-0.5.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cc__1_0_61",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cc/cc-1.0.61.crate",
        type = "tar.gz",
        strip_prefix = "cc-1.0.61",
        build_file = Label("//rust/raze/remote:cc-1.0.61.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cexpr__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cexpr/cexpr-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "cexpr-0.3.6",
        build_file = Label("//rust/raze/remote:cexpr-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cfg_if__0_1_10",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cfg-if/cfg-if-0.1.10.crate",
        type = "tar.gz",
        strip_prefix = "cfg-if-0.1.10",
        build_file = Label("//rust/raze/remote:cfg-if-0.1.10.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__clang_sys__0_28_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/clang-sys/clang-sys-0.28.1.crate",
        type = "tar.gz",
        strip_prefix = "clang-sys-0.28.1",
        build_file = Label("//rust/raze/remote:clang-sys-0.28.1.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cloudabi__0_0_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cloudabi/cloudabi-0.0.3.crate",
        type = "tar.gz",
        strip_prefix = "cloudabi-0.0.3",
        build_file = Label("//rust/raze/remote:cloudabi-0.0.3.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__cmake__0_1_44",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cmake/cmake-0.1.44.crate",
        type = "tar.gz",
        strip_prefix = "cmake-0.1.44",
        build_file = Label("//rust/raze/remote:cmake-0.1.44.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures/futures-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-0.3.6",
        build_file = Label("//rust/raze/remote:futures-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_channel__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-channel/futures-channel-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-channel-0.3.6",
        build_file = Label("//rust/raze/remote:futures-channel-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_core__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-core/futures-core-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-core-0.3.6",
        build_file = Label("//rust/raze/remote:futures-core-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_executor__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-executor/futures-executor-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-executor-0.3.6",
        build_file = Label("//rust/raze/remote:futures-executor-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_io__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-io/futures-io-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-io-0.3.6",
        build_file = Label("//rust/raze/remote:futures-io-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_macro__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-macro/futures-macro-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-macro-0.3.6",
        build_file = Label("//rust/raze/remote:futures-macro-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_sink__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-sink/futures-sink-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-sink-0.3.6",
        build_file = Label("//rust/raze/remote:futures-sink-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_task__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-task/futures-task-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-task-0.3.6",
        build_file = Label("//rust/raze/remote:futures-task-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__futures_util__0_3_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/futures-util/futures-util-0.3.6.crate",
        type = "tar.gz",
        strip_prefix = "futures-util-0.3.6",
        build_file = Label("//rust/raze/remote:futures-util-0.3.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__glob__0_3_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/glob/glob-0.3.0.crate",
        type = "tar.gz",
        strip_prefix = "glob-0.3.0",
        build_file = Label("//rust/raze/remote:glob-0.3.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__grpcio__0_6_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpcio/grpcio-0.6.0.crate",
        type = "tar.gz",
        strip_prefix = "grpcio-0.6.0",
        build_file = Label("//rust/raze/remote:grpcio-0.6.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__grpcio_compiler__0_6_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpcio-compiler/grpcio-compiler-0.6.0.crate",
        type = "tar.gz",
        strip_prefix = "grpcio-compiler-0.6.0",
        build_file = Label("//rust/raze/remote:grpcio-compiler-0.6.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__grpcio_sys__0_6_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/grpcio-sys/grpcio-sys-0.6.0.crate",
        type = "tar.gz",
        strip_prefix = "grpcio-sys-0.6.0",
        build_file = Label("//rust/raze/remote:grpcio-sys-0.6.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__itoa__0_4_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/itoa/itoa-0.4.6.crate",
        type = "tar.gz",
        strip_prefix = "itoa-0.4.6",
        build_file = Label("//rust/raze/remote:itoa-0.4.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__lazy_static__1_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazy_static/lazy_static-1.4.0.crate",
        type = "tar.gz",
        strip_prefix = "lazy_static-1.4.0",
        build_file = Label("//rust/raze/remote:lazy_static-1.4.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__libc__0_2_79",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.79.crate",
        type = "tar.gz",
        strip_prefix = "libc-0.2.79",
        build_file = Label("//rust/raze/remote:libc-0.2.79.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__libloading__0_5_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libloading/libloading-0.5.2.crate",
        type = "tar.gz",
        strip_prefix = "libloading-0.5.2",
        build_file = Label("//rust/raze/remote:libloading-0.5.2.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__libz_sys__1_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libz-sys/libz-sys-1.1.2.crate",
        type = "tar.gz",
        strip_prefix = "libz-sys-1.1.2",
        build_file = Label("//rust/raze/remote:libz-sys-1.1.2.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__lock_api__0_3_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lock_api/lock_api-0.3.4.crate",
        type = "tar.gz",
        strip_prefix = "lock_api-0.3.4",
        build_file = Label("//rust/raze/remote:lock_api-0.3.4.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__log__0_4_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.4.6.crate",
        type = "tar.gz",
        strip_prefix = "log-0.4.6",
        build_file = Label("//rust/raze/remote:log-0.4.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__memchr__2_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/memchr/memchr-2.3.3.crate",
        type = "tar.gz",
        strip_prefix = "memchr-2.3.3",
        build_file = Label("//rust/raze/remote:memchr-2.3.3.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__nom__4_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/nom/nom-4.2.3.crate",
        type = "tar.gz",
        strip_prefix = "nom-4.2.3",
        build_file = Label("//rust/raze/remote:nom-4.2.3.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__once_cell__1_4_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/once_cell/once_cell-1.4.1.crate",
        type = "tar.gz",
        strip_prefix = "once_cell-1.4.1",
        build_file = Label("//rust/raze/remote:once_cell-1.4.1.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__parking_lot__0_10_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/parking_lot/parking_lot-0.10.2.crate",
        type = "tar.gz",
        strip_prefix = "parking_lot-0.10.2",
        build_file = Label("//rust/raze/remote:parking_lot-0.10.2.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__parking_lot_core__0_7_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/parking_lot_core/parking_lot_core-0.7.2.crate",
        type = "tar.gz",
        strip_prefix = "parking_lot_core-0.7.2",
        build_file = Label("//rust/raze/remote:parking_lot_core-0.7.2.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__peeking_take_while__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/peeking_take_while/peeking_take_while-0.1.2.crate",
        type = "tar.gz",
        strip_prefix = "peeking_take_while-0.1.2",
        build_file = Label("//rust/raze/remote:peeking_take_while-0.1.2.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__pin_project__0_4_26",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pin-project/pin-project-0.4.26.crate",
        type = "tar.gz",
        strip_prefix = "pin-project-0.4.26",
        build_file = Label("//rust/raze/remote:pin-project-0.4.26.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__pin_project_internal__0_4_26",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pin-project-internal/pin-project-internal-0.4.26.crate",
        type = "tar.gz",
        strip_prefix = "pin-project-internal-0.4.26",
        build_file = Label("//rust/raze/remote:pin-project-internal-0.4.26.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__pin_utils__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pin-utils/pin-utils-0.1.0.crate",
        type = "tar.gz",
        strip_prefix = "pin-utils-0.1.0",
        build_file = Label("//rust/raze/remote:pin-utils-0.1.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__pkg_config__0_3_18",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pkg-config/pkg-config-0.3.18.crate",
        type = "tar.gz",
        strip_prefix = "pkg-config-0.3.18",
        build_file = Label("//rust/raze/remote:pkg-config-0.3.18.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__proc_macro_hack__0_5_18",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/proc-macro-hack/proc-macro-hack-0.5.18.crate",
        type = "tar.gz",
        strip_prefix = "proc-macro-hack-0.5.18",
        build_file = Label("//rust/raze/remote:proc-macro-hack-0.5.18.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__proc_macro_nested__0_1_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/proc-macro-nested/proc-macro-nested-0.1.6.crate",
        type = "tar.gz",
        strip_prefix = "proc-macro-nested-0.1.6",
        build_file = Label("//rust/raze/remote:proc-macro-nested-0.1.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__proc_macro2__1_0_24",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/proc-macro2/proc-macro2-1.0.24.crate",
        type = "tar.gz",
        strip_prefix = "proc-macro2-1.0.24",
        build_file = Label("//rust/raze/remote:proc-macro2-1.0.24.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__protobuf__2_17_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/protobuf/protobuf-2.17.0.crate",
        type = "tar.gz",
        strip_prefix = "protobuf-2.17.0",
        build_file = Label("//rust/raze/remote:protobuf-2.17.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__protobuf_codegen__2_17_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/protobuf-codegen/protobuf-codegen-2.17.0.crate",
        type = "tar.gz",
        strip_prefix = "protobuf-codegen-2.17.0",
        build_file = Label("//rust/raze/remote:protobuf-codegen-2.17.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__quote__1_0_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quote/quote-1.0.7.crate",
        type = "tar.gz",
        strip_prefix = "quote-1.0.7",
        build_file = Label("//rust/raze/remote:quote-1.0.7.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__redox_syscall__0_1_57",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/redox_syscall/redox_syscall-0.1.57.crate",
        type = "tar.gz",
        strip_prefix = "redox_syscall-0.1.57",
        build_file = Label("//rust/raze/remote:redox_syscall-0.1.57.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__regex__1_3_9",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex/regex-1.3.9.crate",
        type = "tar.gz",
        strip_prefix = "regex-1.3.9",
        build_file = Label("//rust/raze/remote:regex-1.3.9.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__regex_syntax__0_6_18",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex-syntax/regex-syntax-0.6.18.crate",
        type = "tar.gz",
        strip_prefix = "regex-syntax-0.6.18",
        build_file = Label("//rust/raze/remote:regex-syntax-0.6.18.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__rustc_hash__1_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rustc-hash/rustc-hash-1.1.0.crate",
        type = "tar.gz",
        strip_prefix = "rustc-hash-1.1.0",
        build_file = Label("//rust/raze/remote:rustc-hash-1.1.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__ryu__1_0_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ryu/ryu-1.0.5.crate",
        type = "tar.gz",
        strip_prefix = "ryu-1.0.5",
        build_file = Label("//rust/raze/remote:ryu-1.0.5.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__same_file__1_0_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/same-file/same-file-1.0.6.crate",
        type = "tar.gz",
        strip_prefix = "same-file-1.0.6",
        build_file = Label("//rust/raze/remote:same-file-1.0.6.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__scopeguard__1_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/scopeguard/scopeguard-1.1.0.crate",
        type = "tar.gz",
        strip_prefix = "scopeguard-1.1.0",
        build_file = Label("//rust/raze/remote:scopeguard-1.1.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__serde__1_0_116",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/serde/serde-1.0.116.crate",
        type = "tar.gz",
        strip_prefix = "serde-1.0.116",
        build_file = Label("//rust/raze/remote:serde-1.0.116.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__serde_json__1_0_58",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/serde_json/serde_json-1.0.58.crate",
        type = "tar.gz",
        strip_prefix = "serde_json-1.0.58",
        build_file = Label("//rust/raze/remote:serde_json-1.0.58.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__shlex__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/shlex/shlex-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "shlex-0.1.1",
        build_file = Label("//rust/raze/remote:shlex-0.1.1.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__slab__0_4_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/slab/slab-0.4.2.crate",
        type = "tar.gz",
        strip_prefix = "slab-0.4.2",
        build_file = Label("//rust/raze/remote:slab-0.4.2.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__smallvec__1_4_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/smallvec/smallvec-1.4.2.crate",
        type = "tar.gz",
        strip_prefix = "smallvec-1.4.2",
        build_file = Label("//rust/raze/remote:smallvec-1.4.2.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__syn__1_0_43",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/syn/syn-1.0.43.crate",
        type = "tar.gz",
        strip_prefix = "syn-1.0.43",
        build_file = Label("//rust/raze/remote:syn-1.0.43.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__thread_local__1_0_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thread_local/thread_local-1.0.1.crate",
        type = "tar.gz",
        strip_prefix = "thread_local-1.0.1",
        build_file = Label("//rust/raze/remote:thread_local-1.0.1.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__unicode_xid__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unicode-xid/unicode-xid-0.2.1.crate",
        type = "tar.gz",
        strip_prefix = "unicode-xid-0.2.1",
        build_file = Label("//rust/raze/remote:unicode-xid-0.2.1.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__vcpkg__0_2_10",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/vcpkg/vcpkg-0.2.10.crate",
        type = "tar.gz",
        strip_prefix = "vcpkg-0.2.10",
        build_file = Label("//rust/raze/remote:vcpkg-0.2.10.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__version_check__0_1_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/version_check/version_check-0.1.5.crate",
        type = "tar.gz",
        strip_prefix = "version_check-0.1.5",
        build_file = Label("//rust/raze/remote:version_check-0.1.5.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__walkdir__2_3_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/walkdir/walkdir-2.3.1.crate",
        type = "tar.gz",
        strip_prefix = "walkdir-2.3.1",
        build_file = Label("//rust/raze/remote:walkdir-2.3.1.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__winapi__0_3_9",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.9.crate",
        type = "tar.gz",
        strip_prefix = "winapi-0.3.9",
        build_file = Label("//rust/raze/remote:winapi-0.3.9.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-i686-pc-windows-gnu/winapi-i686-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = Label("//rust/raze/remote:winapi-i686-pc-windows-gnu-0.4.0.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__winapi_util__0_1_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-util/winapi-util-0.1.5.crate",
        type = "tar.gz",
        strip_prefix = "winapi-util-0.1.5",
        build_file = Label("//rust/raze/remote:winapi-util-0.1.5.BUILD.bazel"),
    )

    maybe(
        http_archive,
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = Label("//rust/raze/remote:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD.bazel"),
    )
