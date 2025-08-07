"""Generated definition of swift_grpc_library."""

load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_swift//swift:swift.bzl", "swift_library")
load("//:swift_grpc_compile.bzl", "swift_grpc_compile")

def swift_grpc_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    swift_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create swift library
    swift_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        module_name = kwargs.get("module_name"),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

GRPC_DEPS = [
    Label("@swiftpkg_swift_protobuf//:SwiftProtobuf"),
    Label("@swiftpkg_grpc_swift_2//:GRPCCore"),
    Label("@swiftpkg_grpc_swift_protobuf//:GRPCProtobuf"),
]
