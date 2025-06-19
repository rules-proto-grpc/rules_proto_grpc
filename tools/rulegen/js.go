package main

var jsProtoLibraryRuleTemplate = mustTemplate(`load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    js_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

PROTO_DEPS = [
    Label("@rules_proto_grpc_js//:node_modules/google-protobuf"),
]`)

var jsGrpcLibraryRuleTemplate = mustTemplate(`load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:js_grpc_compile.bzl", "js_grpc_compile")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    js_grpc_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    js_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    Label("@rules_proto_grpc_js//:node_modules/@grpc/grpc-js"),
    Label("@rules_proto_grpc_js//:node_modules/google-protobuf"),
]`)

var jsGrpcWebLibraryRuleTemplate = mustTemplate(`load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:js_grpc_web_compile.bzl", "js_grpc_web_compile")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    js_grpc_web_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    js_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    Label("@rules_proto_grpc_js//:node_modules/google-protobuf"),
    Label("@rules_proto_grpc_js//:node_modules/grpc-web"),
]`)

var jsLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "package_name",
		Type:      "string",
		Default:   "",
		Doc:       "The package name to use for the library. If unprovided, the target name is used.",
		Mandatory: false,
	},
	&Attr{
		Name:      "deps_repo",
		Type:      "string",
		Default:   "@npm",
		Doc:       "The repository to load the dependencies from, if you don't use ``@npm``",
		Mandatory: false,
	},
	&Attr{
		Name:      "legacy_path",
		Type:      "bool",
		Default:   "False",
		Doc:       "Use the legacy <name>_pb path segment from the generated library require path.",
		Mandatory: false,
	},
}...)

func makeJs() *Language {
	return &Language{
		Name:  "js",
		DisplayName: "JavaScript",
		Notes: mustTemplate("Rules for generating JavaScript protobuf, gRPC-js and gRPC-Web ``.js`` and ``.d.ts`` files using standard Protocol Buffers and gRPC."),
		SkipTestPlatforms: []string{"macos_arm64"},  // https://github.com/grpc/grpc-node/issues/2378
		Rules: []*Rule{
			&Rule{
				Name:             "js_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:proto_ts_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf ``.js`` and ``.d.ts`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:proto_ts_plugin", "//:grpc_plugin", "//:grpc_ts_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf and gRPC-js ``.js`` and ``.d.ts`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_web_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:proto_ts_plugin", "//:grpc_web_js_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf and gRPC-Web ``.js`` and ``.d.ts`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_proto_library",
				Kind:             "proto",
				Implementation:   jsProtoLibraryRuleTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a JavaScript protobuf library using ``js_library`` from ``aspect_rules_js``",
				Attrs:            jsLibraryRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_library",
				Kind:             "grpc",
				Implementation:   jsGrpcLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Node.js protobuf + gRPC-js library using ``js_library`` from ``aspect_rules_js``",
				Attrs:            jsLibraryRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_web_library",
				Kind:             "grpc",
				Implementation:   jsGrpcWebLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a JavaScript protobuf + gRPC-Web library using ``js_library`` from ``aspect_rules_js``",
				Attrs:            jsLibraryRuleAttrs,
			},
		},
	}
}
