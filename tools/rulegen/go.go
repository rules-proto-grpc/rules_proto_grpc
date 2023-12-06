package main

var goProtoLibraryRuleTemplate = mustTemplate(`load("@rules_go//go:def.bzl", "go_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:{{ .Rule.Base}}_{{ .Rule.Kind }}_compile.bzl", "{{ .Rule.Base }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Rule.Base}}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if (k in proto_compile_attrs.keys() and k != "prefix_path") or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create {{ .Lang.Name }} library
    go_library(
        name = name,
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + PROTO_DEPS + kwargs.get("deps", []),
        importpath = kwargs.get("importpath"),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

PROTO_DEPS = [
    Label("@org_golang_google_protobuf//proto:go_default_library"),
    Label("@org_golang_google_protobuf//encoding/protojson:go_default_library"),
    Label("@org_golang_google_protobuf//reflect/protoreflect:go_default_library"),
    Label("@org_golang_google_protobuf//runtime/protoimpl:go_default_library"),

    # Well-known types
    Label("@org_golang_google_protobuf//types/known/anypb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/apipb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/durationpb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/emptypb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/fieldmaskpb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/sourcecontextpb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/structpb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/timestamppb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/typepb:go_default_library"),
    Label("@org_golang_google_protobuf//types/known/wrapperspb:go_default_library"),
]`)

var goGrpcLibraryRuleTemplate = mustTemplate(`load("@rules_go//go:def.bzl", "go_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("//:{{ .Rule.Base }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Rule.Base }}_{{ .Rule.Kind }}_compile")
load("//:{{ .Rule.Base }}_proto_library.bzl", "PROTO_DEPS")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    {{ .Rule.Base}}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if (k in proto_compile_attrs.keys() and k != "prefix_path") or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create {{ .Lang.Name }} library
    go_library(
        name = name,
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + GRPC_DEPS + kwargs.get("deps", []),
        importpath = kwargs.get("importpath"),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    Label("@org_golang_google_grpc//:go_default_library"),
    Label("@org_golang_google_grpc//backoff:go_default_library"),
    Label("@org_golang_google_grpc//balancer:go_default_library"),
    Label("@org_golang_google_grpc//balancer/base:go_default_library"),
    Label("@org_golang_google_grpc//balancer/roundrobin:go_default_library"),
    Label("@org_golang_google_grpc//channelz:go_default_library"),
    Label("@org_golang_google_grpc//codes:go_default_library"),
    Label("@org_golang_google_grpc//connectivity:go_default_library"),
    Label("@org_golang_google_grpc//credentials:go_default_library"),
    Label("@org_golang_google_grpc//credentials/insecure:go_default_library"),
    Label("@org_golang_google_grpc//encoding:go_default_library"),
    Label("@org_golang_google_grpc//encoding/proto:go_default_library"),
    Label("@org_golang_google_grpc//grpclog:go_default_library"),
    Label("@org_golang_google_grpc//keepalive:go_default_library"),
    Label("@org_golang_google_grpc//metadata:go_default_library"),
    Label("@org_golang_google_grpc//peer:go_default_library"),
    Label("@org_golang_google_grpc//resolver:go_default_library"),
    Label("@org_golang_google_grpc//serviceconfig:go_default_library"),
    Label("@org_golang_google_grpc//stats:go_default_library"),
    Label("@org_golang_google_grpc//status:go_default_library"),
    Label("@org_golang_google_grpc//tap:go_default_library"),
] + PROTO_DEPS`)

// For go, produce one library for all protos, since they are all in the same package
var goProtoLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "proto_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    importpath = "github.com/rules-proto-grpc/rules_proto_grpc/example/proto",
    protos = [
        "@rules_proto_grpc_example_protos//:person_proto",
        "@rules_proto_grpc_example_protos//:place_proto",
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
)`)

var goGrpcLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    importpath = "github.com/rules-proto-grpc/rules_proto_grpc/example/proto",
    protos = [
        "@rules_proto_grpc_example_protos//:greeter_grpc",
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
)`)

var goLibraryRuleAttrs = append(append([]*Attr(nil), libraryRuleAttrs...), []*Attr{
	&Attr{
		Name:      "importpath",
		Type:      "string",
		Default:   "None",
		Doc:       "Importpath for the generated files",
		Mandatory: false,
	},
}...)

func makeGo() *Language {
	return &Language{
		Name:        "go",
		DisplayName: "Go",
		Notes:       mustTemplate("Rules for generating Go protobuf and gRPC ``.go`` files and libraries using `golang/protobuf <https://github.com/golang/protobuf>`_. Libraries are created with ``go_library`` from `rules_go <https://github.com/bazelbuild/rules_go>`_"),
		ExtraDefs: map[string]string{
			"GRPC_DEPS": ":go_grpc_library.bzl",
			"PROTO_DEPS": ":go_proto_library.bzl",
		},
		Rules: []*Rule{
			&Rule{
				Name:             "go_proto_compile",
				Base:             "go",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Go protobuf ``.go`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "go_grpc_compile",
				Base:             "go",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:grpc_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Go protobuf and gRPC ``.go`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "go_proto_library",
				Base:             "go",
				Kind:             "proto",
				Implementation:   goProtoLibraryRuleTemplate,
				BuildExample:     goProtoLibraryExampleTemplate,
				Doc:              "Generates a Go protobuf library using ``go_library`` from ``rules_go``",
				Attrs:            goLibraryRuleAttrs,
			},
			&Rule{
				Name:             "go_grpc_library",
				Base:             "go",
				Kind:             "grpc",
				Implementation:   goGrpcLibraryRuleTemplate,
				BuildExample:     goGrpcLibraryExampleTemplate,
				Doc:              "Generates a Go protobuf and gRPC library using ``go_library`` from ``rules_go``",
				Attrs:            goLibraryRuleAttrs,
			},
		},
	}
}
