package main

var objcLibraryRuleTemplateString = `load("@rules_cc//cc:defs.bzl", "objc_library")
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
        extensions = ["m"],
    )

    filter_files(
        name = name_pb + "_hdrs",
        target = name_pb,
        extensions = ["h"],
    )
`

var objcProtoLibraryRuleTemplate = mustTemplate(objcLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    objc_library(
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
        },
    )

PROTO_DEPS = [
    Label("@protobuf//:protobuf_objc"),
]`)

var objcGrpcLibraryRuleTemplate = mustTemplate(objcLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    objc_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
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
        },
    )

GRPC_DEPS = [
    Label("@protobuf//:protobuf_objc"),
    Label("@grpc//src/objective-c:proto_objc_rpc"),
]`)

func makeObjc() *Language {
	return &Language{
		Name:  "objc",
		DisplayName: "Objective-C",
		Notes: mustTemplate("Rules for generating Objective-C protobuf and gRPC ``.m`` & ``.h`` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with the Bazel native ``objc_library``"),
		SkipTestPlatforms: []string{"linux", "windows"},
		Rules: []*Rule{
			&Rule{
				Name:             "objc_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Objective-C protobuf ``.m`` & ``.h`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "objc_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:grpc_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Objective-C protobuf and gRPC ``.m`` & ``.h`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "objc_proto_library",
				Kind:             "proto",
				Implementation:   objcProtoLibraryRuleTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates an Objective-C protobuf library using ``objc_library``",
				Attrs:            cppLibraryRuleAttrs,
			},
			&Rule{
				Name:             "objc_grpc_library",
				Kind:             "grpc",
				Implementation:   objcGrpcLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates an Objective-C protobuf and gRPC library using ``objc_library``",
				Attrs:            cppLibraryRuleAttrs,
				Experimental:     true,
			},
		},
	}
}
