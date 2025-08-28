package main

var swiftProtoLibraryRuleTemplate = mustTemplate(`load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_swift//swift:swift.bzl", "swift_library")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    swift_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        module_name = kwargs.get("module_name"),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

PROTO_DEPS = [
    Label("@swiftpkg_swift_protobuf//:SwiftProtobuf"),
]`)

var swiftGrpcLibraryRuleTemplate = mustTemplate(`load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_swift//swift:swift.bzl", "swift_library")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    swift_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        module_name = kwargs.get("module_name"),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    Label("@swiftpkg_swift_protobuf//:SwiftProtobuf"),
    Label("@swiftpkg_grpc_swift_2//:GRPCCore"),
    Label("@swiftpkg_grpc_swift_protobuf//:GRPCProtobuf"),
]`)

// For swift, produce one library for all protos, since they are all in the same module
var swiftProtoLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "proto_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = [
        "@rules_proto_grpc_example_protos//:person_proto",
        "@rules_proto_grpc_example_protos//:place_proto",
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
)`)

var swiftGrpcLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = [
        "@rules_proto_grpc_example_protos//:greeter_grpc",
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
)`)

var swiftModulePrefixLines = `bazel_dep(name = "apple_support", version = "1.23.1")`

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
		Name: "swift",
		DisplayName: "Swift",
		Notes: mustTemplate("Rules for generating Swift protobuf and gRPC ``.swift`` files and libraries using `Swift Protobuf <https://github.com/apple/swift-protobuf>`_ and `Swift gRPC <https://github.com/grpc/grpc-swift>`_"),
		ModulePrefixLines: swiftModulePrefixLines,
		PresubmitEnvVars: map[string]string{
			"CC": "clang",
		},
		SkipTestPlatforms: []string{"windows", "linux"},
		Rules: []*Rule{
			&Rule{
				Name:             "swift_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Swift protobuf ``.swift`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "swift_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:grpc_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Swift protobuf and gRPC ``.swift`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "swift_proto_library",
				Kind:             "proto",
				Implementation:   swiftProtoLibraryRuleTemplate,
				BuildExample:     swiftProtoLibraryExampleTemplate,
				Doc:              "Generates a Swift protobuf library using ``swift_library`` from ``rules_swift``",
				Attrs:            swiftLibraryRuleAttrs,
			},
			&Rule{
				Name:             "swift_grpc_library",
				Kind:             "grpc",
				Implementation:   swiftGrpcLibraryRuleTemplate,
				BuildExample:     swiftGrpcLibraryExampleTemplate,
				Doc:              "Generates a Swift protobuf and gRPC library using ``swift_library`` from ``rules_swift``",
				Attrs:            swiftLibraryRuleAttrs,
			},
		},
	}
}
