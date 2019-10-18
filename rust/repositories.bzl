load(
    "//:repositories.bzl",
    "io_bazel_rules_rust",
    "rules_proto_grpc_dependencies",
)
load(
    "//rust/raze:crates.bzl",
    "raze_fetch_remote_crates"
)

def rust_repos(**kwargs):
    rules_proto_grpc_dependencies(**kwargs)
    io_bazel_rules_rust(**kwargs)
    raze_fetch_remote_crates()
