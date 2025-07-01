<div align="center">
    <img width="200" height="200" src="https://raw.githubusercontent.com/rules-proto-grpc/rules_proto_grpc/master/docs/_static/logo.svg">
    <h1>Protobuf and gRPC rules for <a href="https://bazel.build">Bazel</a></h1>
</div>

<div align="center">
    <a href="https://bazel.build">Bazel</a> rules for building <a href="https://developers.google.com/protocol-buffers">Protobuf</a> and <a href="https://grpc.io/">gRPC</a> code and libraries from <a href="https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library">proto_library</a> targets
    <br><br>
    If you or your company find these rules useful, please consider <a href="https://github.com/sponsors/aaliddell">supporting the building and maintenance of these rules</a> :coffee:
    <br><br>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/releases"><img src="https://img.shields.io/github/v/tag/rules-proto-grpc/rules_proto_grpc?label=release&sort=semver&color=38a3a5"></a>
    <a href="https://buildkite.com/bazel/rules-proto-grpc-rules-proto-grpc"><img src="https://badge.buildkite.com/a0c88e60f21c85a8bb53a8c73175aebd64f50a0d4bacbdb038.svg?branch=master"></a>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/actions"><img src="https://github.com/rules-proto-grpc/rules_proto_grpc/actions/workflows/check-diff.yml/badge.svg"></a>
    <a href="https://bazelbuild.slack.com/archives/CKU1D04RM"><img src="https://img.shields.io/badge/bazelbuild-%23proto-38a3a5?logo=slack"></a>
</div>

> [!IMPORTANT]
> The `master` branch now contains the Bzlmod-only update of the rules released in
> version 5.0.0. If you need to see the WORKSPACE based rules used in version 4.x.x, please see
> the [`legacy` branch](https://github.com/rules-proto-grpc/rules_proto_grpc/tree/legacy)

## Announcements 📣

<details open>
<summary><b>2025/06/19 - Version 5.3.0</b></summary>

[Version 5.3.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/5.3.0),
which adds support for JavaScript.

</details>

<details>
<summary><b>2025/06/06 - Version 5.2.0</b></summary>

[Version 5.2.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/5.2.0),
which adds support for Scala and Swift languages, updates dependency versions and fixes more bugs. Note
that using Swift support requires that you use an unreleased version of `rules_swift_package_manager` at
present.

</details>

<details>
<summary><b>2025/05/16 - Version 5.1.0</b></summary>

[Version 5.1.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/5.1.0),
which updates underlying dependency versions and fixes a few key bugs. Note that C language support
has also been dropped, as the μpb API used was considered unstable and the plugin is no longer
available outside of the `protobuf` workspace.

</details>

<details open>
<summary><b>2024/07/31 - Version 5.0.0</b></summary>

[Version 5.0.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/5.0.0),
which rewrites the rules to support Bzlmod only. Moving to Bzlmod provides a huge improvement in the
stability and maintainability of these rules, as third-party transitive dependency management has
been handed off to Bazel and new versions of gRPC and Protobuf should hopefully be able to be
supported more rapidly.

At present not all languages supported by the 4.x.x
are supported by this release, with support for the remaining languages being tracked
[here](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/299). For these unsupported
languages - or for WORKSPACE repos - it is recommended you continue using the 4.x.x releases.

The way you use these rules is largely unchanged, but unfortunately the paths used for load of the
rules will have changed due to the splitting into language-specific modules. Please see
[the docs](https://rules-proto-grpc.com/en/latest/) for details of how to migrate your usage to
these new rules, in particular the
[release notes](https://rules-proto-grpc.com/en/latest/changelog.html).

</details>


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
| [Java](https://rules-proto-grpc.com/en/latest/lang/java.html) | [java_proto_compile](https://rules-proto-grpc.com/en/latest/lang/java.html#java-proto-compile) | Generates a Java protobuf srcjar file ([example](/examples/java/java_proto_compile)) |
| [Java](https://rules-proto-grpc.com/en/latest/lang/java.html) | [java_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/java.html#java-grpc-compile) | Generates a Java protobuf and gRPC srcjar file ([example](/examples/java/java_grpc_compile)) |
| [Java](https://rules-proto-grpc.com/en/latest/lang/java.html) | [java_proto_library](https://rules-proto-grpc.com/en/latest/lang/java.html#java-proto-library) | Generates a Java protobuf library using ``java_library`` ([example](/examples/java/java_proto_library)) |
| [Java](https://rules-proto-grpc.com/en/latest/lang/java.html) | [java_grpc_library](https://rules-proto-grpc.com/en/latest/lang/java.html#java-grpc-library) | Generates a Java protobuf and gRPC library using ``java_library`` ([example](/examples/java/java_grpc_library)) |
| [JavaScript](https://rules-proto-grpc.com/en/latest/lang/js.html) | [js_proto_compile](https://rules-proto-grpc.com/en/latest/lang/js.html#js-proto-compile) | Generates JavaScript protobuf ``.js`` and ``.d.ts`` files ([example](/examples/js/js_proto_compile)) |
| [JavaScript](https://rules-proto-grpc.com/en/latest/lang/js.html) | [js_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/js.html#js-grpc-compile) | Generates JavaScript protobuf and gRPC-js ``.js`` and ``.d.ts`` files ([example](/examples/js/js_grpc_compile)) |
| [JavaScript](https://rules-proto-grpc.com/en/latest/lang/js.html) | [js_grpc_web_compile](https://rules-proto-grpc.com/en/latest/lang/js.html#js-grpc-web-compile) | Generates JavaScript protobuf and gRPC-Web ``.js`` and ``.d.ts`` files ([example](/examples/js/js_grpc_web_compile)) |
| [JavaScript](https://rules-proto-grpc.com/en/latest/lang/js.html) | [js_proto_library](https://rules-proto-grpc.com/en/latest/lang/js.html#js-proto-library) | Generates a JavaScript protobuf library using ``js_library`` from ``aspect_rules_js`` ([example](/examples/js/js_proto_library)) |
| [JavaScript](https://rules-proto-grpc.com/en/latest/lang/js.html) | [js_grpc_library](https://rules-proto-grpc.com/en/latest/lang/js.html#js-grpc-library) | Generates a Node.js protobuf + gRPC-js library using ``js_library`` from ``aspect_rules_js`` ([example](/examples/js/js_grpc_library)) |
| [JavaScript](https://rules-proto-grpc.com/en/latest/lang/js.html) | [js_grpc_web_library](https://rules-proto-grpc.com/en/latest/lang/js.html#js-grpc-web-library) | Generates a JavaScript protobuf + gRPC-Web library using ``js_library`` from ``aspect_rules_js`` ([example](/examples/js/js_grpc_web_library)) |
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
| [Scala](https://rules-proto-grpc.com/en/latest/lang/scala.html) | [scala_proto_compile](https://rules-proto-grpc.com/en/latest/lang/scala.html#scala-proto-compile) | Generates a Scala protobuf ``.jar`` file ([example](/examples/scala/scala_proto_compile)) |
| [Scala](https://rules-proto-grpc.com/en/latest/lang/scala.html) | [scala_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/scala.html#scala-grpc-compile) | Generates Scala protobuf and gRPC ``.jar`` file ([example](/examples/scala/scala_grpc_compile)) |
| [Scala](https://rules-proto-grpc.com/en/latest/lang/scala.html) | [scala_proto_library](https://rules-proto-grpc.com/en/latest/lang/scala.html#scala-proto-library) | Generates a Scala protobuf library using ``scala_library`` from ``rules_scala`` ([example](/examples/scala/scala_proto_library)) |
| [Scala](https://rules-proto-grpc.com/en/latest/lang/scala.html) | [scala_grpc_library](https://rules-proto-grpc.com/en/latest/lang/scala.html#scala-grpc-library) | Generates a Scala protobuf and gRPC library using ``scala_library`` from ``rules_scala`` ([example](/examples/scala/scala_grpc_library)) |
| [Swift](https://rules-proto-grpc.com/en/latest/lang/swift.html) | [swift_proto_compile](https://rules-proto-grpc.com/en/latest/lang/swift.html#swift-proto-compile) | Generates Swift protobuf ``.swift`` files ([example](/examples/swift/swift_proto_compile)) |
| [Swift](https://rules-proto-grpc.com/en/latest/lang/swift.html) | [swift_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/swift.html#swift-grpc-compile) | Generates Swift protobuf and gRPC ``.swift`` files ([example](/examples/swift/swift_grpc_compile)) |
| [Swift](https://rules-proto-grpc.com/en/latest/lang/swift.html) | [swift_proto_library](https://rules-proto-grpc.com/en/latest/lang/swift.html#swift-proto-library) | Generates a Swift protobuf library using ``swift_library`` from ``rules_swift`` ([example](/examples/swift/swift_proto_library)) |
| [Swift](https://rules-proto-grpc.com/en/latest/lang/swift.html) | [swift_grpc_library](https://rules-proto-grpc.com/en/latest/lang/swift.html#swift-grpc-library) | Generates a Swift protobuf and gRPC library using ``swift_library`` from ``rules_swift`` ([example](/examples/swift/swift_grpc_library)) |

## License

This project is derived from [stackb/rules_proto](https://github.com/stackb/rules_proto) under the
[Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0) license and  this project therefore maintains the terms of that
license