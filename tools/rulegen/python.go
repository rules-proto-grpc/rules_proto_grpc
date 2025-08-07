package main

var pythonProtoLibraryRuleTemplate = mustTemplate(`load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_python//python:defs.bzl", "py_library")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, generate_pyi = False, **kwargs):
    """
    python_proto_library generates Python code from proto and creates a py_library for them.

    Args:
        name: the name of the target.
        generate_pyi: flag to specify whether .pyi files should be created.
        **kwargs: common Bazel attributes will be passed to both python_proto_compile and py_library;
        python_proto_compile attributes will be passed to python_proto_compile only.
    """

    # Compile protos
    name_pb = name + "_pb"
    python_proto_compile(
        name = name_pb,
        extra_plugins = [Label("//:pyi_plugin")] if generate_pyi else [],
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # For other code to import generated code with prefix_path if it's given
    output_mode = kwargs.get("output_mode", "PREFIXED")
    if output_mode == "PREFIXED":
        imports = [name_pb]
    else:
        imports = ["."]

    # Create {{ .Lang.Name }} library
    py_library(
        name = name,
        srcs = [name_pb],
        deps = PROTO_DEPS + kwargs.get("deps", []),
        data = kwargs.get("data", []),  # See https://github.com/rules-proto-grpc/rules_proto_grpc/issues/257 for use case
        imports = imports,
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

PROTO_DEPS = [
    Label("@protobuf//:protobuf_python"),
]`)

var pythonGrpcLibraryRuleTemplate = mustTemplate(`load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_python//python:defs.bzl", "py_library")
load("//:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def {{ .Rule.Name }}(name, generate_pyi = False, **kwargs):
    """
    python_grpc_library generates Python code from proto and gRPC, and creates a py_library for them.

    Args:
        name: the name of the target.
        generate_pyi: flag to specify whether .pyi files should be created.
        **kwargs: common Bazel attributes will be passed to both python_grpc_compile and py_library;
        python_grpc_compile attributes will be passed to python_grpc_compile only.
    """

    # Compile protos
    name_pb = name + "_pb"
    python_grpc_compile(
        name = name_pb,
        extra_plugins = [Label("//:pyi_plugin")] if generate_pyi else [],
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # For other code to import generated code with prefix_path if it's given
    output_mode = kwargs.get("output_mode", "PREFIXED")
    if output_mode == "PREFIXED":
        imports = [name_pb]
    else:
        imports = ["."]

    # for pb2_grpc.py to import pb2.py
    prefix_path = kwargs.get("prefix_path", None)
    if prefix_path:
        imports.append(imports[0] + "/" + prefix_path)

    # Create {{ .Lang.Name }} library
    py_library(
        name = name,
        srcs = [name_pb],
        deps = GRPC_DEPS + kwargs.get("deps", []),
        data = kwargs.get("data", []),  # See https://github.com/rules-proto-grpc/rules_proto_grpc/issues/257 for use case
        imports = imports,
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPC_DEPS = [
    Label("@grpc//src/python/grpcio/grpc:grpcio"),
    Label("@protobuf//:protobuf_python"),
]`)

var pythonGrpclibLibraryRuleTemplate = mustTemplate(`load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_proto_grpc_python_pip_deps//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_library")
load("//:{{ .Lang.Name }}_grpclib_compile.bzl", "{{ .Lang.Name }}_grpclib_compile")

def {{ .Rule.Name }}(name, generate_pyi = False, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    python_grpclib_compile(
        name = name_pb,
        extra_plugins = [Label("//:pyi_plugin")] if generate_pyi else [],
        {{ .Common.CompileArgsForwardingSnippet }}
    )

    # Create {{ .Lang.Name }} library
    py_library(
        name = name,
        srcs = [name_pb],
        deps = GRPCLIB_DEPS + kwargs.get("deps", []),
        data = kwargs.get("data", []),  # See https://github.com/rules-proto-grpc/rules_proto_grpc/issues/257 for use case
        imports = [name_pb],
        {{ .Common.LibraryArgsForwardingSnippet }}
    )

GRPCLIB_DEPS = [
    Label(requirement("grpclib")),
    Label("@protobuf//:protobuf_python"),
]`)

var pythonModuleSuffixLines = `bazel_dep(name = "rules_python", version = "1.5.1")

python = use_extension("@rules_python//python/extensions:python.bzl", "python")
python.toolchain(python_version = "3.11")`

func makePython() *Language {
	return &Language{
		Name:  "python",
		DisplayName: "Python",
		Notes: mustTemplate("Rules for generating Python protobuf and gRPC ``.py`` files and libraries using standard Protocol Buffers and gRPC or `grpclib <https://github.com/vmagamedov/grpclib>`_. Libraries are created with ``py_library`` from ``rules_python``. To use the fast C++ Protobuf implementation, you can add ``--define=use_fast_cpp_protos=true`` to your build, but this requires you setup the path to your Python headers.\n\n.. note:: If you have proto libraries that produce overlapping import paths, be sure to set ``legacy_create_init=False`` on the top level ``py_binary`` or ``py_test`` to ensure all paths are importable."),
		ModuleSuffixLines: pythonModuleSuffixLines,
		Aliases: map[string]string{
			"py_proto_compile": "python_proto_compile",
			"py_grpc_compile": "python_grpc_compile",
			"py_grpclib_compile": "python_grpclib_compile",
			"py_proto_library": "python_proto_library",
			"py_grpc_library": "python_grpc_library",
			"py_grpclib_library": "python_grpclib_library",
		},
		Rules: []*Rule{
			&Rule{
				Name:             "python_proto_compile",
				Kind:             "proto",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin"},
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Python protobuf ``.py`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "python_grpc_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:grpc_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Python protobuf and gRPC ``.py`` files",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "python_grpclib_compile",
				Kind:             "grpc",
				Implementation:   compileRuleTemplate,
				Plugins:          []string{"//:proto_plugin", "//:grpclib_plugin"},
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Python protobuf and grpclib ``.py`` files (supports Python 3 only)",
				Attrs:            compileRuleAttrs,
			},
			&Rule{
				Name:             "python_proto_library",
				Kind:             "proto",
				Implementation:   pythonProtoLibraryRuleTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a Python protobuf library using ``py_library`` from ``rules_python``",
				Attrs:            libraryRuleAttrs,
			},
			&Rule{
				Name:             "python_grpc_library",
				Kind:             "grpc",
				Implementation:   pythonGrpcLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Python protobuf and gRPC library using ``py_library`` from ``rules_python``",
				Attrs:            libraryRuleAttrs,
			},
			&Rule{
				Name:             "python_grpclib_library",
				Kind:             "grpc",
				Implementation:   pythonGrpclibLibraryRuleTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Python protobuf and grpclib library using ``py_library`` from ``rules_python`` (supports Python 3 only)",
				Attrs:            libraryRuleAttrs,
			},
		},
	}
}
