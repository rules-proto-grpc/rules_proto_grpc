package main

var ktJvmProtoWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()`)

var ktJvmGrpcWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@io_bazel_rules_kotlin//kotlin:repositories.bzl", "kotlin_repositories")

kotlin_repositories()

load("@io_bazel_rules_kotlin//kotlin:core.bzl", "kt_register_toolchains")

kt_register_toolchains()

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@io_grpc_grpc_java//:repositories.bzl", "IO_GRPC_GRPC_JAVA_ARTIFACTS", "IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS", "grpc_java_repositories")
load("@com_github_grpc_grpc_kotlin//:repositories.bzl", "IO_GRPC_GRPC_KOTLIN_ARTIFACTS", "IO_GRPC_GRPC_KOTLIN_OVERRIDE_TARGETS", "grpc_kt_repositories")

maven_install(
    artifacts = IO_GRPC_GRPC_JAVA_ARTIFACTS + IO_GRPC_GRPC_KOTLIN_ARTIFACTS,
    generate_compat_repositories = True,
    override_targets = dict(IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS.items() +
                            IO_GRPC_GRPC_KOTLIN_OVERRIDE_TARGETS.items()),
    repositories = [
        "https://repo.maven.apache.org/maven2/",
    ],
)

load("@maven//:compat.bzl", "compat_repositories")

compat_repositories()

grpc_java_repositories()

grpc_kt_repositories()`)

var ktJvmLibraryRuleTemplateString = `load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//java:defs.bzl", "java_{{ .Rule.Kind }}_library")
load("@io_bazel_rules_kotlin//kotlin:jvm.bzl", "kt_jvm_library")

def {{ .Rule.Name }}(name, java_{{ .Rule.Kind }}_target = None, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} Java dependency library, if not provided
    if java_{{ .Rule.Kind }}_target == None:
        java_{{ .Rule.Kind }}_target = ":%s_DO_NOT_DEPEND_java_{{ .Rule.Kind }}" % name

        java_{{ .Rule.Kind }}_library(
            name = java_{{ .Rule.Kind }}_target[1:],
            **{
                k: v
                for (k, v) in kwargs.items()
                if k in proto_compile_attrs.keys() or
                   k in bazel_build_rule_common_attrs
            }  # Forward args
        )
`

var ktJvmProtoLibraryRuleTemplate = mustTemplate(ktJvmLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    kt_jvm_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + [java_{{ .Rule.Kind }}_target] + kwargs.get("deps", []),
        exports = PROTO_DEPS + [java_{{ .Rule.Kind }}_target] + kwargs.get("exports", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf_java",
    "@com_google_protobuf//java/kotlin:shared_runtime",
]`)

var ktJvmGrpcLibraryRuleTemplate = mustTemplate(ktJvmLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    kt_jvm_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + [java_{{ .Rule.Kind }}_target] + kwargs.get("deps", []),
        exports = GRPC_DEPS + [java_{{ .Rule.Kind }}_target] + kwargs.get("exports", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    # From https://github.com/grpc/grpc-java/blob/f6c2d221e2b6c975c6cf465d68fe11ab12dabe55/BUILD.bazel#L32-L38
    "@io_grpc_grpc_java//api",
    "@io_grpc_grpc_java//protobuf",
    "@io_grpc_grpc_java//stub",
    "@io_grpc_grpc_java//stub:javax_annotation",
    "@com_github_grpc_grpc_kotlin//stub/src/main/java/io/grpc/kotlin:stub",
    "@com_github_grpc_grpc_kotlin//stub/src/main/java/io/grpc/kotlin:context",
    "@com_google_code_findbugs_jsr305//jar",
    "@com_google_guava_guava//jar",
    "@com_google_protobuf//:protobuf_java",
    "@com_google_protobuf//:protobuf_java_util",
    "@com_google_protobuf//java/kotlin:shared_runtime",
]`)

var ktJvmLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "exports",
		Type:      "label_list",
		Default:   "[]",
		Doc:       "List of labels to pass as exports attr to underlying lang_library rule",
		Mandatory: false,
	},
}...)

func makeKtJvm() *Language {
	return &Language{
		Dir:         "kotlin",
		Name:        "kotlin",
		DisplayName: "Kotlin",
		Notes:       mustTemplate("Rules for generating Kotlin protobuf and gRPC ``.jar`` files and libraries using standard Protocol Buffers, `gRPC-Java <https://github.com/grpc/grpc-java>` and `gRPC-Kotlin <https://github.com/grpc/grpc-kotlin>`_. Libraries are created with the `rules_kotlin <https://github.com/bazelbuild/rules_kotlin>` kt_jvm_library``"),
		Flags:       commonLangFlags,
		Rules: []*Rule{
			&Rule{
				Name:             "kotlin_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//kotlin:kotlin_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates a Kotlin (JVM) protobuf srcjar file",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "kotlin_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//kotlin:kotlin_plugin", "//kotlin:grpc_kotlin_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates a Kotlin (JVM) protobuf and gRPC srcjar file",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "kotlin_proto_library",
				Kind:             "proto",
				Implementation:   ktJvmProtoLibraryRuleTemplate,
				WorkspaceExample: ktJvmProtoWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a Kotlin (JVM) protobuf library using ``kt_jvm_library``",
				Attrs:            ktJvmLibraryRuleAttrs,
			},
			&Rule{
				Name:             "kotlin_grpc_library",
				Kind:             "grpc",
				Implementation:   ktJvmGrpcLibraryRuleTemplate,
				WorkspaceExample: ktJvmGrpcWorkspaceTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Kotlin (JVM) protobuf and gRPC library using ``kt_jvm_library``",
				Attrs:            ktJvmLibraryRuleAttrs,
			},
		},
	}
}
