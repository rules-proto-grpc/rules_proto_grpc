package main

var cppLibraryRuleTemplateString = `load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("//internal:filter_files.bzl", "filter_files")
load("@rules_cc//cc:defs.bzl", "cc_library")

def {{ .Rule.Name }}(name, **kwargs):  # buildifier: disable=function-docstring
    # Compile protos
    name_pb = name + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.ArgsForwardingSnippet }}
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
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        hdrs = [name_pb + "_hdrs"],
        includes = [name_pb],
        alwayslink = kwargs.get("alwayslink"),
        copts = kwargs.get("copts"),
        defines = kwargs.get("defines"),
        include_prefix = kwargs.get("include_prefix"),
        linkopts = kwargs.get("linkopts"),
        linkstatic = kwargs.get("linkstatic"),
        local_defines = kwargs.get("local_defines"),
        nocopts = kwargs.get("nocopts"),
        strip_include_prefix = kwargs.get("strip_include_prefix"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf",
]`)

var cppGrpcLibraryRuleTemplate = mustTemplate(cppLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    cc_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        includes = [name_pb],
        alwayslink = kwargs.get("alwayslink"),
        copts = kwargs.get("copts"),
        defines = kwargs.get("defines"),
        include_prefix = kwargs.get("include_prefix"),
        linkopts = kwargs.get("linkopts"),
        linkstatic = kwargs.get("linkstatic"),
        local_defines = kwargs.get("local_defines"),
        nocopts = kwargs.get("nocopts"),
        strip_include_prefix = kwargs.get("strip_include_prefix"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@com_google_protobuf//:protobuf",
    "@com_github_grpc_grpc//:grpc++",
    "@com_github_grpc_grpc//:grpc++_reflection",
]`)

var cppLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "alwayslink",
		Type:      "bool",
		Default:   "None",
		Doc:       "Passed to the `alwayslink` attribute of `cc_library`.",
		Mandatory: false,
	},
	&Attr{
		Name:      "copts",
		Type:      "list<string>",
		Default:   "None",
		Doc:       "Passed to the `opts` attribute of `cc_library`.",
		Mandatory: false,
	},
	&Attr{
		Name:      "defines",
		Type:      "list<string>",
		Default:   "None",
		Doc:       "Passed to the `defines` attribute of `cc_library`.",
		Mandatory: false,
	},
	&Attr{
		Name:      "include_prefix",
		Type:      "string",
		Default:   "None",
		Doc:       "Passed to the `include_prefix` attribute of `cc_library`.",
		Mandatory: false,
	},
	&Attr{
		Name:      "linkopts",
		Type:      "list<string>",
		Default:   "None",
		Doc:       "Passed to the `linkopts` attribute of `cc_library`.",
		Mandatory: false,
	},
	&Attr{
		Name:      "linkstatic",
		Type:      "bool",
		Default:   "None",
		Doc:       "Passed to the `linkstatic` attribute of `cc_library`.",
		Mandatory: false,
	},
	&Attr{
		Name:      "local_defines",
		Type:      "list<string>",
		Default:   "None",
		Doc:       "Passed to the `local_defines` attribute of `cc_library`.",
		Mandatory: false,
	},
	&Attr{
		Name:      "nocopts",
		Type:      "string",
		Default:   "None",
		Doc:       "Passed to the `nocopts` attribute of `cc_library`.",
		Mandatory: false,
	},
	&Attr{
		Name:      "strip_include_prefix",
		Type:      "string",
		Default:   "None",
		Doc:       "Passed to the `strip_include_prefix` attribute of `cc_library`.",
		Mandatory: false,
	},
}...)

func makeCpp() *Language {
	return &Language{
		Dir:   "cpp",
		Name:  "cpp",
		DisplayName: "C++",
		Notes: mustTemplate("Rules for generating C++ protobuf and gRPC `.cc` & `.h` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with the Bazel native `cc_library`"),
		Flags: commonLangFlags,
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
				Plugins:          []string{"//cpp:cpp_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates C++ protobuf `.h` & `.cc` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "cpp_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//cpp:cpp_plugin", "//cpp:grpc_cpp_plugin"},
				WorkspaceExample: grpcWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates C++ protobuf and gRPC `.h` & `.cc` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "cpp_proto_library",
				Kind:             "proto",
				Implementation:   cppProtoLibraryRuleTemplate,
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a C++ protobuf library using `cc_library`, with dependencies linked",
				Attrs:            cppLibraryRuleAttrs,
			},
			&Rule{
				Name:             "cpp_grpc_library",
				Kind:             "grpc",
				Implementation:   cppGrpcLibraryRuleTemplate,
				WorkspaceExample: grpcWorkspaceTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a C++ protobuf and gRPC library using `cc_library`, with dependencies linked",
				Attrs:            cppLibraryRuleAttrs,
			},
		},
	}
}
