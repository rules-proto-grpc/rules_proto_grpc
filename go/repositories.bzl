load(
    "//:repositories.bzl",
    "io_bazel_rules_go",
    "rules_proto_grpc_repos",
)
load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_repos(**kwargs):
    rules_proto_grpc_repos(**kwargs)
    io_bazel_rules_go(**kwargs)

    go_repository(
        name = "org_golang_google_grpc",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/grpc",
        sum = "h1:zWTV+LMdc3kaiJMSTOFz2UgSBgx8RNQoTGiZu3fR9S0=",
        version = "v1.32.0",
    )

    go_repository(
        name = "org_golang_x_net",
        importpath = "golang.org/x/net",
        sum = "h1:YfxMZzv3PjGonQYNUaeU2+DhAdqOxerQ30JFB6WgAXo=",
        version = "v0.0.0-20200930145003-4acb6c075d10",
    )

    go_repository(
        name = "org_golang_x_text",
        importpath = "golang.org/x/text",
        sum = "h1:cokOdA+Jmi5PJGXLlLllQSgYigAEfHXJAERHVMaCc2k=",
        version = "v0.3.3",
    )
