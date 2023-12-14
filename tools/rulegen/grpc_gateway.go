package main

var grpcGatewayLibraryRuleTemplate = mustTemplate(`load("@rules_go//go:def.bzl", "go_library")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_proto_grpc_go//:defs.bzl", "GRPC_DEPS")
load("//:gateway_grpc_compile.bzl", "gateway_grpc_compile")

def {{ .Rule.Name }}(name, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    gateway_{{ .Rule.Kind }}_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if (k in proto_compile_attrs.keys() and k != "prefix_path") or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create go library
    go_library(
        name = name,
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + GATEWAY_DEPS + GRPC_DEPS + kwargs.get("deps", []),
        importpath = kwargs.get("importpath"),
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GATEWAY_DEPS = [
    Label("@com_github_grpc_ecosystem_grpc_gateway_v2//runtime:go_default_library"),
    Label("@com_github_grpc_ecosystem_grpc_gateway_v2//utilities:go_default_library"),
    # Label("@go_googleapis//google/api:annotations_go_proto"),  # https://github.com/bazelbuild/bazel-central-registry/issues/1113
]`)

var grpcGatewayCompileExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "api_gateway_grpc",
    protos = ["@rules_proto_grpc_example_protos//:api_proto"],
)`)

var grpcGatewayLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "api_gateway_library",
    importpath = "github.com/rules-proto-grpc/rules_proto_grpc/grpc-gateway/examples/api",
    protos = ["@rules_proto_grpc_example_protos//:api_proto"],
)`)

func makeGrpcGateway() *Language {
	return &Language{
		Name:        "grpc_gateway",
		DisplayName: "gRPC-Gateway",
		DependsOn: []string{"go"},
		ExtraDefs: map[string]string{
			"GATEWAY_DEPS": ":gateway_grpc_library.bzl",
		},
		Rules: []*Rule{
			&Rule{
				Name:             "gateway_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:plugin", "@rules_proto_grpc_go//:grpc_plugin", "@rules_proto_grpc_go//:proto_plugin"},
				BuildExample:     grpcGatewayCompileExampleTemplate,
				Doc:              "Generates gRPC-Gateway ``.go`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:              "gateway_openapiv2_compile",
				Kind:              "grpc",
				Implementation:    compileRuleTemplate,
				Plugins:           []string{"//:openapiv2_plugin"},
				BuildExample:      grpcGatewayCompileExampleTemplate,
				Doc:               "Generates gRPC-Gateway OpenAPI v2 ``.json`` files",
				Attrs:             compileRuleAttrs,
				SkipTestPlatforms: []string{"windows"}, // gRPC go lib rules fail on windows due to bad path
			},
			&Rule{
				Name:              "gateway_grpc_library",
				Kind:              "grpc",
				Implementation:    grpcGatewayLibraryRuleTemplate,
				BuildExample:      grpcGatewayLibraryExampleTemplate,
				Doc:               "Generates gRPC-Gateway library files",
				Attrs:             goLibraryRuleAttrs,
				SkipTestPlatforms: []string{"windows"}, // gRPC go lib rules fail on windows due to bad path
			},
		},
	}
}
