package main

var rustCompileRuleTemplate = mustTemplate(`load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_toolchains",
)
load(":common.bzl", "RustProtoInfo", "rust_compile_attrs", "rust_proto_compile_impl")

# Create compile rule
{{ .Rule.Name }} = rule(
    implementation = rust_proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        proto_deps = attr.label_list(
            providers = [RustProtoInfo],
            mandatory = False,
            doc = "Other Rust proto compile targets that this proto directly depends upon. Used to generate extern_path options.",
        ),
        declared_proto_packages = attr.string_list(
            mandatory = True,
            doc = "List of proto packages that this rule generates Rust bindings for.",
        ),
        crate_name = attr.string(
            mandatory = False,
            doc = "Name of the Rust crate these protos will be compiled into later using rust_library.",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [{{ range .Rule.Plugins }}
                Label("{{ . }}"),{{ end }}
            ],
            cfg = "exec",
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = proto_compile_toolchains,
)`)

var rustLibraryRuleTemplateString = `load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_rust//rust:defs.bzl", "rust_library")
load(":common.bzl", "crate_label", "prepare_rust_proto_deps", "rust_compile_attrs")
load(":rust_fixer.bzl", "rust_proto_crate_fixer", "rust_proto_crate_root")
load(":{{ .Rule.Base }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Rule.Base }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, **kwargs):
    """Generates Rust {{ .Rule.Kind }} code and wraps it in a `rust_library`.

    Args:
        name: Name of the generated `rust_library` target.
        **kwargs: Common Bazel attributes are forwarded to both generated
            targets; proto compile attributes are forwarded to
            `{{ .Rule.Base }}_{{ .Rule.Kind }}_compile`; Rust-specific attributes
            such as `crate_name`, `declared_proto_packages`, and `proto_deps`
            configure crate generation.
    """
    # Compile protos
    name_pb = name + "_pb"
    name_fixed = name_pb + "_fixed"
    name_root = name + "_root"

    proto_deps = kwargs.get("proto_deps", [])
    rust_proto_compiled_targets = prepare_rust_proto_deps(proto_deps)

    {{ .Rule.Base }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        crate_name = kwargs.get("crate_name", name),
        proto_deps = rust_proto_compiled_targets,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs or
               (k in rust_compile_attrs and k not in ["crate_name", "proto_deps"])
        }  # Forward args
    )

    # Rust plugin fragments are sibling files, not modules. After the isolated
    # plugin outputs are merged, wire matching serde/gRPC siblings into the base
    # module files before handing the tree to rust_library.
    rust_proto_crate_fixer(
        name = name_fixed,
        compilation = name_pb,
    )

    rust_proto_crate_root(
        name = name_root,
        crate_dir = name_fixed,
    )
`

var rustProtoLibraryRuleTemplate = mustTemplate(rustLibraryRuleTemplateString + `
    # Create {{ .Rule.Base }} library
    rust_library(
        name = name,
        crate_name = kwargs.get("crate_name", name),
        crate_root = name_root,
        edition = kwargs.get("edition", "2021"),
        srcs = [name_fixed],
        deps = [crate_label("prost"), crate_label("prost-types"), crate_label("proto-types")] +
               [crate_label("pbjson"), crate_label("pbjson-types")] +
               [crate_label("serde")] +
               kwargs.get("deps", []) +
               proto_deps,
        proc_macro_deps = kwargs.get("proc_macro_deps", []) + [
            crate_label("prost-derive"),
        ],
        {{ .Common.LibraryArgsForwardingSnippet }}
    )`)

var rustGrpcLibraryRuleTemplate = mustTemplate(rustLibraryRuleTemplateString + `
    # Create {{ .Rule.Base }} library
    rust_library(
        name = name,
        crate_name = kwargs.get("crate_name", name),
        crate_root = name_root,
        edition = kwargs.get("edition", "2021"),
        srcs = [name_fixed],
        deps = [crate_label("prost"), crate_label("prost-types"), crate_label("proto-types")] +
               [crate_label("pbjson"), crate_label("pbjson-types")] +
               [crate_label("serde")] +
               [crate_label("tonic"), crate_label("tonic-prost")] +
               kwargs.get("deps", []) +
               proto_deps,
        proc_macro_deps = kwargs.get("proc_macro_deps", []) + [
            crate_label("prost-derive"),
        ],
        {{ .Common.LibraryArgsForwardingSnippet }}
    )`)

var rustProtoCompileExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "person_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    declared_proto_packages = ["example.proto"],
    options = {
        "@rules_proto_grpc_rust//:rust_proto_plugin": ["type_attribute=.example.proto.Person=#[derive(Eq\\,Hash)]"],
    },
    protos = ["@rules_proto_grpc_example_protos//:person_proto"],
)

{{ .Rule.Name }}(
    name = "place_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    declared_proto_packages = ["example.proto"],
    options = {
        "@rules_proto_grpc_rust//:rust_proto_plugin": ["type_attribute=.example.proto.Place=#[derive(Eq\\,Hash)]"],
    },
    protos = ["@rules_proto_grpc_example_protos//:place_proto"],
)

{{ .Rule.Name }}(
    name = "thing_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    declared_proto_packages = ["example.proto"],
    protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
)`)

var rustGrpcCompileExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}",
    declared_proto_packages = ["example.proto"],
    protos = [
        "@rules_proto_grpc_example_protos//:greeter_grpc",
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
)`)

var rustProtoLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "common_types_{{ .Rule.Base }}_{{ .Rule.Kind }}",
    declared_proto_packages = ["example.common"],
    protos = [
        "@rules_proto_grpc_example_protos//:common_types_proto",
    ],
)

{{ .Rule.Name }}(
    name = "person_place_{{ .Rule.Base }}_{{ .Rule.Kind }}",
    declared_proto_packages = ["example.proto"],
    options = {
        "@rules_proto_grpc_rust//:rust_proto_plugin": [
            "type_attribute=.example.proto.Person=#[derive(Eq\\,Hash)]",
            "type_attribute=.example.proto.Place=#[derive(Eq\\,Hash)]",
        ],
    },
    proto_deps = [
        ":thing_{{ .Rule.Base }}_{{ .Rule.Kind }}",
    ],
    protos = [
        "@rules_proto_grpc_example_protos//:person_proto",
        "@rules_proto_grpc_example_protos//:place_proto",
    ],
)

{{ .Rule.Name }}(
    name = "thing_{{ .Rule.Base }}_{{ .Rule.Kind }}",
    declared_proto_packages = ["example.proto"],
    protos = [
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
)`)

var rustGrpcLibraryExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "rust_proto_library", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "greeter_{{ .Rule.Base }}_{{ .Rule.Kind }}",
    declared_proto_packages = ["example.proto"],
    options = {
        "@rules_proto_grpc_rust//:rust_proto_plugin": [
            "type_attribute=.example.proto.Person=#[derive(Eq\\,Hash)]",
            "type_attribute=.example.proto.Place=#[derive(Eq\\,Hash)]",
        ],
    },
    proto_deps = [
        ":thing_rust_proto",
    ],
    protos = [
        "@rules_proto_grpc_example_protos//:greeter_grpc",
        "@rules_proto_grpc_example_protos//:person_proto",
        "@rules_proto_grpc_example_protos//:place_proto",
    ],
)

rust_proto_library(
    name = "thing_rust_proto",
    declared_proto_packages = ["example.proto"],
    protos = [
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
)`)

var rustCompileRuleAttrs = append(append([]*Attr(nil), compileRuleAttrs...), []*Attr{
	&Attr{
		Name:      "declared_proto_packages",
		Type:      "string_list",
		Doc:       "List of proto packages that this rule generates Rust bindings for",
		Mandatory: true,
	},
	&Attr{
		Name:      "proto_deps",
		Type:      "label_list",
		Default:   "[]",
		Doc:       "Other Rust proto compile targets that this proto directly depends upon",
		Mandatory: false,
		Providers: []string{"RustProtoInfo"},
	},
	&Attr{
		Name:      "crate_name",
		Type:      "string",
		Default:   "None",
		Doc:       "Name of the Rust crate these protos will be compiled into later using ``rust_library``",
		Mandatory: false,
	},
}...)

var rustLibraryRuleAttrs = append(append([]*Attr(nil), rustCompileRuleAttrs...), []*Attr{
	&Attr{
		Name:      "deps",
		Type:      "label_list",
		Default:   "[]",
		Doc:       "List of labels to pass as deps attr to underlying ``rust_library`` rule",
		Mandatory: false,
	},
	&Attr{
		Name:      "edition",
		Type:      "string",
		Default:   "2021",
		Doc:       "Rust edition to pass to underlying ``rust_library`` rule",
		Mandatory: false,
	},
	&Attr{
		Name:      "proc_macro_deps",
		Type:      "label_list",
		Default:   "[]",
		Doc:       "Additional labels to pass as proc_macro_deps attr to underlying ``rust_library`` rule",
		Mandatory: false,
	},
}...)

func makeRust() *Language {
	return &Language{
		Name:              "rust",
		DisplayName:       "Rust",
		Notes:             mustTemplate("Rules for generating Rust protobuf and gRPC ``.rs`` files and libraries. Libraries are created with ``rust_library`` from `rules_rust <https://github.com/bazelbuild/rules_rust>`_. Protobuf well-known ``google.protobuf`` types are mapped to ``pbjson_types`` so generated serde support compiles. Google common ``google.type`` and ``google.rpc`` types are mapped to ``proto_types`` by default.\n\nRust library rules run a small post-merge fixup before calling ``rust_library``. The core rules execute each protoc plugin in an isolated action and then merge the plugin output trees. The Rust plugins emit sibling files such as ``foo.rs``, ``foo.serde.rs``, and ``foo.tonic.rs``; Rust does not compile those siblings unless the base module explicitly includes them. The fixup copies the merged tree and appends the required ``include!`` statements so generated serde and gRPC code is part of the crate."),
		SkipTestPlatforms: []string{"windows"},
		Rules: []*Rule{
			&Rule{
				Name:           "rust_proto_compile",
				Base:           "rust",
				Kind:           "proto",
				Implementation: rustCompileRuleTemplate,
				Plugins:        []string{"//:rust_proto_plugin", "//:rust_crate_plugin", "//:rust_serde_plugin"},
				BuildExample:   rustProtoCompileExampleTemplate,
				Doc:            "Generates Rust protobuf ``.rs`` files",
				Attrs:          rustCompileRuleAttrs,
			},
			&Rule{
				Name:           "rust_grpc_compile",
				Base:           "rust",
				Kind:           "grpc",
				Implementation: rustCompileRuleTemplate,
				Plugins:        []string{"//:rust_proto_plugin", "//:rust_crate_plugin", "//:rust_serde_plugin", "//:rust_grpc_plugin"},
				BuildExample:   rustGrpcCompileExampleTemplate,
				Doc:            "Generates Rust protobuf and gRPC ``.rs`` files",
				Attrs:          rustCompileRuleAttrs,
			},
			&Rule{
				Name:           "rust_proto_library",
				Base:           "rust",
				Kind:           "proto",
				Implementation: rustProtoLibraryRuleTemplate,
				BuildExample:   rustProtoLibraryExampleTemplate,
				Doc:            "Generates a Rust protobuf library using ``rust_library`` from ``rules_rust``",
				Attrs:          rustLibraryRuleAttrs,
			},
			&Rule{
				Name:           "rust_grpc_library",
				Base:           "rust",
				Kind:           "grpc",
				Implementation: rustGrpcLibraryRuleTemplate,
				BuildExample:   rustGrpcLibraryExampleTemplate,
				Doc:            "Generates a Rust protobuf and gRPC library using ``rust_library`` from ``rules_rust``",
				Attrs:          rustLibraryRuleAttrs,
			},
		},
	}
}
