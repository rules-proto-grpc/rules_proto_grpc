package main

var docCustomRuleTemplateString = mustTemplate(`load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile",
    "proto_compile_attrs",
    "proto_compile_toolchains",
)

# Create compile rule
def {{ .Rule.Name }}_impl(ctx):  # buildifier: disable=function-docstring
    # Load attrs that we pass as args
    options = ctx.attr.options
    extra_protoc_args = getattr(ctx.attr, "extra_protoc_args", [])
    extra_protoc_files = ctx.files.extra_protoc_files

    # Make mutable
    options = {k: v for (k, v) in options.items()}
    extra_protoc_files = [] + extra_protoc_files

    # Mutate args with template
    options["*"] = [
        ctx.file.template.path,
        ctx.attr.name,
    ]
    extra_protoc_files.append(ctx.file.template)

    # Execute with extracted attrs
    return proto_compile(ctx, options, extra_protoc_args, extra_protoc_files)

{{ .Rule.Name }} = rule(
    implementation = {{ .Rule.Name }}_impl,
    attrs = dict(
        proto_compile_attrs,
        template = attr.label(
            allow_single_file = True,
            doc = "The documentation template file.",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [{{ range .Rule.Plugins }}
                Label("{{ . }}"),{{ end }}
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = proto_compile_toolchains,
)`)

var docCustomExampleTemplate = mustTemplate(`load("@rules_proto_grpc_{{ .Lang.Name }}//:defs.bzl", "{{ .Rule.Name }}")

{{ .Rule.Name }}(
    name = "greeter_{{ .Lang.Name }}_{{ .Rule.Kind }}.txt",
    output_mode = "NO_PREFIX",
    protos = [
        "@rules_proto_grpc_example_protos//:greeter_grpc",
        "@rules_proto_grpc_example_protos//:thing_proto",
    ],
    template = "template.txt",
)`)

var docTemplateRuleAttrs = append(append([]*Attr(nil), compileRuleAttrs...), []*Attr{
	&Attr{
		Name:      "template",
		Type:      "label",
		Default:   "None",
		Doc:       "The documentation template file.",
		Mandatory: true,
	},
}...)

func makeDoc() *Language {
	return &Language{
		Name:  "doc",
		DisplayName: "Documentation",
		Notes: mustTemplate("Rules for generating protobuf Markdown, JSON, HTML or DocBook documentation with `protoc-gen-doc <https://github.com/pseudomuto/protoc-gen-doc>`_"),
		Rules: []*Rule{
			&Rule{
				Name:             "doc_docbook_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:docbook_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates DocBook ``.xml`` documentation file",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "doc_html_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:html_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates ``.html`` documentation file",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "doc_json_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:json_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates ``.json`` documentation file",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "doc_markdown_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:markdown_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Markdown ``.md`` documentation file",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "doc_template_compile",
				Kind:             "proto",
				Implementation:   docCustomRuleTemplateString,
				Plugins:          []string{"//:template_plugin"},
				BuildExample:     docCustomExampleTemplate,
				Doc:              "Generates documentation file using Go template file",
				Attrs:            docTemplateRuleAttrs,
				Experimental:     true,
			},
		},
	}
}
