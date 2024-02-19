package main

var javaLibraryRuleTemplateString = `load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "filter_files", "proto_compile_attrs")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("@rules_java//java:defs.bzl", "java_library")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )
`

var javaProtoLibraryRuleTemplate = mustTemplate(javaLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    java_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        exports = PROTO_DEPS + kwargs.get("exports", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

PROTO_DEPS = [
    Label("@maven//:com_google_protobuf_protobuf_java"),
]`)

var javaGrpcLibraryRuleTemplate = mustTemplate(javaLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    java_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        runtime_deps = [
            Label("@maven//:io_grpc_grpc_netty"),
        ],
        exports = GRPC_DEPS + kwargs.get("exports", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    Label("@maven//:com_google_guava_guava"),
    Label("@maven//:com_google_protobuf_protobuf_java"),
    Label("@maven//:com_google_protobuf_protobuf_java_util"),
    Label("@maven//:io_grpc_grpc_api"),
    Label("@maven//:io_grpc_grpc_protobuf"),
    Label("@maven//:io_grpc_grpc_stub"),
    Label("@maven//:javax_annotation_javax_annotation_api"),
]`)

var javaLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "exports",
		Type:      "label_list",
		Default:   "[]",
		Doc:       "List of labels to pass as exports attr to underlying lang_library rule",
		Mandatory: false,
	},
}...)

func makeJava() *Language {
	return &Language{
		Name:             "java",
		DisplayName:      "Java",
		Notes: mustTemplate("Rules for generating Java protobuf and gRPC ``.jar`` files and libraries using standard Protocol Buffers and `gRPC-Java <https://github.com/grpc/grpc-java>`_. Libraries are created with the Bazel native ``java_library``"),
		Rules: []*Rule{
			&Rule{
				Name:             "java_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates a Java protobuf srcjar file",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "java_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:grpc_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates a Java protobuf and gRPC srcjar file",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "java_proto_library",
				Kind:             "proto",
				Implementation:   javaProtoLibraryRuleTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a Java protobuf library using ``java_library``",
				Attrs:            javaLibraryRuleAttrs,
			},
			&Rule{
				Name:             "java_grpc_library",
				Kind:             "grpc",
				Implementation:   javaGrpcLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Java protobuf and gRPC library using ``java_library``",
				Attrs:            javaLibraryRuleAttrs,
			},
		},
	}
}
