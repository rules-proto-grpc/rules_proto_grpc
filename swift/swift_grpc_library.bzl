load("//swift:swift_grpc_compile.bzl", "swift_grpc_compile")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

def swift_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    swift_grpc_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("protos" if "protos" in kwargs else "deps", "verbose")}  # Forward args
    )

    # Create swift library
    swift_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        module_name = kwargs.get("module_name"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@com_github_apple_swift_protobuf//:SwiftProtobuf",
    "@com_github_grpc_grpc_swift//:GRPC",
]
