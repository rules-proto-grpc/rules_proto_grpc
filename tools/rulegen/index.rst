:author: rules_proto_grpc
:description: Bazel rules for building Protobuf and gRPC code and libraries from proto_library targets
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark


Protobuf and gRPC rules for `Bazel <https://bazel.build>`_
==========================================================

`Bazel <https://bazel.build>`_ rules for building `Protobuf <https://developers.google.com/protocol-buffers>`_
and `gRPC <https://grpc.io>`_ code and libraries from
`proto_library <https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library>`_ targets

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


.. _sec_installation:

Installation
------------

Add ``rules_proto_grpc`` to your ``WORKSPACE`` file and then look at the language specific examples linked below:

.. code-block:: python

   load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

   http_archive(
       name = "rules_proto_grpc",
      sha256 = "{{ .Sha256 }}",
       strip_prefix = "rules_proto_grpc-{{ .Ref }}",
       urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/{{ .Ref }}.tar.gz"],
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


.. toctree::
   :caption: General
   :hidden:

   Overview <self>
   example
   developers
   transitivity
   changelog
   GitHub Repo <https://github.com/rules-proto-grpc/rules_proto_grpc>

.. toctree::
   :caption: Rules
   :hidden:

   lang/android
   lang/buf
   lang/c
   lang/cpp
   lang/csharp
   lang/d
   lang/doc
   lang/go
   lang/grpc-gateway
   lang/java
   lang/js
   lang/objc
   lang/php
   lang/python
   lang/ruby
   lang/rust
   lang/scala
   lang/swift
