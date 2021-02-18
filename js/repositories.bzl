"""Common dependencies for rules_proto_grpc JavaScript rules."""

load(
    "//:repositories.bzl",
    "build_bazel_rules_nodejs",
    "rules_proto_grpc_repos",
)
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def js_repos(**kwargs):  # buildifier: disable=function-docstring
    rules_proto_grpc_repos(**kwargs)
    build_bazel_rules_nodejs(**kwargs)

    # gRPC-Web plugin
    grpc_web_version = "1.2.1"  # When updating, also update in package.json and vice-versa
    http_file(
        name = "grpc_web_plugin_darwin",
        executable = True,
        urls = ["https://github.com/grpc/grpc-web/releases/download/{}/protoc-gen-grpc-web-{}-darwin-x86_64".format(grpc_web_version, grpc_web_version)],
        sha256 = "81bb5d4d3ae0340568fd0739402c052f32476dd520b44355e5032b556a3bc0da",
    )

    http_file(
        name = "grpc_web_plugin_linux",
        executable = True,
        urls = ["https://github.com/grpc/grpc-web/releases/download/{}/protoc-gen-grpc-web-{}-linux-x86_64".format(grpc_web_version, grpc_web_version)],
        sha256 = "6ce1625db7902d38d38d83690ec578c182e9cf2abaeb58d3fba1dae0c299c597",
    )

    http_file(
        name = "grpc_web_plugin_windows",
        executable = True,
        urls = ["https://github.com/grpc/grpc-web/releases/download/{}/protoc-gen-grpc-web-{}-windows-x86_64.exe".format(grpc_web_version, grpc_web_version)],
        sha256 = "5886b4c9886dfdbfd1c7c2f26a15c396c6662b9f1acf9b6d8efbd490bc3736db",
    )
