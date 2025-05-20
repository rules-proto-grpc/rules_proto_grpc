package main

var scalaLibraryRuleTemplateString = `load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_scala//scala:scala.bzl", "scala_library")
load("@rules_scala_config//:config.bzl", "SCALA_VERSIONS")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )
`

var scalaProtoLibraryRuleTemplate = mustTemplate(scalaLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    scala_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        exports = PROTO_DEPS + kwargs.get("exports", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

PROTO_DEPS = [
    Label("@rules_proto_grpc_scala_maven_common//:com_google_protobuf_protobuf_java"),
] + select({
    Label("@rules_scala_config//:scala_version_{}".format(scala_version.replace(".", "_"))): [
        Label("@rules_proto_grpc_scala_maven_{0}//:{1}_{0}".format(
            scala_version.replace(".", "_").rpartition("_")[0],
            package,
        )) for package in [
            "com_thesamet_scalapb_lenses",
            "com_thesamet_scalapb_scalapb_runtime",
        ]
    ]
    for scala_version in SCALA_VERSIONS
})`)

var scalaGrpcLibraryRuleTemplate = mustTemplate(scalaLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    scala_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        exports = GRPC_DEPS + kwargs.get("exports", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    Label("@rules_proto_grpc_scala_maven_common//:io_grpc_grpc_api"),
    Label("@rules_proto_grpc_scala_maven_common//:io_grpc_grpc_netty"),
    Label("@rules_proto_grpc_scala_maven_common//:io_grpc_grpc_protobuf"),
    Label("@rules_proto_grpc_scala_maven_common//:io_grpc_grpc_stub"),
    Label("@rules_proto_grpc_scala_maven_common//:com_google_protobuf_protobuf_java"),
] + select({
    Label("@rules_scala_config//:scala_version_{}".format(scala_version.replace(".", "_"))): [
        Label("@rules_proto_grpc_scala_maven_{0}//:{1}_{0}".format(
            scala_version.replace(".", "_").rpartition("_")[0],
            package,
        )) for package in [
            "com_thesamet_scalapb_lenses",
            "com_thesamet_scalapb_scalapb_runtime",
            "com_thesamet_scalapb_scalapb_runtime_grpc",
        ]
    ]
    for scala_version in SCALA_VERSIONS
})`)

func makeScala() *Language {
	return &Language{
		Name:  "scala",
		DisplayName: "Scala",
		Notes: mustTemplate("Rules for generating Scala protobuf and gRPC ``.jar`` files and libraries using `ScalaPB <https://github.com/scalapb/ScalaPB>`_. Libraries are created with ``scala_library`` from `rules_scala <https://github.com/bazelbuild/rules_scala>`_"),
		SkipTestPlatforms: []string{},
		Rules: []*Rule{
			&Rule{
				Name:             "scala_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates a Scala protobuf ``.jar`` file",
				Attrs:            compileRuleAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
			&Rule{
				Name:             "scala_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:grpc_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Scala protobuf and gRPC ``.jar`` file",
				Attrs:            compileRuleAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
			&Rule{
				Name:             "scala_proto_library",
				Kind:             "proto",
				Implementation:   scalaProtoLibraryRuleTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a Scala protobuf library using ``scala_library`` from ``rules_scala``",
				Attrs:            javaLibraryRuleAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
			&Rule{
				Name:             "scala_grpc_library",
				Kind:             "grpc",
				Implementation:   scalaGrpcLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Scala protobuf and gRPC library using ``scala_library`` from ``rules_scala``",
				Attrs:            javaLibraryRuleAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
		},
	}
}
