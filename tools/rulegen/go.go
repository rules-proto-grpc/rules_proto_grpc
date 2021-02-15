package main

var goWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//:repositories.bzl", "bazel_gazelle", "io_bazel_rules_go")  # buildifier: disable=same-origin-load

io_bazel_rules_go()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(
    version = "1.15.8",
)

bazel_gazelle()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()`)

var goLibraryRuleTemplateString = `load("//{{ .Lang.Dir }}:{{ .Rule.Base}}_{{ .Rule.Kind }}_compile.bzl", "{{ .Rule.Base }}_{{ .Rule.Kind }}_compile")
load("//internal:compile.bzl", "proto_compile_attrs")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    {{ .Rule.Base}}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + [
                key
                for key in proto_compile_attrs.keys()
                if key != "prefix_path"
            ]
        }  # Forward args
    )
`

var goProtoLibraryRuleTemplate = mustTemplate(goLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    go_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        importpath = kwargs.get("importpath"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@com_github_golang_protobuf//proto:go_default_library",
    "@org_golang_google_protobuf//reflect/protoreflect:go_default_library",
    "@org_golang_google_protobuf//runtime/protoimpl:go_default_library",

    # Well-known types
    "@org_golang_google_protobuf//types/known/anypb:go_default_library",
    "@org_golang_google_protobuf//types/known/apipb:go_default_library",
    "@org_golang_google_protobuf//types/known/durationpb:go_default_library",
    "@org_golang_google_protobuf//types/known/emptypb:go_default_library",
    "@org_golang_google_protobuf//types/known/fieldmaskpb:go_default_library",
    "@org_golang_google_protobuf//types/known/sourcecontextpb:go_default_library",
    "@org_golang_google_protobuf//types/known/structpb:go_default_library",
    "@org_golang_google_protobuf//types/known/timestamppb:go_default_library",
    "@org_golang_google_protobuf//types/known/typepb:go_default_library",
    "@org_golang_google_protobuf//types/known/wrapperspb:go_default_library",
]`)

var goGrpcLibraryRuleTemplate = mustTemplate(
	`load("//{{ .Lang.Dir }}:{{ .Rule.Base}}_proto_library.bzl", "PROTO_DEPS")
` + goLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    go_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + GRPC_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        importpath = kwargs.get("importpath"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

GRPC_DEPS = [
    "@org_golang_google_grpc//:go_default_library",
    "@org_golang_google_grpc//codes:go_default_library",
    "@org_golang_google_grpc//status:go_default_library",
] + PROTO_DEPS`)

// For go, produce one library for all protos, since they are all in the same package
var goProtoLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "proto_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    importpath = "github.com/rules-proto-grpc/rules_proto_grpc/example/proto",
    protos = [
        "@rules_proto_grpc//example/proto:person_proto",
        "@rules_proto_grpc//example/proto:place_proto",
        "@rules_proto_grpc//example/proto:thing_proto",
    ],
)`)

var goGrpcLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    importpath = "github.com/rules-proto-grpc/rules_proto_grpc/example/proto",
    protos = [
        "@rules_proto_grpc//example/proto:greeter_grpc",
        "@rules_proto_grpc//example/proto:thing_proto",
    ],
)`)

var goLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "importpath",
		Type:      "string",
		Default:   "None",
		Doc:       "Importpath for the generated artifacts",
		Mandatory: false,
	},
}...)

func makeGo() *Language {
	return &Language{
		Dir:         "go",
		Name:        "go",
		DisplayName: "Go",
		Notes:       mustTemplate("Rules for generating Go protobuf and gRPC `.go` files and libraries using [golang/protobuf](https://github.com/golang/protobuf). Libraries are created with `go_library` from [rules_go](https://github.com/bazelbuild/rules_go)"),
		Flags:       commonLangFlags,
		Rules: []*Rule{
			&Rule{
				Name:             "go_proto_compile",
				Base:             "go",
				Kind:             "proto",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//go:go_plugin"},
				WorkspaceExample: goWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Go protobuf `.go` artifacts",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "go_grpc_compile",
				Base:             "go",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//go:go_plugin", "//go:grpc_go_plugin"},
				WorkspaceExample: goWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Go protobuf+gRPC `.go` artifacts",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "go_proto_library",
				Base:             "go",
				Kind:             "proto",
				Implementation:   goProtoLibraryRuleTemplate,
				WorkspaceExample: goWorkspaceTemplate,
				BuildExample:     goProtoLibraryExampleTemplate,
				Doc:              "Generates a Go protobuf library using `go_library` from `rules_go`",
				Attrs:            goLibraryRuleAttrs,
			},
			&Rule{
				Name:             "go_grpc_library",
				Base:             "go",
				Kind:             "grpc",
				Implementation:   goGrpcLibraryRuleTemplate,
				WorkspaceExample: goWorkspaceTemplate,
				BuildExample:     goGrpcLibraryExampleTemplate,
				Doc:              "Generates a Go protobuf+gRPC library using `go_library` from `rules_go`",
				Attrs:            goLibraryRuleAttrs,
			},
		},
	}
}
