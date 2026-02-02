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
    "//:node_modules/google-protobuf",
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
    "//:node_modules/@grpc/grpc-js",
    "//:node_modules/google-protobuf",
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
    "//:node_modules/google-protobuf",
    "//:node_modules/grpc-web",
]`)

var jsProtoLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")
load("@rules_proto_grpc_js_npm//:defs.bzl", "npm_link_all_packages")

npm_link_all_packages(name = "node_modules")

{{ .Rule.Name }}(
    name = "person_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc_example_protos//:person_proto"],
    deps = ["place_{{ .Lang.Name }}_{{ .Rule.Kind }}"],
)

{{ .Rule.Name }}(
    name = "place_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc_example_protos//:place_proto"],
    deps = ["thing_{{ .Lang.Name }}_{{ .Rule.Kind }}"],
)

{{ .Rule.Name }}(
    name = "thing_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
)`)


var jsGrpcLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")
load("@rules_proto_grpc_js_npm//:defs.bzl", "npm_link_all_packages")

npm_link_all_packages(name = "node_modules")

{{ .Rule.Name }}(
    name = "thing_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
)

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
    deps = ["thing_{{ .Lang.Name }}_{{ .Rule.Kind }}"],
)`)

// See https://github.com/aspect-build/rules_js/discussions/2197. End user must access
// rules_proto_grpc_js_npm and then npm_link_all_packages in their root BUILD.bazel file as above
var jsModuleSuffixLines = `bazel_dep(name = "aspect_rules_js", version = "2.9.2")

# Allow npm_link_all_packages of rules_proto_grpc_js_npm from rules_proto_grpc_js
npm = use_extension("@aspect_rules_js//npm:extensions.bzl", "npm")
use_repo(npm, "rules_proto_grpc_js_npm")`

func makeJs() *Language {
	return &Language{
		Name:  "js",
		DisplayName: "JavaScript",
		Notes: mustTemplate("Rules for generating JavaScript protobuf, gRPC-js and gRPC-Web ``.js`` and ``.d.ts`` files using standard Protocol Buffers and gRPC."),
		ModuleSuffixLines: jsModuleSuffixLines,
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
				BuildExample:     jsProtoLibraryExampleTemplate,
				Doc:              "Generates a JavaScript protobuf library using ``js_library`` from ``aspect_rules_js``",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_library",
				Kind:             "grpc",
				Implementation:   jsGrpcLibraryRuleTemplate,
				BuildExample:     jsGrpcLibraryExampleTemplate,
				Doc:              "Generates a Node.js protobuf + gRPC-js library using ``js_library`` from ``aspect_rules_js``",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "js_grpc_web_library",
				Kind:             "grpc",
				Implementation:   jsGrpcWebLibraryRuleTemplate,
				BuildExample:     jsGrpcLibraryExampleTemplate,
				Doc:              "Generates a JavaScript protobuf + gRPC-Web library using ``js_library`` from ``aspect_rules_js``",
				Attrs:            compileRuleAttrs,
			},
		},
	}
}
