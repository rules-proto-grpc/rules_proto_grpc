package main

var csharpLibraryRuleTemplateString = `load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )
`

var csharpProtoLibraryRuleTemplate = mustTemplate(csharpLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    csharp_library(
        name = name,
        srcs = [name_pb],
        target_frameworks = kwargs.get("target_frameworks", ["net8.0"]),
        deps = PROTO_DEPS + kwargs.get("deps", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

PROTO_DEPS = [
    Label("@paket.main//google.protobuf"),
]`)

var csharpGrpcLibraryRuleTemplate = mustTemplate(csharpLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    csharp_library(
        name = name,
        srcs = [name_pb],
        target_frameworks = kwargs.get("target_frameworks", ["net8.0"]),
        deps = GRPC_DEPS + kwargs.get("deps", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    Label("@paket.main//google.protobuf"),
    Label("@paket.main//grpc.core.api"),
]

GRPC_CLIENT_DEPS = GRPC_DEPS + [
    Label("@paket.main//grpc.net.client"),
]

GRPC_SERVER_DEPS = GRPC_DEPS + [
    Label("@paket.main//grpc.aspnetcore.server"),
]`)

func makeCsharp() *Language {
	return &Language{
		Name:  "csharp",
		DisplayName: "C#",
		Notes: mustTemplate("Rules for generating C# protobuf and gRPC ``.cs`` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with ``csharp_library`` from `rules_dotnet <https://github.com/bazel-contrib/rules_dotnet>`_"),
		Rules: []*Rule{
			&Rule{
				Name:             "csharp_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates C# protobuf ``.cs`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "csharp_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:grpc_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates C# protobuf and gRPC ``.cs`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "csharp_proto_library",
				Kind:             "proto",
				Implementation:   csharpProtoLibraryRuleTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a C# protobuf library using ``csharp_library`` from ``rules_dotnet``",
				Attrs:            libraryRuleAttrs,
			},
			&Rule{
				Name:             "csharp_grpc_library",
				Kind:             "grpc",
				Implementation:   csharpGrpcLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a C# protobuf and gRPC library using ``csharp_library`` from ``rules_dotnet``",
				Attrs:            libraryRuleAttrs,
			},
		},
	}
}
