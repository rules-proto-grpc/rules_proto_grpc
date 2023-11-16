"""Generated definition of go_proto_library."""

load("@rules_go//go:def.bzl", "go_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:go_proto_compile.bzl", "go_proto_compile")

def go_proto_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    go_proto_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if (k in proto_compile_attrs.keys() and k != "prefix_path") or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create go library
    go_library(
        name = name,
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + PROTO_DEPS + kwargs.get("deps", []),
        importpath = kwargs.get("importpath"),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

PROTO_DEPS = [
    Label("@org_golang_google_protobuf//proto:go_default_library"),
    Label("@org_golang_google_protobuf//reflect/protoreflect:go_default_library"),
    Label("@org_golang_google_protobuf//runtime/protoimpl:go_default_library"),

    # Well-known types
    Label("@org_golang_google_protobuf//types/known/anypb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/apipb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/durationpb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/emptypb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/fieldmaskpb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/sourcecontextpb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/structpb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/timestamppb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/typepb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/wrapperspb:go_default_library"),
]
