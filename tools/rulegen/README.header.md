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
<summary><b>2025/07/17 - Version 5.4.0</b></summary>

[Version 5.4.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/5.4.0),
which resolves classpath issues for Java/Scala and updates dependencies.

</details>

<details>
<summary><b>2025/07/02 - Version 5.3.1</b></summary>

[Version 5.3.1 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/5.3.1),
which fixes a bug with grpc-web on arm64 platforms and updates dependencies.

</details>

<details>
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
