// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "rules_proto_grpc",
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf", from: "1.30.0"),
        .package(url: "https://github.com/grpc/grpc-swift", from: "2.2.3"),
        .package(url: "https://github.com/grpc/grpc-swift-protobuf", from: "2.0.0"),
    ]
)
