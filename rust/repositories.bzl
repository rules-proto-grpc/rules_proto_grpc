load(
    "//:repositories.bzl",
    "rules_rust",
    "rules_proto_grpc_repos",
)
load(
    "//rust/raze:crates.bzl",
    "raze_fetch_remote_crates"
)

def rust_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    rules_rust(**kwargs)
    raze_fetch_remote_crates()
