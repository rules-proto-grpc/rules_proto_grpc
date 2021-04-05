package main

func makeDoc() *Language {
	return &Language{
		Dir:   "doc",
		Name:  "doc",
		DisplayName: "Documentation",
		Notes: mustTemplate("Rules for generating protobuf Markdown, JSON, HTML or DocBook documentation with `protoc-gen-doc <https://github.com/pseudomuto/protoc-gen-doc>`_"),
		Flags: commonLangFlags,
		Rules: []*Rule{
			&Rule{
				Name:             "doc_docbook_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//doc:docbook_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates DocBook ``.xml`` documentation file",
				Attrs:            compileRuleAttrs,
				Experimental:     true,
			},
			&Rule{
				Name:             "doc_html_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//doc:html_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates ``.html`` documentation file",
				Attrs:            compileRuleAttrs,
				Experimental:     true,
			},
			&Rule{
				Name:             "doc_json_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//doc:json_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates ``.json`` documentation file",
				Attrs:            compileRuleAttrs,
				Experimental:     true,
			},
			&Rule{
				Name:             "doc_markdown_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//doc:markdown_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Markdown ``.md`` documentation file",
				Attrs:            compileRuleAttrs,
				Experimental:     true,
			},
		},
	}
}
