package main

var cProtoLibraryRuleTemplate = mustTemplate(`load("@rules_cc//cc:defs.bzl", "cc_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "filter_files", "proto_compile_attrs")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # Filter files to sources and headers
    filter_files(
        name = name_pb + "_srcs",
        target = name_pb,
        extensions = ["c"],
    )

    filter_files(
        name = name_pb + "_hdrs",
        target = name_pb,
        extensions = ["h"],
    )

    # Create {{ .Lang.Name }} library
    cc_library(
        name = name,
        srcs = [name_pb + "_srcs"],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        hdrs = [name_pb + "_hdrs"],
        includes = [name_pb],
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs + [
                "alwayslink",
                "copts",
                "defines",
                "include_prefix",
                "linkopts",
                "linkstatic",
                "local_defines",
                "nocopts",
                "strip_include_prefix",
            ]
        }
    )

PROTO_DEPS = [
    Label("@upb//:upb"),
]`)

// For C, we need to manually generate the files for any.proto
var cProtoLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "proto_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = [
        "@protobuf//:any_proto",
        "@rules_proto_grpc_example_protos//:person_proto",
        "@rules_proto_grpc_example_protos//:place_proto",
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
)`)

var cModuleExtraLines = `bazel_dep(name = "protobuf", version = "21.7")`

func makeC() *Language {
	return &Language{
		Name:  "c",
		DisplayName: "C",
		Notes: mustTemplate("Rules for generating C protobuf ``.c`` & ``.h`` files and libraries using `upb <https://github.com/protocolbuffers/upb>`_. Libraries are created with the Bazel native ``cc_library``"),
		ModuleExtraLines: cModuleExtraLines,
		Rules: []*Rule{
			&Rule{
				Name:             "c_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates C protobuf ``.h`` & ``.c`` files",
				Attrs:            compileRuleAttrs,
				Experimental:     true,
			},
			&Rule{
				Name:             "c_proto_library",
				Kind:             "proto",
				Implementation:   cProtoLibraryRuleTemplate,
				BuildExample:     cProtoLibraryExampleTemplate,
				Doc:              "Generates a C protobuf library using ``cc_library``, with dependencies linked",
				Attrs:            cppLibraryRuleAttrs,
				Experimental:     true,
			},
		},
	}
}
