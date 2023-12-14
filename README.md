<div align="center">
    <img width="200" height="200" src="https://raw.githubusercontent.com/rules-proto-grpc/rules_proto_grpc/master/docs/_static/logo.svg">
    <h1>Protobuf and gRPC rules for <a href="https://bazel.build">Bazel</a></h1>
</div>

<div align="center">
    <a href="https://bazel.build">Bazel</a> rules for building <a href="https://developers.google.com/protocol-buffers">Protobuf</a> and <a href="https://grpc.io/">gRPC</a> code and libraries from <a href="https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library">proto_library</a> targets<br><br>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/releases"><img src="https://img.shields.io/github/v/tag/rules-proto-grpc/rules_proto_grpc?label=release&sort=semver&color=38a3a5"></a>
    <a href="https://buildkite.com/bazel/rules-proto-grpc-rules-proto-grpc"><img src="https://badge.buildkite.com/a0c88e60f21c85a8bb53a8c73175aebd64f50a0d4bacbdb038.svg?branch=master"></a>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/actions"><img src="https://github.com/rules-proto-grpc/rules_proto_grpc/workflows/CI/badge.svg"></a>
    <a href="https://bazelbuild.slack.com/archives/CKU1D04RM"><img src="https://img.shields.io/badge/bazelbuild-%23proto-38a3a5?logo=slack"></a>
</div>

> [!IMPORTANT]
> You are looking at the `next` branch, which contains highly experimental bzlmod support. It is not
> recommended that you use this version of these rules at present

## Announcements 📣

#### 2023/12/14 - Version 4.6.0

[Version 4.6.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/4.6.0),
which contains a few bug fixes for Bazel 7 support. **Note that this is likely to be the last
WORKSPACE supporting release of rules_proto_grpc**, as new bzlmod supporting rules are introduced
in the next major release

#### 2023/09/12 - Version 4.5.0

[Version 4.5.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/4.5.0),
which contains a number of version updates, bug fixes and usability improvements over 4.4.0.
Additionally, the Rust rules contain a major change of underlying gRPC and Protobuf library; the
rules now use Tonic and Prost respectively


## Usage

Full documentation for the current and previous versions [can be found here](https://rules-proto-grpc.com)

- [Overview](https://rules-proto-grpc.com/en/latest/)
- [Installation](https://rules-proto-grpc.com/en/latest/#installation)
- [Example Usage](https://rules-proto-grpc.com/en/latest/example.html)
- [Custom Plugins](https://rules-proto-grpc.com/en/latest/custom_plugins.html)
- [Changelog](https://rules-proto-grpc.com/en/latest/changelog.html)


## Rules

| Language | Rule | Description
| ---: | :--- | :--- |
| [Buf](https://rules-proto-grpc.com/en/latest/lang/buf.html) | [buf_proto_breaking_test](https://rules-proto-grpc.com/en/latest/lang/buf.html#buf-proto-breaking-test) | Checks .proto files for breaking changes ([example](/examples/buf/buf_proto_breaking_test)) |
| [Buf](https://rules-proto-grpc.com/en/latest/lang/buf.html) | [buf_proto_lint_test](https://rules-proto-grpc.com/en/latest/lang/buf.html#buf-proto-lint-test) | Lints .proto files ([example](/examples/buf/buf_proto_lint_test)) |
| [C](https://rules-proto-grpc.com/en/latest/lang/c.html) | [c_proto_compile](https://rules-proto-grpc.com/en/latest/lang/c.html#c-proto-compile) | Generates C protobuf ``.h`` & ``.c`` files ([example](/examples/c/c_proto_compile)) |
| [C](https://rules-proto-grpc.com/en/latest/lang/c.html) | [c_proto_library](https://rules-proto-grpc.com/en/latest/lang/c.html#c-proto-library) | Generates a C protobuf library using ``cc_library``, with dependencies linked ([example](/examples/c/c_proto_library)) |
| [C++](https://rules-proto-grpc.com/en/latest/lang/cpp.html) | [cpp_proto_compile](https://rules-proto-grpc.com/en/latest/lang/cpp.html#cpp-proto-compile) | Generates C++ protobuf ``.h`` & ``.cc`` files ([example](/examples/cpp/cpp_proto_compile)) |
| [C++](https://rules-proto-grpc.com/en/latest/lang/cpp.html) | [cpp_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/cpp.html#cpp-grpc-compile) | Generates C++ protobuf and gRPC ``.h`` & ``.cc`` files ([example](/examples/cpp/cpp_grpc_compile)) |
| [C++](https://rules-proto-grpc.com/en/latest/lang/cpp.html) | [cpp_proto_library](https://rules-proto-grpc.com/en/latest/lang/cpp.html#cpp-proto-library) | Generates a C++ protobuf library using ``cc_library``, with dependencies linked ([example](/examples/cpp/cpp_proto_library)) |
| [C++](https://rules-proto-grpc.com/en/latest/lang/cpp.html) | [cpp_grpc_library](https://rules-proto-grpc.com/en/latest/lang/cpp.html#cpp-grpc-library) | Generates a C++ protobuf and gRPC library using ``cc_library``, with dependencies linked ([example](/examples/cpp/cpp_grpc_library)) |
| [Documentation](https://rules-proto-grpc.com/en/latest/lang/doc.html) | [doc_docbook_compile](https://rules-proto-grpc.com/en/latest/lang/doc.html#doc-docbook-compile) | Generates DocBook ``.xml`` documentation file ([example](/examples/doc/doc_docbook_compile)) |
| [Documentation](https://rules-proto-grpc.com/en/latest/lang/doc.html) | [doc_html_compile](https://rules-proto-grpc.com/en/latest/lang/doc.html#doc-html-compile) | Generates ``.html`` documentation file ([example](/examples/doc/doc_html_compile)) |
| [Documentation](https://rules-proto-grpc.com/en/latest/lang/doc.html) | [doc_json_compile](https://rules-proto-grpc.com/en/latest/lang/doc.html#doc-json-compile) | Generates ``.json`` documentation file ([example](/examples/doc/doc_json_compile)) |
| [Documentation](https://rules-proto-grpc.com/en/latest/lang/doc.html) | [doc_markdown_compile](https://rules-proto-grpc.com/en/latest/lang/doc.html#doc-markdown-compile) | Generates Markdown ``.md`` documentation file ([example](/examples/doc/doc_markdown_compile)) |
| [Documentation](https://rules-proto-grpc.com/en/latest/lang/doc.html) | [doc_template_compile](https://rules-proto-grpc.com/en/latest/lang/doc.html#doc-template-compile) | Generates documentation file using Go template file ([example](/examples/doc/doc_template_compile)) |
| [Go](https://rules-proto-grpc.com/en/latest/lang/go.html) | [go_proto_compile](https://rules-proto-grpc.com/en/latest/lang/go.html#go-proto-compile) | Generates Go protobuf ``.go`` files ([example](/examples/go/go_proto_compile)) |
| [Go](https://rules-proto-grpc.com/en/latest/lang/go.html) | [go_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/go.html#go-grpc-compile) | Generates Go protobuf and gRPC ``.go`` files ([example](/examples/go/go_grpc_compile)) |
| [Go](https://rules-proto-grpc.com/en/latest/lang/go.html) | [go_proto_library](https://rules-proto-grpc.com/en/latest/lang/go.html#go-proto-library) | Generates a Go protobuf library using ``go_library`` from ``rules_go`` ([example](/examples/go/go_proto_library)) |
| [Go](https://rules-proto-grpc.com/en/latest/lang/go.html) | [go_grpc_library](https://rules-proto-grpc.com/en/latest/lang/go.html#go-grpc-library) | Generates a Go protobuf and gRPC library using ``go_library`` from ``rules_go`` ([example](/examples/go/go_grpc_library)) |
| [gRPC-Gateway](https://rules-proto-grpc.com/en/latest/lang/grpc_gateway.html) | [gateway_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/grpc_gateway.html#gateway-grpc-compile) | Generates gRPC-Gateway ``.go`` files ([example](/examples/grpc_gateway/gateway_grpc_compile)) |
| [gRPC-Gateway](https://rules-proto-grpc.com/en/latest/lang/grpc_gateway.html) | [gateway_openapiv2_compile](https://rules-proto-grpc.com/en/latest/lang/grpc_gateway.html#gateway-openapiv2-compile) | Generates gRPC-Gateway OpenAPI v2 ``.json`` files ([example](/examples/grpc_gateway/gateway_openapiv2_compile)) |
| [gRPC-Gateway](https://rules-proto-grpc.com/en/latest/lang/grpc_gateway.html) | [gateway_grpc_library](https://rules-proto-grpc.com/en/latest/lang/grpc_gateway.html#gateway-grpc-library) | Generates gRPC-Gateway library files ([example](/examples/grpc_gateway/gateway_grpc_library)) |
| [Objective-C](https://rules-proto-grpc.com/en/latest/lang/objc.html) | [objc_proto_compile](https://rules-proto-grpc.com/en/latest/lang/objc.html#objc-proto-compile) | Generates Objective-C protobuf ``.m`` & ``.h`` files ([example](/examples/objc/objc_proto_compile)) |
| [Objective-C](https://rules-proto-grpc.com/en/latest/lang/objc.html) | [objc_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/objc.html#objc-grpc-compile) | Generates Objective-C protobuf and gRPC ``.m`` & ``.h`` files ([example](/examples/objc/objc_grpc_compile)) |
| [Objective-C](https://rules-proto-grpc.com/en/latest/lang/objc.html) | [objc_proto_library](https://rules-proto-grpc.com/en/latest/lang/objc.html#objc-proto-library) | Generates an Objective-C protobuf library using ``objc_library`` ([example](/examples/objc/objc_proto_library)) |
| [Objective-C](https://rules-proto-grpc.com/en/latest/lang/objc.html) | [objc_grpc_library](https://rules-proto-grpc.com/en/latest/lang/objc.html#objc-grpc-library) | Generates an Objective-C protobuf and gRPC library using ``objc_library`` ([example](/examples/objc/objc_grpc_library)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_proto_compile](https://rules-proto-grpc.com/en/latest/lang/python.html#python-proto-compile) | Generates Python protobuf ``.py`` files ([example](/examples/python/python_proto_compile)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/python.html#python-grpc-compile) | Generates Python protobuf and gRPC ``.py`` files ([example](/examples/python/python_grpc_compile)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_grpclib_compile](https://rules-proto-grpc.com/en/latest/lang/python.html#python-grpclib-compile) | Generates Python protobuf and grpclib ``.py`` files (supports Python 3 only) ([example](/examples/python/python_grpclib_compile)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_proto_library](https://rules-proto-grpc.com/en/latest/lang/python.html#python-proto-library) | Generates a Python protobuf library using ``py_library`` from ``rules_python`` ([example](/examples/python/python_proto_library)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_grpc_library](https://rules-proto-grpc.com/en/latest/lang/python.html#python-grpc-library) | Generates a Python protobuf and gRPC library using ``py_library`` from ``rules_python`` ([example](/examples/python/python_grpc_library)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_grpclib_library](https://rules-proto-grpc.com/en/latest/lang/python.html#python-grpclib-library) | Generates a Python protobuf and grpclib library using ``py_library`` from ``rules_python`` (supports Python 3 only) ([example](/examples/python/python_grpclib_library)) |

## License

This project is derived from [stackb/rules_proto](https://github.com/stackb/rules_proto) under the
[Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0) license and  this project therefore maintains the terms of that
license