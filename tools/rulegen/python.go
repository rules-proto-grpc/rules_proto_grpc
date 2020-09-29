package main

var pythonGrpcLibraryWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos="{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@rules_python//python:repositories.bzl", "py_repositories")
py_repositories()

load("@rules_python//python:pip.bzl", "pip_repositories")
pip_repositories()

load("@rules_python//python:pip.bzl", "pip_import")
pip_import(
    name = "rules_proto_grpc_py2_deps",
    python_interpreter = "python", # Replace this with the platform specific Python 2 name, or remove if not using Python 2
    requirements = "@rules_proto_grpc//python:requirements.txt",
)

load("@rules_proto_grpc_py2_deps//:requirements.bzl", pip2_install="pip_install")
pip2_install()

pip_import(
    name = "rules_proto_grpc_py3_deps",
    python_interpreter = "python3",
    requirements = "@rules_proto_grpc//python:requirements.txt",
)

load("@rules_proto_grpc_py3_deps//:requirements.bzl", pip3_install="pip_install")
pip3_install()`)

var pythonProtoLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def python_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    python_proto_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create {{ .Lang.Name }} library
    native.py_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS,
        imports = [name_pb],
        visibility = kwargs.get("visibility"),
    )

PROTO_DEPS = [
    "@com_google_protobuf//:protobuf_python",
]`)

var pythonGrpcLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")

def python_grpc_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    python_grpc_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create {{ .Lang.Name }} library
    native.py_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = [
            "@com_google_protobuf//:protobuf_python",
            "@com_github_grpc_grpc//src/python/grpcio/grpc:grpcio",
        ],
        imports = [name_pb],
        visibility = kwargs.get("visibility"),
    )
`)

var pythonGrpclibLibraryRuleTemplate = mustTemplate(`load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_grpclib_compile.bzl", "{{ .Lang.Name }}_grpclib_compile")

def python_grpclib_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    python_grpclib_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create {{ .Lang.Name }} library
    native.py_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = [
            "@com_google_protobuf//:protobuf_python",
        ] + GRPC_DEPS,
        imports = [name_pb],
        visibility = kwargs.get("visibility"),
    )

GRPC_DEPS = [
    "@rules_proto_grpc_py3_deps_pypi__hpack_4_0_0//:pkg",
    "@rules_proto_grpc_py3_deps_pypi__hyperframe_6_0_0//:pkg",
    "@rules_proto_grpc_py3_deps_pypi__grpclib_0_4_1//:pkg",
]`)

func makePython() *Language {
	return &Language{
		Dir:   "python",
		Name:  "python",
		DisplayName: "Python",
		Notes: mustTemplate("Rules for generating Python protobuf and gRPC `.py` files and libraries using standard Protocol Buffers and gRPC or [grpclib](https://github.com/vmagamedov/grpclib). Libraries are created with the Bazel native `py_library`"),
		Flags: commonLangFlags,
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
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//python:python_plugin"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Python protobuf `.py` artifacts",
				Attrs:            aspectProtoCompileAttrs,
			},
			&Rule{
				Name:             "python_grpc_compile",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//python:python_plugin", "//python:grpc_python_plugin"},
				WorkspaceExample: grpcWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Python protobuf+gRPC `.py` artifacts",
				Attrs:            aspectProtoCompileAttrs,
			},
			&Rule{
				Name:             "python_grpclib_compile",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//python:python_plugin", "//python:grpclib_python_plugin"},
				WorkspaceExample: pythonGrpcLibraryWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Python protobuf+grpclib `.py` artifacts (supports Python 3 only)",
				Attrs:            aspectProtoCompileAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
			&Rule{
				Name:             "python_proto_library",
				Kind:             "proto",
				Implementation:   pythonProtoLibraryRuleTemplate,
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoLibraryExampleTemplate,
				Doc:              "Generates a Python protobuf library using `py_library`",
				Attrs:            aspectProtoCompileAttrs,
			},
			&Rule{
				Name:             "python_grpc_library",
				Kind:             "grpc",
				Implementation:   pythonGrpcLibraryRuleTemplate,
				WorkspaceExample: pythonGrpcLibraryWorkspaceTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Python protobuf+gRPC library using `py_library`",
				Attrs:            aspectProtoCompileAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
			&Rule{
				Name:             "python_grpclib_library",
				Kind:             "grpc",
				Implementation:   pythonGrpclibLibraryRuleTemplate,
				WorkspaceExample: pythonGrpcLibraryWorkspaceTemplate,
				BuildExample:     grpcLibraryExampleTemplate,
				Doc:              "Generates a Python protobuf+grpclib library using `py_library` (supports Python 3 only)",
				Attrs:            aspectProtoCompileAttrs,
				SkipTestPlatforms: []string{"windows"},
			},
		},
	}
}
