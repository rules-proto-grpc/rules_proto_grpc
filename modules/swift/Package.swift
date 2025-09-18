// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "rules_proto_grpc",
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf", exact: "1.31.1"),
        .package(url: "https://github.com/grpc/grpc-swift-2", exact: "2.1.0"),
        .package(url: "https://github.com/grpc/grpc-swift-protobuf", exact: "2.1.1"),
    ]
)
