package main

var swiftWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()`)

var swiftProtoLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("protos" if "protos" in kwargs else "deps", "verbose")}  # Forward args
    )

    # Create {{ .Lang.Name }} library
    swift_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        module_name = kwargs.get("module_name"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_github_apple_swift_protobuf//:SwiftProtobuf",
]`)

var swiftGrpcLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("protos" if "protos" in kwargs else "deps", "verbose")}  # Forward args
    )

    # Create {{ .Lang.Name }} library
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
]`)

// For swift, produce one library for all protos, since they are all in the same module
var swiftProtoLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "proto_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = [
        "@rules_proto_grpc//example/proto:person_proto",
        "@rules_proto_grpc//example/proto:place_proto",
        "@rules_proto_grpc//example/proto:thing_proto",
    ],
)`)

var swiftGrpcLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = [
        "@rules_proto_grpc//example/proto:greeter_grpc",
        "@rules_proto_grpc//example/proto:thing_proto",
    ],
)`)

var swiftLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "module_name",
		Type:      "string",
		Default:   "",
		Doc:       "The name of the Swift module being built.",
		Mandatory: false,
	},
}...)

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
		SkipDirectoriesMerge: true,
		SkipTestPlatforms: []string{"windows"},
		Rules: []*Rule{
			&Rule{
				Name:             "swift_proto_compile",
				Kind:             "proto",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//swift:swift_plugin"},
				WorkspaceExample: swiftWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Swift protobuf `.swift` artifacts",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "swift_grpc_compile",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//swift:swift_plugin", "//swift:grpc_swift_plugin"},
				WorkspaceExample: swiftWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Swift protobuf+gRPC `.swift` artifacts",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "swift_proto_library",
				Kind:             "proto",
				Implementation:   swiftProtoLibraryRuleTemplate,
				WorkspaceExample: swiftWorkspaceTemplate,
				BuildExample:     swiftProtoLibraryExampleTemplate,
				Doc:              "Generates a Swift protobuf library using `swift_library` from `rules_swift`",
				Attrs:            swiftLibraryRuleAttrs,
			},
			&Rule{
				Name:             "swift_grpc_library",
				Kind:             "grpc",
				Implementation:   swiftGrpcLibraryRuleTemplate,
				WorkspaceExample: swiftWorkspaceTemplate,
				BuildExample:     swiftGrpcLibraryExampleTemplate,
				Doc:              "Generates a Swift protobuf+gRPC library using `swift_library` from `rules_swift`",
				Attrs:            swiftLibraryRuleAttrs,
			},
		},
	}
}
