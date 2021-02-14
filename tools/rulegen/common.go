package main


var commonLangFlags = []*Flag{}


var compileRuleAttrs = []*Attr{
    &Attr{
		Name:      "protos",
		Type:      "list<ProtoInfo>",
		Default:   "[]",
		Doc:       "List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)",
		Mandatory: true,
	},
	&Attr{
		Name:      "verbose",
		Type:      "int",
		Default:   "0",
		Doc:       "The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*",
		Mandatory: false,
	},
}


var libraryRuleAttrs = append(append([]*Attr(nil), compileRuleAttrs...), []*Attr{
    &Attr{
		Name:      "deps",
		Type:      "list",
		Default:   "[]",
		Doc:       "List of labels to pass as deps attr to underlying lang_library rule",
		Mandatory: false,
	},
}...)


var aspectRuleTemplate = mustTemplate(`load("@rules_proto//proto:defs.bzl", "ProtoInfo")
load(
    "//:defs.bzl",
    "ProtoLibraryAspectNodeInfo",
    "ProtoPluginInfo",
    "proto_compile_aspect_attrs",
    "proto_compile_aspect_impl",
    "proto_compile_attrs",
    "proto_compile_impl",
)

# Create aspect for {{ .Rule.Name }}
{{ .Rule.Name }}_aspect = aspect(
    implementation = proto_compile_aspect_impl,
    provides = [ProtoLibraryAspectNodeInfo],
    attr_aspects = ["deps"],
    attrs = dict(
        proto_compile_aspect_attrs,
        _plugins = attr.label_list(
            doc = "List of protoc plugins to apply",
            providers = [ProtoPluginInfo],
            default = [{{ range .Rule.Plugins }}
                Label("{{ . }}"),{{ end }}
            ],
        ),
        _prefix = attr.string(
            doc = "String used to disambiguate aspects when generating outputs",
            default = "{{ .Rule.Name }}_aspect",
        ),
    ),
    toolchains = [str(Label("//protobuf:toolchain_type"))],
)

# Create compile rule to apply aspect
_rule = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        protos = attr.label_list(
            mandatory = False,  # TODO: set to true in 4.0.0 when deps removed below
            providers = [ProtoInfo, ProtoLibraryAspectNodeInfo],
            aspects = [{{ .Rule.Name }}_aspect],
            doc = "List of labels that provide a ProtoInfo (such as rules_proto proto_library)",
        ),
        deps = attr.label_list(
            mandatory = False,
            providers = [ProtoInfo, ProtoLibraryAspectNodeInfo],
            aspects = [{{ .Rule.Name }}_aspect],
            doc = "DEPRECATED: Use protos attr",
        ),
    ),
)

# Create macro for converting attrs and passing to compile
def {{ .Rule.Name }}(**kwargs):
    _rule(
        verbose_string = "{}".format(kwargs.get("verbose", 0)),
        merge_directories = {{ if .Lang.SkipDirectoriesMerge }}False{{else}}True{{end}},
        **{k: v for k, v in kwargs.items() if k != "merge_directories"}
    )`)


var protoWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()`)


var grpcWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos = "{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()`)


var protoCompileExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "person_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

{{ .Rule.Name }}(
    name = "place_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

{{ .Rule.Name }}(
    name = "thing_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)`)


var grpcCompileExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "thing_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)`)


var protoLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "person_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_{{ .Lang.Name }}_{{ .Rule.Kind }}"],
)

{{ .Rule.Name }}(
    name = "place_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_{{ .Lang.Name }}_{{ .Rule.Kind }}"],
)

{{ .Rule.Name }}(
    name = "thing_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)`)


var grpcLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "thing_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
    deps = ["thing_{{ .Lang.Name }}_{{ .Rule.Kind }}"],
)`)
