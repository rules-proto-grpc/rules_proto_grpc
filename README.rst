.. image:: internal/resources/logo.svg
   :width: 200
   :height: 200
   :align: center
   :alt: Rules Proto gRPC logo

Protobuf and gRPC rules for `Bazel <https://bazel.build>`_
==========================================================

`Bazel <https://bazel.build>`_ rules for building `Protobuf <https://developers.google.com/protocol-buffers>`_
and `gRPC <https://grpc.io>`_ code and libraries from
`proto_library <https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library>`_ targets

`Docs <https://rules_proto_grpc.aliddell.com>`__ | `GitHub <https://github.com/rules-proto-grpc/rules_proto_grpc>`__

.. image:: https://img.shields.io/github/v/tag/rules-proto-grpc/rules_proto_grpc?label=release&sort=semver&color=38a3a5
   :alt: Latest Release
   :target: https://github.com/rules-proto-grpc/rules_proto_grpc/releases

.. image:: https://badge.buildkite.com/a0c88e60f21c85a8bb53a8c73175aebd64f50a0d4bacbdb038.svg?branch=master
   :alt: Buildkite Status
   :target: https://buildkite.com/bazel/rules-proto-grpc-rules-proto-grpc

.. image:: https://github.com/rules-proto-grpc/rules_proto_grpc/workflows/CI/badge.svg
   :alt: GitHub Actions Status
   :target: https://github.com/rules-proto-grpc/rules_proto_grpc/actions

.. image:: https://img.shields.io/badge/bazelbuild-%23proto-38a3a5?logo=slack
   :alt: Slack Channel
   :target: https://bazelbuild.slack.com/archives/CKU1D04RM


Announcements 📣
----------------

2021/03/03 - Version 3.1.0
**************************

`Version 3.1.0 has been released <https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/3.1.0>`_
with fixes for JavaScript, updated dependencies and new rules for linting and producing documentation from .proto files.
See the release notes linked above for all changes.

2021/02/21 - Version 3.0.0
**************************

`Version 3.0.0 has been released <https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/3.0.0>`_
with updated Protobuf and gRPC versions and a number of major improvements. For some languages this may not be a
drop-in replacement and it may be necessary to update your WORKSPACE file due to changes in dependencies; please see
the above linked release notes for details or the language specific rules pages. If you discover any problems with the
new release, please `open a new issue <https://github.com/rules-proto-grpc/rules_proto_grpc/issues/new>`_,
`create a discussion <https://github.com/rules-proto-grpc/rules_proto_grpc/discussions/new>`_ or otherwise check in the
`#proto channel <https://bazelbuild.slack.com/archives/CKU1D04RM>`_ on Bazel Slack.


Contents
--------

- `Overview`_
- `Installation`_
- `Rules`_
    - `Android <android>`_
    - `Buf <buf>`_
    - `C <c>`_
    - `C++ <cpp>`_
    - `C# <csharp>`_
    - `D <d>`_
    - `Documentation <doc>`_
    - `Go <go>`_
    - `grpc-gateway <grpc-gateway>`_
    - `Java <java>`_
    - `JavaScript <js>`_
    - `Objective-C <objc>`_
    - `PHP <php>`_
    - `Python <python>`_
    - `Ruby <ruby>`_
    - `Rust <rust>`_
    - `Scala <scala>`_
    - `Swift <swift>`_
- `Example Usage`_
- `Developers`_
    - `Code Layout`_
    - `Rule Generation`_
    - `Developing Custom Plugins`_
- `License`_


Overview
--------

These rules provide `Protocol Buffers (Protobuf) <https://developers.google.com/protocol-buffers>`_ and
`gRPC <https://grpc.io>`_ rules for a range of languages and services.

Each supported language (``{lang}`` below) is generally split into four rule flavours:

- ``{lang}_proto_compile``: Provides generated files from the Protobuf `protoc` plugin for the language. e.g for C++ this
  provides the generated ``*.pb.cc`` and ``*.pb.h`` files.

- ``{lang}_proto_library``: Provides a language-specific library from the generated Protobuf ``protoc`` plugin outputs,
  along with necessary dependencies. e.g for C++ this provides a Bazel native ``cpp_library`` created  from the generated
  ``*.pb.cc`` and ``*.pb.h`` files, with the Protobuf library linked. For languages that do not have a 'library' concept,
  this rule may not exist.

- ``{lang}_grpc_compile``: Provides generated files from both the Protobuf and gRPC ``protoc`` plugins for the language.
  e.g for C++ this provides the generated ``*.pb.cc``, ``*.grpc.pb.cc``, ``*.pb.h`` and ``*.grpc.pb.h`` files.

- ``{lang}_grpc_library``: Provides a language-specific library from the generated Protobuf and gRPC ``protoc`` plugins
  outputs, along with necessary dependencies. e.g for C++ this provides a Bazel native ``cpp_library`` created from the
  generated ``*.pb.cc``, ``*.grpc.pb.cc``, ``*.pb.h`` and ``*.grpc.pb.h`` files, with the Protobuf and gRPC libraries linked.
  For languages that do not have a 'library' concept, this rule may not exist.

Therefore, if you are solely interested in the generated source code files, use the ``{lang}_{proto|grpc}_compile``
rules. Otherwise, if you want a ready-to-go library, use the ``{lang}_{proto|grpc}_library`` rules.


Installation
------------

Add ``rules_proto_grpc`` to your ``WORKSPACE`` file and then look at the language specific examples linked below:

.. code-block:: python

   load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

   http_archive(
       name = "rules_proto_grpc",
      sha256 = "fa7a59e0d1527ac69be652407b457ba1cb40700752a3ee6cc2dd25d9cb28bb1a",
       strip_prefix = "rules_proto_grpc-3.1.0",
       urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/3.1.0.tar.gz"],
   )

   load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_toolchains", "rules_proto_grpc_repos")
   rules_proto_grpc_toolchains()
   rules_proto_grpc_repos()

   load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
   rules_proto_dependencies()
   rules_proto_toolchains()

It is recommended that you use the tagged releases for stable rules. Master is intended to be 'ready-to-use', but may be
unstable at certain periods. To be notified of new releases, you can use GitHub's 'Watch Releases Only' on the
repository.

**Note**: You will also need to follow instructions in the language-specific pages for additional workspace
dependencies that may be required.


Rules
=====

.. list-table:: Rules
   :widths: 1 1 2
   :header-rows: 1

   * - Language
     - Rule
     - Description
   * - `Android <android>`_
     - `android_proto_compile <android#android_proto_compile>`_
     - Generates an Android protobuf ``.jar`` file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/android/android_proto_compile>`__)
   * - `Android <android>`_
     - `android_grpc_compile <android#android_grpc_compile>`_
     - Generates Android protobuf and gRPC ``.jar`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/android/android_grpc_compile>`__)
   * - `Android <android>`_
     - `android_proto_library <android#android_proto_library>`_
     - Generates an Android protobuf library using ``android_library`` from ``rules_android`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/android/android_proto_library>`__)
   * - `Android <android>`_
     - `android_grpc_library <android#android_grpc_library>`_
     - Generates Android protobuf and gRPC library using ``android_library`` from ``rules_android`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/android/android_grpc_library>`__)
   * - `Buf <buf>`_
     - `buf_proto_breaking_test <buf#buf_proto_breaking_test>`_
     - Checks .proto files for breaking changes (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/buf/buf_proto_breaking_test>`__)
   * - `Buf <buf>`_
     - `buf_proto_lint_test <buf#buf_proto_lint_test>`_
     - Lints .proto files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/buf/buf_proto_lint_test>`__)
   * - `C <c>`_
     - `c_proto_compile <c#c_proto_compile>`_
     - Generates C protobuf ``.h`` & ``.c`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/c/c_proto_compile>`__)
   * - `C <c>`_
     - `c_proto_library <c#c_proto_library>`_
     - Generates a C protobuf library using ``cc_library``, with dependencies linked (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/c/c_proto_library>`__)
   * - `C++ <cpp>`_
     - `cpp_proto_compile <cpp#cpp_proto_compile>`_
     - Generates C++ protobuf ``.h`` & ``.cc`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/cpp/cpp_proto_compile>`__)
   * - `C++ <cpp>`_
     - `cpp_grpc_compile <cpp#cpp_grpc_compile>`_
     - Generates C++ protobuf and gRPC ``.h`` & ``.cc`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/cpp/cpp_grpc_compile>`__)
   * - `C++ <cpp>`_
     - `cpp_proto_library <cpp#cpp_proto_library>`_
     - Generates a C++ protobuf library using ``cc_library``, with dependencies linked (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/cpp/cpp_proto_library>`__)
   * - `C++ <cpp>`_
     - `cpp_grpc_library <cpp#cpp_grpc_library>`_
     - Generates a C++ protobuf and gRPC library using ``cc_library``, with dependencies linked (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/cpp/cpp_grpc_library>`__)
   * - `C# <csharp>`_
     - `csharp_proto_compile <csharp#csharp_proto_compile>`_
     - Generates C# protobuf ``.cs`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/csharp/csharp_proto_compile>`__)
   * - `C# <csharp>`_
     - `csharp_grpc_compile <csharp#csharp_grpc_compile>`_
     - Generates C# protobuf and gRPC ``.cs`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/csharp/csharp_grpc_compile>`__)
   * - `C# <csharp>`_
     - `csharp_proto_library <csharp#csharp_proto_library>`_
     - Generates a C# protobuf library using ``csharp_library`` from ``rules_dotnet``. Note that the library name must end in ``.dll`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/csharp/csharp_proto_library>`__)
   * - `C# <csharp>`_
     - `csharp_grpc_library <csharp#csharp_grpc_library>`_
     - Generates a C# protobuf and gRPC library using ``csharp_library`` from ``rules_dotnet``. Note that the library name must end in ``.dll`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/csharp/csharp_grpc_library>`__)
   * - `D <d>`_
     - `d_proto_compile <d#d_proto_compile>`_
     - Generates D protobuf ``.d`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/d/d_proto_compile>`__)
   * - `D <d>`_
     - `d_proto_library <d#d_proto_library>`_
     - Generates a D protobuf library using ``d_library`` from ``rules_d`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/d/d_proto_library>`__)
   * - `Documentation <doc>`_
     - `doc_docbook_compile <doc#doc_docbook_compile>`_
     - Generates DocBook ``.xml`` documentation file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/doc/doc_docbook_compile>`__)
   * - `Documentation <doc>`_
     - `doc_html_compile <doc#doc_html_compile>`_
     - Generates ``.html`` documentation file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/doc/doc_html_compile>`__)
   * - `Documentation <doc>`_
     - `doc_json_compile <doc#doc_json_compile>`_
     - Generates ``.json`` documentation file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/doc/doc_json_compile>`__)
   * - `Documentation <doc>`_
     - `doc_markdown_compile <doc#doc_markdown_compile>`_
     - Generates Markdown ``.md`` documentation file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/doc/doc_markdown_compile>`__)
   * - `Go <go>`_
     - `go_proto_compile <go#go_proto_compile>`_
     - Generates Go protobuf ``.go`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/go/go_proto_compile>`__)
   * - `Go <go>`_
     - `go_grpc_compile <go#go_grpc_compile>`_
     - Generates Go protobuf and gRPC ``.go`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/go/go_grpc_compile>`__)
   * - `Go <go>`_
     - `go_proto_library <go#go_proto_library>`_
     - Generates a Go protobuf library using ``go_library`` from ``rules_go`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/go/go_proto_library>`__)
   * - `Go <go>`_
     - `go_grpc_library <go#go_grpc_library>`_
     - Generates a Go protobuf and gRPC library using ``go_library`` from ``rules_go`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/go/go_grpc_library>`__)
   * - `grpc-gateway <grpc-gateway>`_
     - `gateway_grpc_compile <grpc-gateway#gateway_grpc_compile>`_
     - Generates grpc-gateway ``.go`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/grpc-gateway/gateway_grpc_compile>`__)
   * - `grpc-gateway <grpc-gateway>`_
     - `gateway_openapiv2_compile <grpc-gateway#gateway_openapiv2_compile>`_
     - Generates grpc-gateway OpenAPI v2 ``.json`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/grpc-gateway/gateway_openapiv2_compile>`__)
   * - `grpc-gateway <grpc-gateway>`_
     - `gateway_grpc_library <grpc-gateway#gateway_grpc_library>`_
     - Generates grpc-gateway library files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/grpc-gateway/gateway_grpc_library>`__)
   * - `Java <java>`_
     - `java_proto_compile <java#java_proto_compile>`_
     - Generates a Java protobuf srcjar file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/java/java_proto_compile>`__)
   * - `Java <java>`_
     - `java_grpc_compile <java#java_grpc_compile>`_
     - Generates a Java protobuf and gRPC srcjar file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/java/java_grpc_compile>`__)
   * - `Java <java>`_
     - `java_proto_library <java#java_proto_library>`_
     - Generates a Java protobuf library using ``java_library`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/java/java_proto_library>`__)
   * - `Java <java>`_
     - `java_grpc_library <java#java_grpc_library>`_
     - Generates a Java protobuf and gRPC library using ``java_library`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/java/java_grpc_library>`__)
   * - `JavaScript <js>`_
     - `js_proto_compile <js#js_proto_compile>`_
     - Generates JavaScript protobuf ``.js`` and ``.d.ts`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/js/js_proto_compile>`__)
   * - `JavaScript <js>`_
     - `js_grpc_node_compile <js#js_grpc_node_compile>`_
     - Generates JavaScript protobuf and gRPC-node ``.js`` and ``.d.ts`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/js/js_grpc_node_compile>`__)
   * - `JavaScript <js>`_
     - `js_grpc_web_compile <js#js_grpc_web_compile>`_
     - Generates JavaScript protobuf and gRPC-Web ``.js`` and ``.d.ts`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/js/js_grpc_web_compile>`__)
   * - `JavaScript <js>`_
     - `js_proto_library <js#js_proto_library>`_
     - Generates a JavaScript protobuf library using ``js_library`` from ``rules_nodejs`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/js/js_proto_library>`__)
   * - `JavaScript <js>`_
     - `js_grpc_node_library <js#js_grpc_node_library>`_
     - Generates a Node.js protobuf + gRPC-node library using ``js_library`` from ``rules_nodejs`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/js/js_grpc_node_library>`__)
   * - `JavaScript <js>`_
     - `js_grpc_web_library <js#js_grpc_web_library>`_
     - Generates a JavaScript protobuf + gRPC-Web library using ``js_library`` from ``rules_nodejs`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/js/js_grpc_web_library>`__)
   * - `Objective-C <objc>`_
     - `objc_proto_compile <objc#objc_proto_compile>`_
     - Generates Objective-C protobuf ``.m`` & ``.h`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/objc/objc_proto_compile>`__)
   * - `Objective-C <objc>`_
     - `objc_grpc_compile <objc#objc_grpc_compile>`_
     - Generates Objective-C protobuf and gRPC ``.m`` & ``.h`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/objc/objc_grpc_compile>`__)
   * - `Objective-C <objc>`_
     - `objc_proto_library <objc#objc_proto_library>`_
     - Generates an Objective-C protobuf library using ``objc_library`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/objc/objc_proto_library>`__)
   * - `Objective-C <objc>`_
     - `objc_grpc_library <objc#objc_grpc_library>`_
     - Generates an Objective-C protobuf and gRPC library using ``objc_library`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/objc/objc_grpc_library>`__)
   * - `PHP <php>`_
     - `php_proto_compile <php#php_proto_compile>`_
     - Generates PHP protobuf ``.php`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/php/php_proto_compile>`__)
   * - `PHP <php>`_
     - `php_grpc_compile <php#php_grpc_compile>`_
     - Generates PHP protobuf and gRPC ``.php`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/php/php_grpc_compile>`__)
   * - `Python <python>`_
     - `python_proto_compile <python#python_proto_compile>`_
     - Generates Python protobuf ``.py`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/python/python_proto_compile>`__)
   * - `Python <python>`_
     - `python_grpc_compile <python#python_grpc_compile>`_
     - Generates Python protobuf and gRPC ``.py`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/python/python_grpc_compile>`__)
   * - `Python <python>`_
     - `python_grpclib_compile <python#python_grpclib_compile>`_
     - Generates Python protobuf and grpclib ``.py`` files (supports Python 3 only) (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/python/python_grpclib_compile>`__)
   * - `Python <python>`_
     - `python_proto_library <python#python_proto_library>`_
     - Generates a Python protobuf library using ``py_library`` from ``rules_python`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/python/python_proto_library>`__)
   * - `Python <python>`_
     - `python_grpc_library <python#python_grpc_library>`_
     - Generates a Python protobuf and gRPC library using ``py_library`` from ``rules_python`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/python/python_grpc_library>`__)
   * - `Python <python>`_
     - `python_grpclib_library <python#python_grpclib_library>`_
     - Generates a Python protobuf and grpclib library using ``py_library`` from ``rules_python`` (supports Python 3 only) (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/python/python_grpclib_library>`__)
   * - `Ruby <ruby>`_
     - `ruby_proto_compile <ruby#ruby_proto_compile>`_
     - Generates Ruby protobuf ``.rb`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/ruby/ruby_proto_compile>`__)
   * - `Ruby <ruby>`_
     - `ruby_grpc_compile <ruby#ruby_grpc_compile>`_
     - Generates Ruby protobuf and gRPC ``.rb`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/ruby/ruby_grpc_compile>`__)
   * - `Ruby <ruby>`_
     - `ruby_proto_library <ruby#ruby_proto_library>`_
     - Generates a Ruby protobuf library using ``ruby_library`` from ``rules_ruby`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/ruby/ruby_proto_library>`__)
   * - `Ruby <ruby>`_
     - `ruby_grpc_library <ruby#ruby_grpc_library>`_
     - Generates a Ruby protobuf and gRPC library using ``ruby_library`` from ``rules_ruby`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/ruby/ruby_grpc_library>`__)
   * - `Rust <rust>`_
     - `rust_proto_compile <rust#rust_proto_compile>`_
     - Generates Rust protobuf ``.rs`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/rust/rust_proto_compile>`__)
   * - `Rust <rust>`_
     - `rust_grpc_compile <rust#rust_grpc_compile>`_
     - Generates Rust protobuf and gRPC ``.rs`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/rust/rust_grpc_compile>`__)
   * - `Rust <rust>`_
     - `rust_proto_library <rust#rust_proto_library>`_
     - Generates a Rust protobuf library using ``rust_library`` from ``rules_rust`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/rust/rust_proto_library>`__)
   * - `Rust <rust>`_
     - `rust_grpc_library <rust#rust_grpc_library>`_
     - Generates a Rust protobuf and gRPC library using ``rust_library`` from ``rules_rust`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/rust/rust_grpc_library>`__)
   * - `Scala <scala>`_
     - `scala_proto_compile <scala#scala_proto_compile>`_
     - Generates a Scala protobuf ``.jar`` file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/scala/scala_proto_compile>`__)
   * - `Scala <scala>`_
     - `scala_grpc_compile <scala#scala_grpc_compile>`_
     - Generates Scala protobuf and gRPC ``.jar`` file (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/scala/scala_grpc_compile>`__)
   * - `Scala <scala>`_
     - `scala_proto_library <scala#scala_proto_library>`_
     - Generates a Scala protobuf library using ``scala_library`` from ``rules_scala`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/scala/scala_proto_library>`__)
   * - `Scala <scala>`_
     - `scala_grpc_library <scala#scala_grpc_library>`_
     - Generates a Scala protobuf and gRPC library using ``scala_library`` from ``rules_scala`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/scala/scala_grpc_library>`__)
   * - `Swift <swift>`_
     - `swift_proto_compile <swift#swift_proto_compile>`_
     - Generates Swift protobuf ``.swift`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/swift/swift_proto_compile>`__)
   * - `Swift <swift>`_
     - `swift_grpc_compile <swift#swift_grpc_compile>`_
     - Generates Swift protobuf and gRPC ``.swift`` files (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/swift/swift_grpc_compile>`__)
   * - `Swift <swift>`_
     - `swift_proto_library <swift#swift_proto_library>`_
     - Generates a Swift protobuf library using ``swift_library`` from ``rules_swift`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/swift/swift_proto_library>`__)
   * - `Swift <swift>`_
     - `swift_grpc_library <swift#swift_grpc_library>`_
     - Generates a Swift protobuf and gRPC library using ``swift_library`` from ``rules_swift`` (`example <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/swift/swift_grpc_library>`__)

License
-------

This project is derived from `stackb/rules_proto <https://github.com/stackb/rules_proto>`_ under the
`Apache 2.0 <http://www.apache.org/licenses/LICENSE-2.0>`_ license and  this project therefore maintains the terms of that
license
