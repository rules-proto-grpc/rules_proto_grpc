// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "rules_proto_grpc",
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf", from: "1.30.0"),
        .package(url: "https://github.com/grpc/grpc-swift-2", from: "2.1.0"),
        .package(url: "https://github.com/grpc/grpc-swift-protobuf", from: "2.1.0"),
    ]
)
