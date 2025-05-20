package main

import (
	"text/template"
)

// Language represents one directory in this repo
type Language struct {
	// Name of the language
	Name string

	// The display name of the language
	DisplayName string

	// List of rules
	Rules []*Rule

	// Additional notes about the language
	Notes *template.Template

	// Languages that this language depend on
	DependsOn []string

	// Extra lines for MODULE.bazel for examples etc
	ModulePrefixLines string
	ModuleSuffixLines string

	// Additional CI-specific env vars in the form "K=V"
	PresubmitEnvVars map[string]string

	// Platforms for which to skip testing this lang
	// The special value 'all' will skip app platforms
	SkipTestPlatforms []string

	// Extra aliases to add to defs.bzl. Stored as alias name -> real name
	Aliases map[string]string

	// Extra loads to add to defs.bzl. Stored as name -> source file name
	ExtraDefs map[string]string
}

type Rule struct {
	// Name of the rule
	Name string

	// Base name of the rule (typically the lang name)
	Base string

	// Kind of the rule (proto|grpc)
	Kind string

	// Description
	Doc string

	// Template for build file
	BuildExample *template.Template

	// Template for bzl file
	Implementation *template.Template

	// List of attributes
	Attrs []*Attr

	// List of plugins
	Plugins []string

	// Not expected to be functional
	Experimental bool

	// Platforms for which to skip testing this rule, overrides language level
	// The special value 'all' will skip app platforms
	SkipTestPlatforms []string

	// If the rule is a test rule
	IsTest bool
}

// Flag captures information about a bazel build flag.
type Flag struct {
	Category    string
	Name        string
	Value       string
	Description string
}

type Attr struct {
	Name      string
	Type      string
	Default   string
	Doc       string
	Mandatory bool
	Providers []string
}

// Templating types
type CommonTemplatingFields struct {
	CompileArgsForwardingSnippet string
	LibraryArgsForwardingSnippet string
}

var commonTemplatingFields = &CommonTemplatingFields{compileArgsForwardingSnippet, libraryArgsForwardingSnippet}

type RuleTemplatingData struct {
	Lang *Language
	Rule *Rule
	Common *CommonTemplatingFields
}
