package main

var cppLibraryRuleTemplateString = `load("@rules_cc//cc:defs.bzl", "cc_library")
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
        extensions = ["cc"],
    )

    filter_files(
        name = name_pb + "_hdrs",
        target = name_pb,
        extensions = ["h"],
    )
`

var cppProtoLibraryRuleTemplate = mustTemplate(cppLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    cc_library(
        name = name,
        srcs = [name_pb + "_srcs"],
        deps = kwargs.get("deps", [
            Label("@protobuf//:protobuf"),
        ]),
        hdrs = [name_pb + "_hdrs"],
        includes = [name_pb] if kwargs.get("output_mode", "PREFIXED") == "PREFIXED" else ["."],
        alwayslink = kwargs.get("alwayslink"),
        copts = kwargs.get("copts"),
        defines = kwargs.get("defines"),
        include_prefix = kwargs.get("include_prefix"),
        linkopts = kwargs.get("linkopts"),
        linkstatic = kwargs.get("linkstatic"),
        local_defines = kwargs.get("local_defines"),
        nocopts = kwargs.get("nocopts"),
        strip_include_prefix = kwargs.get("strip_include_prefix"),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )`)

var cppGrpcLibraryRuleTemplate = mustTemplate(cppLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    cc_library(
        name = name,
        srcs = [name_pb + "_srcs"],
        deps = kwargs.get("deps", [
            Label("@protobuf//:protobuf"),
            Label("@grpc//:grpc++"),
            # Label("@grpc//:grpc++_reflection"),  # TODO: See https://github.com/bazelbuild/bazel-central-registry/issues/841
        ]),
        hdrs = [name_pb + "_hdrs"],
        includes = [name_pb] if kwargs.get("output_mode", "PREFIXED") == "PREFIXED" else ["."],
        alwayslink = kwargs.get("alwayslink"),
        copts = kwargs.get("copts"),
        defines = kwargs.get("defines"),
        include_prefix = kwargs.get("include_prefix"),
        linkopts = kwargs.get("linkopts"),
        linkstatic = kwargs.get("linkstatic"),
        local_defines = kwargs.get("local_defines"),
        nocopts = kwargs.get("nocopts"),
        strip_include_prefix = kwargs.get("strip_include_prefix"),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )`)

var cppLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "alwayslink",
		Type:      "bool",
		Default:   "None",
		Doc:       "Passed to the ``alwayslink`` attribute of ``cc_library``.",
		Mandatory: false,
	},
	&Attr{
		Name:      "copts",
		Type:      "string_list",
		Default:   "None",
		Doc:       "Passed to the ``opts`` attribute of ``cc_library``.",
		Mandatory: false,
	},
	&Attr{
		Name:      "defines",
		Type:      "string_list",
		Default:   "None",
		Doc:       "Passed to the ``defines`` attribute of ``cc_library``.",
		Mandatory: false,
	},
	&Attr{
		Name:      "include_prefix",
		Type:      "string",
		Default:   "None",
		Doc:       "Passed to the ``include_prefix`` attribute of ``cc_library``.",
		Mandatory: false,
	},
	&Attr{
		Name:      "linkopts",
		Type:      "string_list",
		Default:   "None",
		Doc:       "Passed to the ``linkopts`` attribute of ``cc_library``.",
		Mandatory: false,
	},
	&Attr{
		Name:      "linkstatic",
		Type:      "bool",
		Default:   "None",
		Doc:       "Passed to the ``linkstatic`` attribute of ``cc_library``.",
		Mandatory: false,
	},
	&Attr{
		Name:      "local_defines",
		Type:      "string_list",
		Default:   "None",
		Doc:       "Passed to the ``local_defines`` attribute of ``cc_library``.",
		Mandatory: false,
	},
	&Attr{
		Name:      "nocopts",
		Type:      "string",
		Default:   "None",
		Doc:       "Passed to the ``nocopts`` attribute of ``cc_library``.",
		Mandatory: false,
	},
	&Attr{
		Name:      "strip_include_prefix",
		Type:      "string",
		Default:   "None",
		Doc:       "Passed to the ``strip_include_prefix`` attribute of ``cc_library``.",
		Mandatory: false,
	},
}...)

func makeCpp() *Language {
	return &Language{
		Name:  "cpp",
		DisplayName: "C++",
		Notes: mustTemplate("Rules for generating C++ protobuf and gRPC ``.cc`` & ``.h`` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with the Bazel native ``cc_library``"),
		Aliases: map[string]string{
			"cc_proto_compile": "cpp_proto_compile",
			"cc_grpc_compile": "cpp_grpc_compile",
			"cc_proto_library": "cpp_proto_library",
			"cc_grpc_library": "cpp_grpc_library",
		},
		Rules: []*Rule{
			&Rule{
				Name:             "cpp_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates C++ protobuf ``.h`` & ``.cc`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "cpp_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:grpc_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates C++ protobuf and gRPC ``.h`` & ``.cc`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "cpp_proto_library",
				Kind:             "proto",
				Implementation:   cppProtoLibraryRuleTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a C++ protobuf library using ``cc_library``, with dependencies linked",
				Attrs:            cppLibraryRuleAttrs,
			},
			&Rule{
				Name:             "cpp_grpc_library",
				Kind:             "grpc",
				Implementation:   cppGrpcLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a C++ protobuf and gRPC library using ``cc_library``, with dependencies linked",
				Attrs:            cppLibraryRuleAttrs,
			},
		},
	}
}
