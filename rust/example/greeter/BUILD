load("//rust:macros.bzl", "rust_prost_proto_library", "rust_tonic_grpc_library")


rust_tonic_grpc_library(
    name = "greeter_grpc",
    declared_proto_packages = ["example.proto"],
    protos = [
        "//example/proto:person_proto",
        "//example/proto:place_proto",
        "//example/proto:greeter_grpc",
    ],
    options = {
        "//rust:rust_prost_plugin": [
            "type_attribute=.example.proto.Person=#[derive(Eq\\,Hash)]",
            "type_attribute=.example.proto.Place=#[derive(Eq\\,Hash)]",
    ]},
    prost_proto_deps = [
        ":other_prost",
    ]
)

rust_prost_proto_library(
    name = "other_prost",
    declared_proto_packages = ["example.proto"],
    protos = [
        "//example/proto:thing_proto",
    ],
)