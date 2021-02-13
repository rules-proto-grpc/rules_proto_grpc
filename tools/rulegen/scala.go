package main

var scalaProtoWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()`)

var scalaGrpcWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

grpc_java_repositories()`)

var scalaLibraryRuleTemplateString = `load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
load("@io_bazel_rules_scala//scala_proto:default_dep_sets.bzl", "DEFAULT_SCALAPB_COMPILE_DEPS", "DEFAULT_SCALAPB_GRPC_DEPS")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("protos" if "protos" in kwargs else "deps", "verbose")}  # Forward args
    )
`

var scalaProtoLibraryRuleTemplate = mustTemplate(scalaLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    scala_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        exports = PROTO_DEPS + kwargs.get("exports", []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    # One dependency in this list is not valid outside of rules_scala workspace, fix up. The '//external' check is for
    # older rules_scala prior to
    # https://github.com/bazelbuild/rules_scala/commit/e9dfbe39fa44a8dc7ab0b9aef46488f215646d9c
    "@io_bazel_rules_scala" + dep if not dep.startswith("//external") and not dep.startswith("@") else dep
    for dep in DEFAULT_SCALAPB_COMPILE_DEPS
]`)

var scalaGrpcLibraryRuleTemplate = mustTemplate(scalaLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    scala_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        exports = GRPC_DEPS + kwargs.get("exports", []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    # One dependency in this list is not valid outside of rules_scala workspace, fix up. The '//external' check is for
    # older rules_scala prior to
    # https://github.com/bazelbuild/rules_scala/commit/e9dfbe39fa44a8dc7ab0b9aef46488f215646d9c
    "@io_bazel_rules_scala" + dep if not dep.startswith("//external") and not dep.startswith("@") else dep
    for dep in DEFAULT_SCALAPB_COMPILE_DEPS
] + DEFAULT_SCALAPB_GRPC_DEPS`)

func makeScala() *Language {
	return &Language{
		Dir:   "scala",
		Name:  "scala",
		DisplayName: "Scala",
		Notes: mustTemplate("Rules for generating Scala protobuf and gRPC `.jar` files and libraries using [ScalaPB](https://github.com/scalapb/ScalaPB). Libraries are created with `scala_library` from [rules_scala](https://github.com/bazelbuild/rules_scala)"),
		Flags: commonLangFlags,
		SkipDirectoriesMerge: true,
		SkipTestPlatforms: []string{},
		Rules: []*Rule{
			&Rule{
				Name:             "scala_proto_compile",
				Kind:             "proto",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//scala:scala_plugin"},
				WorkspaceExample: scalaProtoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates a Scala protobuf `.jar` artifact",
				Attrs:            compileRuleAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
			&Rule{
				Name:             "scala_grpc_compile",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//scala:grpc_scala_plugin"},
				WorkspaceExample: scalaGrpcWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Scala protobuf+gRPC `.jar` artifacts",
				Attrs:            compileRuleAttrs,
				SkipTestPlatforms: []string{"windows"},
				Experimental:     true,
			},
			&Rule{
				Name:             "scala_proto_library",
				Kind:             "proto",
				Implementation:   scalaProtoLibraryRuleTemplate,
				WorkspaceExample: scalaProtoWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a Scala protobuf library using `scala_library` from `rules_scala`",
				Attrs:            javaLibraryRuleAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
			&Rule{
				Name:             "scala_grpc_library",
				Kind:             "grpc",
				Implementation:   scalaGrpcLibraryRuleTemplate,
				WorkspaceExample: scalaGrpcWorkspaceTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Scala protobuf+gRPC library using `scala_library` from `rules_scala`",
				Attrs:            javaLibraryRuleAttrs,
				SkipTestPlatforms: []string{"windows"},
				Experimental:     true,
			},
		},
	}
}
