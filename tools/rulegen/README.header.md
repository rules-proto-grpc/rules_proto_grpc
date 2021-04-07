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


## Usage

Full documentation for the current and previous versions [can be found here](https://rules-proto-grpc.aliddell.com)

- [Overview](https://rules-proto-grpc.aliddell.com/en/latest/)
- [Installation](https://rules-proto-grpc.aliddell.com/en/latest/#installation)
- [Example Usage](https://rules-proto-grpc.aliddell.com/en/latest/example.html)
- [Developers](https://rules-proto-grpc.aliddell.com/en/latest/developers.html)
- [Changelog](https://rules-proto-grpc.aliddell.com/en/latest/changelog.html)
