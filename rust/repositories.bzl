load(
    "//:repositories.bzl",
    "io_bazel_rules_rust",
)
load(
    "//protobuf:repositories.bzl",
    "protobuf_repos",
)
load(
    "//rust/raze:crates.bzl",
    "raze_fetch_remote_crates"
)

def rust_repos(**kwargs):
    protobuf_repos(**kwargs)
    io_bazel_rules_rust(**kwargs)
    raze_fetch_remote_crates()
