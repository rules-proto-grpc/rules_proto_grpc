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
    - `Android </android>`_
    - `Buf </buf>`_
    - `C </c>`_
    - `C++ </cpp>`_
    - `C# </csharp>`_
    - `D </d>`_
    - `Documentation </doc>`_
    - `Go </go>`_
    - `grpc-gateway </grpc-gateway>`_
    - `Java </java>`_
    - `JavaScript </js>`_
    - `Objective-C </objc>`_
    - `PHP </php>`_
    - `Python </python>`_
    - `Ruby </ruby>`_
    - `Rust </rust>`_
    - `Scala </scala>`_
    - `Swift </swift>`_
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

.. code-block:: starlark

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
