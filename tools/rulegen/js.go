package main

var jsWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

yarn_install(
    name = "npm",
    package_json = "@rules_proto_grpc//js:requirements/package.json",  # This should be changed to your local package.json which should contain the dependencies required
    yarn_lock = "@rules_proto_grpc//js:requirements/yarn.lock",
)`)

var jsProtoLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.ArgsForwardingSnippet }}
    )

    # Resolve deps
    deps = [
        dep.replace("@npm", kwargs.get("deps_repo", "@npm"))
        for dep in PROTO_DEPS
    ]

    # Create {{ .Lang.Name }} library
    js_library(
        name = name,
        srcs = [name_pb],
        deps = deps + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = name,
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@npm//google-protobuf",
]`)

var nodeGrpcLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:js_grpc_node_compile.bzl", "js_grpc_node_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    js_grpc_node_compile(
        name = name_pb,
        {{ .Common.ArgsForwardingSnippet }}
    )

    # Resolve deps
    deps = [
        dep.replace("@npm", kwargs.get("deps_repo", "@npm"))
        for dep in GRPC_DEPS
    ]

    # Create {{ .Lang.Name }} library
    js_library(
        name = name,
        srcs = [name_pb],
        deps = deps + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = name,
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@npm//google-protobuf",
    "@npm//@grpc/grpc-js",
]`)

var jsGrpcWebLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:js_grpc_web_compile.bzl", "js_grpc_web_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    js_grpc_web_compile(
        name = name_pb,
        {{ .Common.ArgsForwardingSnippet }}
    )

    # Resolve deps
    deps = [
        dep.replace("@npm", kwargs.get("deps_repo", "@npm"))
        for dep in GRPC_DEPS
    ]

    # Create {{ .Lang.Name }} library
    js_library(
        name = name,
        srcs = [name_pb],
        deps = deps + (kwargs.get("deps", []) if "protos" in kwargs else []),
        package_name = name,
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@npm//google-protobuf",
    "@npm//grpc-web",
]`)

var jsLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "deps_repo",
		Type:      "string",
		Default:   "@npm",
		Doc:       "The repository to load the dependencies from, if you don't use @npm",
		Mandatory: false,
	},
}...)

var jsDependencyNote = `

> Note that you must add the required dependencies to your package.json file:
> ` + "```json" + `
> "dependencies": {
>   "@grpc/grpc-js": "1.2.6",
>   "google-protobuf": "3.15.2",
>   "grpc-tools": "1.10.0",
>   "grpc-web": "1.2.1",
>   "ts-protoc-gen": "0.14.0"
> }
> ` + "```"

func makeJavaScript() *Language {
	return &Language{
		Dir:   "js",
		Name:  "js",
		DisplayName: "JavaScript",
		Notes: mustTemplate("Rules for generating JavaScript protobuf, gRPC-node and gRPC-Web `.js` and `.d.ts` files using standard Protocol Buffers and gRPC." + jsDependencyNote),
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
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//js:js_plugin", "//js:ts_plugin"},
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf `.js` and `.d.ts` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_node_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//js:js_plugin", "//js:grpc_node_plugin", "//js:grpc_node_ts_plugin"},  // Don't need ts_plugin here, as grpc_node_ts_plugin will do both proto and grpc
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf and gRPC-node `.js` and `.d.ts` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_web_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//js:js_plugin", "//js:grpc_web_js_plugin"},
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates JavaScript protobuf and gRPC-Web `.js` and `.d.ts` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_proto_library",
				Kind:             "proto",
				Implementation:   jsProtoLibraryRuleTemplate,
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a JavaScript protobuf library using `js_library` from `rules_nodejs`",
				Attrs:            jsLibraryRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_node_library",
				Kind:             "grpc",
				Implementation:   nodeGrpcLibraryRuleTemplate,
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Node.js protobuf + gRPC-node library using `js_library` from `rules_nodejs`",
				Attrs:            jsLibraryRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_web_library",
				Kind:             "grpc",
				Implementation:   jsGrpcWebLibraryRuleTemplate,
				WorkspaceExample: jsWorkspaceTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a JavaScript protobuf + gRPC-Web library using `js_library` from `rules_nodejs`",
				Attrs:            jsLibraryRuleAttrs,
			},
		},
	}
}
