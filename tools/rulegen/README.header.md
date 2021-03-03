<div align="center">
    <img width="200" height="200" src="https://raw.githubusercontent.com/rules-proto-grpc/rules_proto_grpc/master/internal/resources/logo.svg">
    <h1>Protobuf and gRPC rules for <a href="https://bazel.build">Bazel</a></h1>
</div>

<div align="center">
    <a href="https://bazel.build">Bazel</a> rules for building <a href="https://developers.google.com/protocol-buffers">Protobuf</a> and <a href="https://grpc.io/">gRPC</a> code and libraries from <a href="https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library">proto_library</a> targets<br><br>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/releases"><img src="https://img.shields.io/github/v/tag/rules-proto-grpc/rules_proto_grpc?label=release&sort=semver&color=38a3a5"></a>
    <a href="https://buildkite.com/bazel/rules-proto-grpc-rules-proto-grpc"><img src="https://badge.buildkite.com/a0c88e60f21c85a8bb53a8c73175aebd64f50a0d4bacbdb038.svg?branch=master"></a>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/actions"><img src="https://github.com/rules-proto-grpc/rules_proto_grpc/workflows/CI/badge.svg"></a>
    <a href="https://bazelbuild.slack.com/archives/CKU1D04RM"><img src="https://img.shields.io/badge/bazelbuild-%23proto-38a3a5?logo=slack"></a>
</div>


## Announcements 📣

#### 2021/03/03 - Version 3.1.0

[Version 3.1.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/3.1.0)
with fixes for JavaScript, updated dependencies and new rules for linting and producing documentation from .proto files.
See the release notes linked above for all changes.

#### 2021/02/21 - Version 3.0.0

[Version 3.0.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/3.0.0)
with updated Protobuf and gRPC versions and a number of major improvements. For some languages this may not be a
drop-in replacement and it may be necessary to update your WORKSPACE file due to changes in dependencies; please see
the above linked release notes for details or the language specific rules pages. If you discover any problems with the
new release, please [open a new issue](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/new),
[create a discussion](https://github.com/rules-proto-grpc/rules_proto_grpc/discussions/new) or otherwise check in the
[#proto channel](https://bazelbuild.slack.com/archives/CKU1D04RM) on Bazel Slack.


## Contents

- [Overview](#overview)
- [Installation](#installation)
- [Rules](#rules)
    - [Android](/android/README.md)
    - [Buf](/buf/README.md)
    - [C](/c/README.md)
    - [C++](/cpp/README.md)
    - [C#](/csharp/README.md)
    - [D](/d/README.md)
    - [Documentation](/doc/README.md)
    - [Go](/go/README.md)
    - [grpc-gateway](/grpc-gateway/README.md)
    - [Java](/java/README.md)
    - [JavaScript](/js/README.md)
    - [Objective-C](/objc/README.md)
    - [PHP](/php/README.md)
    - [Python](/python/README.md)
    - [Ruby](/ruby/README.md)
    - [Rust](/rust/README.md)
    - [Scala](/scala/README.md)
    - [Swift](/swift/README.md)
- [Example Usage](#example-usage)
- [Developers](#developers)
    - [Code Layout](#code-layout)
    - [Rule Generation](#rule-generation)
    - [Developing Custom Plugins](#developing-custom-plugins)
- [License](#license)
- [Contributing](#contributing)


## Overview

These rules provide [Protocol Buffers (Protobuf)](https://developers.google.com/protocol-buffers/) and
[gRPC](https://grpc.io/) rules for a range of languages and services.

Each supported language (`{lang}` below) is generally split into four rule flavours:

- `{lang}_proto_compile`: Provides generated files from the Protobuf `protoc` plugin for the language. e.g for C++ this
  provides the generated `*.pb.cc` and `*.pb.h` files.

- `{lang}_proto_library`: Provides a language-specific library from the generated Protobuf `protoc` plugin outputs,
  along with necessary dependencies. e.g for C++ this provides a Bazel native `cpp_library` created  from the generated
  `*.pb.cc` and `*pb.h` files, with the Protobuf library linked. For languages that do not have a 'library' concept,
  this rule may not exist.

- `{lang}_grpc_compile`: Provides generated files from both the Protobuf and gRPC `protoc` plugins for the language.
  e.g for C++ this provides the generated `*.pb.cc`, `*.grpc.pb.cc`, `*.pb.h` and `*.grpc.pb.h` files.

- `{lang}_grpc_library`: Provides a language-specific library from the generated Protobuf and gRPC `protoc` plugins
  outputs, along with necessary dependencies. e.g for C++ this provides a Bazel native `cpp_library` created from the
  generated `*.pb.cc`, `*.grpc.pb.cc`, `*.pb.h` and `*.grpc.pb.h` files, with the Protobuf and gRPC libraries linked.
  For languages that do not have a 'library' concept, this rule may not exist.

Therefore, if you are solely interested in the generated source code files, use the `{lang}_{proto|grpc}_compile`
rules. Otherwise, if you want a ready-to-go library, use the `{lang}_{proto|grpc}_library` rules.


## Installation

Add `rules_proto_grpc` to your `WORKSPACE` file and then look at the language specific examples linked below:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_proto_grpc",
    urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/{{ .Ref }}.tar.gz"],
    sha256 = "{{ .Sha256 }}",
    strip_prefix = "rules_proto_grpc-{{ .Ref }}",
)

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_toolchains", "rules_proto_grpc_repos")
rules_proto_grpc_toolchains()
rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()
```

It is recommended that you use the tagged releases for stable rules. Master is intended to be 'ready-to-use', but may be
unstable at certain periods. To be notified of new releases, you can use GitHub's 'Watch Releases Only' on the
repository.

> **Important**: You will also need to follow instructions in the language-specific `README.md` for additional workspace
> dependencies that may be required.
