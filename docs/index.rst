:author: rules_proto_grpc
:description: Bazel rules for building Protobuf and gRPC code and libraries from proto_library targets
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark


Protobuf and gRPC rules for `Bazel <https://bazel.build>`_
==========================================================

`Bazel <https://bazel.build>`_ rules for building
`Protobuf <https://developers.google.com/protocol-buffers>`_ and `gRPC <https://grpc.io>`_ code and
libraries from
`proto_library <https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library>`_
targets.

If you or your company find these rules useful, please consider `supporting the time spent
building and maintaining these rules <https://github.com/sponsors/aaliddell>`_ ☕

.. image:: https://img.shields.io/github/v/tag/rules-proto-grpc/rules_proto_grpc?label=release&sort=semver&color=38a3a5
   :alt: Latest Release
   :target: https://github.com/rules-proto-grpc/rules_proto_grpc/releases

.. image:: https://badge.buildkite.com/a0c88e60f21c85a8bb53a8c73175aebd64f50a0d4bacbdb038.svg?branch=master
   :alt: Buildkite Status
   :target: https://buildkite.com/bazel/rules-proto-grpc-rules-proto-grpc

.. image:: https://img.shields.io/badge/bazelbuild-%23proto-38a3a5?logo=slack
   :alt: Slack Channel
   :target: https://bazelbuild.slack.com/archives/CKU1D04RM


Overview
--------

These rules provide a consistent set of
`Protocol Buffers (Protobuf) <https://developers.google.com/protocol-buffers>`_ and
`gRPC <https://grpc.io>`_ Bazel rules for a wide range of supported languages, services and
tools. This aims to encompass all aspects of working with ``.proto`` files, such as:

- Generation of language specific source files with protoc
- Creation of libraries from protoc source file outputs
- Linting and checking for breaking changes with `Buf <https://buf.build>`__
- Producing documentation from your Protobuf definitions with
  `protoc-gen-doc <https://github.com/pseudomuto/protoc-gen-doc>`__

Each supported language (shown as ``{lang}`` below) is generally split into four rule types:

- ``{lang}_proto_compile``: Provides generated files from the Protobuf `protoc` plugin for the
  language. For example, for C++ this provides the generated ``*.pb.cc`` and ``*.pb.h`` files.

- ``{lang}_proto_library``: Provides a language-specific library from the generated Protobuf
  ``protoc`` plugin outputs, along with necessary dependencies. For example, for C++ this provides a
  Bazel native ``cpp_library`` created  from the generated ``*.pb.cc`` and ``*.pb.h`` files, with
  the Protobuf library linked.

- ``{lang}_grpc_compile``: Provides generated files from both the Protobuf and gRPC ``protoc``
  plugins for the language. For example, for C++ this provides the generated ``*.pb.cc``,
  ``*.grpc.pb.cc``, ``*.pb.h`` and ``*.grpc.pb.h`` files.

- ``{lang}_grpc_library``: Provides a language-specific library from the generated Protobuf and gRPC
  ``protoc`` plugins outputs, along with necessary dependencies. For example, for C++ this provides
  a Bazel native ``cpp_library`` created from the generated ``*.pb.cc``, ``*.grpc.pb.cc``,
  ``*.pb.h`` and ``*.grpc.pb.h`` files, with the Protobuf and gRPC libraries linked.

Some languages may have variations on these rules, such as when there are multiple gRPC or Protobuf
implementations. However, generally you'll want to use the ``{lang}_{proto|grpc}_library`` rules,
since these bundle up all the outputs into a library that can easily be used elsewhere in your Bazel
workspace. Alternatively, if you just want the generated source code files, you can use the
``{lang}_{proto|grpc}_compile`` rules instead.

If you just need compilation of ``.proto`` files for a single language, you may
find your language specific Bazel rules have their own Protobuf or gRPC rules, which may be
preferrable in a single-language repo.


.. _sec_installation:

Installation
------------

Support for each language is provided by a separate module, which should be added to your
``MODULE.bazel`` file. Details for each language's module installation and usage are provided in the
language specific documentation pages. For example, for Go support, you would add the following line:

.. code-block:: python

   bazel_dep(name = "rules_proto_grpc_go", version = "<version number here>")


Supported Languages and Tools
-----------------------------

.. list-table:: Supported Languages
   :header-rows: 1

   * - Language
     - Protobuf
     - gRPC
   * - C
     - ✔
     - ✖
   * - C++
     - ✔
     - ✔
   * - Go
     - ✔
     - ✔
   * - Java
     - ✔
     - ✔
   * - JavaScript
     - ✔
     - ✔
   * - Objective-C
     - ✔
     - ✔
   * - Python
     - ✔
     - ✔
   * - Scala
     - ✔
     - ✔
   * - Swift
     - ✔
     - ✔

.. list-table:: Supported Tools
   :widths: 20 5 50

   * - Buf Linting
     - ✔
     - Checks ``.proto`` files for common errors and adherance to style guidelines
   * - Buf Breaking Change Detection
     - ✔
     - Checks ``.proto`` files for changes to messages that would break existing clients
   * - grpc-gateway
     - ✔
     - Produces source files for creating gRPC to JSON proxies
   * - protoc-gen-doc
     - ✔
     - Creates Markdown, JSON, HTML or DocBook documentation files from your ``.proto`` files


.. toctree::
   :caption: General
   :hidden:

   Overview <self>
   example
   custom_plugins
   contributing
   changelog


.. toctree::
   :caption: External
   :hidden:

   GitHub Repo <https://github.com/rules-proto-grpc/rules_proto_grpc>
   Slack <https://bazelbuild.slack.com/archives/CKU1D04RM>


.. toctree::
   :caption: Rules
   :hidden:

   lang/buf
   lang/c
   lang/cpp
   lang/doc
   lang/go
   lang/grpc_gateway
   lang/java
   lang/js
   lang/objc
   lang/python
   lang/scala
   lang/swift
