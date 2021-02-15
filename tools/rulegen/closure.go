package main

var closureLibraryWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")

rules_closure_dependencies(
    omit_bazel_skylib = True,
    omit_com_google_protobuf = True,
    omit_zlib = True,
)

rules_closure_toolchains()`)

var closureProtoLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        {{ .Common.ArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    closure_js_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
        suppress = [],
    )

PROTO_DEPS = [
    "@io_bazel_rules_closure//closure/protobuf:jspb",
]`)

func makeClosure() *Language {
	return &Language{
		Dir:   "closure",
		Name:  "closure",
		DisplayName: "Closure",
		Notes: mustTemplate("Rules for generating Closure protobuf `.js` files and libraries using standard Protocol Buffers. Libraries are created with `closure_js_library` from [rules_closure](https://github.com/bazelbuild/rules_closure)"),
		Flags: commonLangFlags,
		Rules: []*Rule{
			&Rule{
				Name:             "closure_proto_compile",
				Kind:             "proto",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//closure:js_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Closure protobuf `.js` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "closure_proto_library",
				Kind:             "proto",
				Implementation:   closureProtoLibraryRuleTemplate,
				WorkspaceExample: closureLibraryWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a Closure library with compiled protobuf `.js` files using `closure_js_library` from `rules_closure`",
				Attrs:            libraryRuleAttrs,
			},
		},
	}
}
