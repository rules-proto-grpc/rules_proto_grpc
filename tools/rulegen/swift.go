package main

var swiftWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos="{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()

load(
    "@build_bazel_apple_support//lib:repositories.bzl",
    "apple_support_dependencies",
)

apple_support_dependencies()`)

var swiftLibraryRuleTemplate = mustTemplate(`load("@build_bazel_rules_swift//swift:swift.bzl", _{{ .Lang.Name }}_{{ .Rule.Kind }}_library = "{{ .Lang.Name }}_{{ .Rule.Kind }}_library")

{{ .Lang.Name }}_{{ .Rule.Kind }}_library = _{{ .Lang.Name }}_{{ .Rule.Kind }}_library`)

var swiftGrpcLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "person_{{ .Lang.Name }}_library",
    flavor = "client",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)`)

func makeSwift() *Language {
	return &Language{
		Dir:  "swift",
		Name: "swift",
		DisplayName: "Swift",
		Notes: mustTemplate("Rules for generating Swift protobuf and gRPC `.swift` files and libraries using [Swift Protobuf](https://github.com/apple/swift-protobuf) and [Swift gRPC](https://github.com/grpc/grpc-swift)"),
		PresubmitEnvVars: map[string]string{
			"CC": "clang",
		},
		Flags: append(commonLangFlags, &Flag{
			Category: "build",
			Name:     "strategy=SwiftCompile",
			Value:    "standalone",
		}),
		SkipTestPlatforms: []string{"all"},
		Rules: []*Rule{
			&Rule{
				Name:             "swift_proto_compile",
				Kind:             "proto",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//swift:swift_plugin"},
				WorkspaceExample: swiftWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Swift protobuf `.swift` artifacts",
				Attrs:            aspectProtoCompileAttrs,
				Experimental:     true,
			},
			&Rule{
				Name:             "swift_grpc_compile",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//swift:grpc_swift_plugin"},
				WorkspaceExample: swiftWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Swift protobuf+gRPC `.swift` artifacts",
				Attrs:            aspectProtoCompileAttrs,
				Experimental:     true,
			},
			&Rule{
				Name:             "swift_proto_library",
				Kind:             "proto",
				Implementation:   swiftLibraryRuleTemplate,
				WorkspaceExample: swiftWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a Swift protobuf library",
				Attrs:            aspectProtoCompileAttrs,
				Experimental:     true,
			},
			&Rule{
				Name:             "swift_grpc_library",
				Kind:             "grpc",
				Implementation:   swiftLibraryRuleTemplate,
				WorkspaceExample: swiftWorkspaceTemplate,
				BuildExample:     swiftGrpcLibraryExampleTemplate,
				Doc:              "Generates a Swift protobuf+gRPC library",
				Attrs:            aspectProtoCompileAttrs,
				Experimental:     true,
			},
		},
	}
}
