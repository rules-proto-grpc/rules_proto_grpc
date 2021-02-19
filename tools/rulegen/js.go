package main

var jsWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

yarn_install(
    name = "js_modules",
    package_json = "@rules_proto_grpc//js:requirements/package.json",
    yarn_lock = "@rules_proto_grpc//js:requirements/yarn.lock",
)`)

var jsProtoLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.ArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    js_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = kwargs.get("name"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@js_modules//google-protobuf",
]`)

var nodeGrpcLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:js_grpc_node_compile.bzl", "js_grpc_node_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    js_grpc_node_compile(
        name = name_pb,
        {{ .Common.ArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    js_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = kwargs.get("name"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@js_modules//google-protobuf",
    "@js_modules//@grpc/grpc-js",
]`)

var jsGrpcWebLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:js_grpc_web_compile.bzl", "js_grpc_web_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    js_grpc_web_compile(
        name = name_pb,
        {{ .Common.ArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    js_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = kwargs.get("name"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@js_modules//google-protobuf",
    "@js_modules//grpc-web",
]`)

func makeJavaScript() *Language {
	return &Language{
		Dir:   "js",
		Name:  "js",
		DisplayName: "JavaScript",
		Notes: mustTemplate("Rules for generating JavaScript protobuf, gRPC-node and gRPC-Web `.js` and `.d.ts` files using standard Protocol Buffers and gRPC."),
		Flags: commonLangFlags,
		Aliases: map[string]string{
			"nodejs_proto_compile": "js_proto_compile",
			"nodejs_proto_library": "js_proto_library",
			"nodejs_grpc_compile": "js_grpc_node_compile",
			"nodejs_grpc_library": "js_grpc_node_library",
		},
		Rules: []*Rule{
			&Rule{
				Name:             "js_proto_compile",
				Kind:             "proto",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//js:js_plugin", "//js:ts_plugin"},
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf `.js` and `.d.ts` artifacts",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_node_compile",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//js:js_plugin", "//js:grpc_node_plugin", "//js:grpc_node_ts_plugin"},  // Don't need ts_plugin here, as grpc_node_ts_plugin will do both proto and grpc
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf + gRPC-node `.js` and `.d.ts` artifacts",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_web_compile",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//js:js_plugin", "//js:grpc_web_js_plugin"},
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf + gRPC-Web `.js` and `.d.ts` artifacts",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_proto_library",
				Kind:             "proto",
				Implementation:   jsProtoLibraryRuleTemplate,
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a JavaScript protobuf library using `js_library` from `rules_nodejs`",
				Attrs:            libraryRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_node_library",
				Kind:             "grpc",
				Implementation:   nodeGrpcLibraryRuleTemplate,
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Node.js protobuf + gRPC-node library using `js_library` from `rules_nodejs`",
				Attrs:            libraryRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_web_library",
				Kind:             "grpc",
				Implementation:   jsGrpcWebLibraryRuleTemplate,
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a JavaScript protobuf + gRPC-Web library using `js_library` from `rules_nodejs`",
				Attrs:            libraryRuleAttrs,
			},
		},
	}
}
