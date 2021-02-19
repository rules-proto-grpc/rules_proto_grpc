# Changelog

## 3.0.0

This update brings some major improvements to rules_proto_grpc and solves many of the longstanding issues that have been
present. However, in doing so there have been some changes that make a major version increment necessary and may require
updates to your build files. The updates for each language are explained below and should you have any issues, please
open a new [issue](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/new) or
[discussion](https://github.com/rules-proto-grpc/rules_proto_grpc/discussions/new).

The most substantial change is that compilation of .proto files into language specific files is no longer transitive.
This means that only the direct dependencies of a `lang_proto_library` will be present within the generated library,
rather than every transitive proto message. The justification for this is below, but if you're just interested in the
changes, you can skip down to the next heading.

In previous versions of rules_proto_grpc, the compilation aspect would compile and aggregate all dependent .proto files
from any top level target. In hindsight, this was not the correct behaviour and led to many bugs, since you may end up
creating a library that contains compiled proto files from a third party, where you should instead be depending on a
proper library for that third party's protos.

Even in a single repo, this may have meant multiple copies of a single compiled proto file being present in a target, if
it is depended on via multiple routes. For some languages, such as C++, this breaks the 'one definition rule' and
produces compilation failures or runtime bugs. For other languages, such as Python, this just meant unnecessary
duplicate files in the output binaries.

Therefore, in this release of rules_proto_grpc, there is now a recommedned option to bundle only the direct proto
dependencies into  the libraries, without including the compiled transitive proto files. This is done by replacing the
`deps` attr on `lang_{proto|grpc}_{compile|library}` with the `protos` attr. Since this would be a substantial breaking
change to drop at once on a large project, the new behaviour is opt-in in 3.0.0 and the old method continues to work
throughout the 3.x.x release cycle. Rules using the previous deps attr will have a warning written to console to signify
that your library may be bundling more than expect and should switch attr.

As an additional benefit of this change, we can now support passing arbitrary per-target rules to protoc through the new
`options` attr of the rules, which was a much sought after change that was impossible in the aspect based compilation.

### Switching to non-transitive compilation

In short, replace `deps` with `protos` on your targets:

```starlark
# Old
python_grpc_library(
    name = "routeguide",
    deps = ["//example/proto:routeguide_proto"],
)

# New
python_grpc_library(
    name = "routeguide",
    protos = ["//example/proto:routeguide_proto"],
)
```

In applying the above change, you may discover that you were inheriting dependencies transitively and that your builds
now fail. In such cases, you should add a `lang_{proto|grpc}_{compile|library}` target for those proto files and
depend on it explicitly from the relevant top level binaries/libraries.

### General Changes
- Updated protobuf to 3.15.0
- Updated gRPC to 1.35.0
- All rules have new per-target `options` and `extra_protoc_args` attributes to control options to protoc
  [#54](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/54)
  [#68](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/68)
  [#105](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/105)
- Updated `rules_proto` to latest head
- `aspect.bzl` and `plugin.bzl` have merged to a single top level `defs.bzl`

### Android
- **WORKSPACE update needed**: The WORKSPACE imports necessary for Android rules have been updated due to upstream
  changes in `grpc-java`. Please see the examples for the latest WORKSPACE template for the Android rules

### C++
- Non-transitive mode resolves issue where the same proto may be defined more than once
  [#25](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/25)

### Closure
- Closure rules have been removed. In practice these have been superceded by the Javascript rules, but if you are an
  active user of these rules please open a discussion.

### C#
- Updated `rules_dotnet` to latest. Note that the new versions of `rules_dotnet` drop support for .Net Framework and
  Mono
- Updated `Grpc` to 2.35.0

### D
- Updated `rules_d` to latest

### Go
- Updated `rules_go` to 0.25.1
- **WORKSPACE update needed**: It is now necessary to specify `version` to `go_register_toolchains`
- The plugin used for compiling .proto files for Go has switched to the new google.golang.org/protobuf
  [#85](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/85)
- Updated `gazelle` to 0.22.3
- Updated `org_golang_x_net` to v0.0.0-20210129194117-4acb7895a057
- Updated `org_golang_x_text` to 0.3.5
- Well-known types are now depended on by default
- Removed support for GoGo rules

### grpc-gateway
- Updated `grpc-gateway` to 2.2.0
- The `gateway_swagger_compile` rule has been replaced with `gateway_openapiv2_compile`
  [#93](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/93)
- The grpc-gateway rules have move to repo top level, meaning they are no longer under the `github.com/...` prefix. To
  Update your use of these rules find and replace `@rules_proto_grpc//github.com/grpc-ecosystem/grpc-gateway` with
  `@rules_proto_grpc//grpc-gateway`

### gRPC-Web
- The gRPC-Web rules have moved into `//js`
- Text mode generation is now supported [#59](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/59)

### Java
- **WORKSPACE update needed**: The WORKSPACE imports necessary for Java rules have been updated due to upstream
  changes in `grpc-java`. Please see the examples for the latest WORKSPACE template for the Java rules

### NodeJS/JavaScript
- The JavaScript rules have moved from `@rules_proto_grpc//nodejs` to `@rules_proto_grpc//js`, but the old rules are
  still aliased to ease transition
- Updated `rules_nodejs` to 3.1.0
- Updated `@grpc/grpc-js` to 1.2.6
- Added typescript generation to JS rules

### Objective-C
- Added `copt` argument pass-through for Obj-C library rules.

### Python
- Updated `rules_python` to latest
- **WORKSPACE update needed**: `py_repositories` from `rules_python` is no longer required

### Ruby
- The Ruby rules have migrated from `yugui/rules_ruby` to `bazelruby/rules_ruby`
- Changes `rules_proto_grpc_gems` to `rules_proto_grpc_bundle`
- **WORKSPACE update needed**: The above changes requiresupdates to your WORKSPACE, please see the examples for the
  latest WORKSPACE template for the Ruby rules
- **Open issue**: The `grpc` gem may not be loadable in generated Ruby libraries, please see
  [this issue](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/65).

### Rust
- **WORKSPACE update needed**: The upstream repo `io_bazel_rules_rust` has been renamed to `rules_rust`. The
  `rust_workspace` rule is also no longer required
- Updated `rules_rust` to latest
- Updated `grpcio` to 0.7.1
- Updated `protobuf` to 2.20.0

### Scala
- Update `rules_scala` to latest [#108](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/108)
- **WORKSPACE update needed**: The `scala_config` rule from `rules_scala` is now required in your WORKSPACE

### Swift
- Updated `rules_swift` to 0.18.0
- Updated `grpc-swift` to 1.0.0
- Visibility of generated types is now configurable with `options`
  [#111](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/111)

### Thanks
Thanks to everyone who has contributed issues and patches for this release.

---

## 2.0.0

### General
- Updated `protobuf` to 3.13.0
- Updated `grpc` to 1.32.0
- **WORKSPACE update needed**: These rules now depend on `rules_proto`, which must be added to your WORKSPACE file
- Dropped support for the deprecated `transitivity` attribute on `proto_plugin`. The `exclusions` attribute is the supported way of achieving this
- The `output_dirs` attribute of `ProtoCompileInfo` is now a depset, meaning directories will be deduplicated
- Removed the `deps.bzl` files that have been deprecated since version 1.0.0
- Tags are now propagated correctly on library rules

### Android
- **WORKSPACE update needed**: The Guava dependency is no longer needed

### C#
- Updated `rules_dotnet` to latest master
- Updated `Google.Protobuf` to 3.13.0
- Updated `Grpc` to 2.32.0
- **WORKSPACE update needed**: There have been substantial changes to the required WORKSPACE rules for C#. Please see the C# language page

### Closure
- Updated `rules_closure` to 0.11.0

### D
- Updated `rules_d` to latest master
- Updated `protobuf-d` to 0.6.2

### grpc-gateway
- Updated `grpc-gateway` to 1.15.0

### gRPC Web
- Updated gRPC Web to 1.2.1

### Go
- Updated `rules_go` to 0.24.3
- Updated `bazel-gazelle` to 0.21.1
- Updated `org_golang_x_net` to v0.0.0-20200930145003-4acb6c075d10
- Updated `org_golang_x_text` to 0.3.3

### Java
- **WORKSPACE update needed**: The Guava dependency is no longer needed

### NodeJS
- Updated `rules_nodejs` to 2.2.0
- **WORKSPACE update needed**: The `defs.bzl` file in `rules_nodejs` has moved to `index.bzl`
- **WORKSPACE update needed**: Running `yarn_install()` is needed in more cases
- **WORKSPACE update needed**: Running `grpc_deps()` is no longer necessary for just the NodeJS rules
- Moved from `grpc` to `@grpc/grpc-js` package
- Library rules have been enabled and now return `js_library` rather than `npm_package`

### Python
- Dropped Python 2 support
- Updated `rules_python` to latest master
- Updated `grpclib` to 0.4.1
- Moved to using `grpcio` library directly from the local `grpc` repository.
- Pinned dependency versions in requirements.txt using pip-compile
- **WORKSPACE update needed**: The method for loading Pip dependencies has changed. Please see the Python language page.
- **WORKSPACE update needed**: Using the Pip dependencies is now only necessary if you are using the `grpclib` rules

### Rust:
- Updated `rules_rust` to latest master
- Updated `protobuf` crate to 2.17.0
- Updated `grpcio` crate to 0.6.0
- **WORKSPACE update needed**: The setup for `rules_rust` has changed in the newer version. Please see the Rust language page.
- **WORKSPACE update needed**: The `grpc_deps()` rule is now needed for Rust

### Scala:
- Updated `rules_scala` to latest master
- `ScalaPB` is now pulled from `rules_scala`, which uses 0.9.7
- **WORKSPACE update needed**: The `scala_proto_repositories()` rule is now needed

### Swift:
- Updated `rules_swift` to 0.15.0
- Updated `grpc-swift` to 0.11.0
- Moved the Swift library rules to be internal to this repo

---

## 1.0.2

### Android / Closure / Java / Scala

- Fixed loading of `com_google_errorprone_error_prone_annotations`
- Replaced Maven HTTP URLs with HTTPS URLs
- Updated grpc-java, rules_closure and rules_scala to include Maven HTTPS fix

---

## 1.0.1

### General

- Fix support for plugins that use `output_directory` and produce no output files: #39 
- Misc typo fixes and tidying

---

## 1.0.0

### General

- Bazel 1.0+ is now supported
- The `rules_proto_grpc_repos()` WORKSPACE rule has been added and is recommended to be used
- Protobuf has been updated to 3.11.0
- gRPC has been updated to 1.25.0
- All other dependencies have been updated where available
- The Bazel version is now checked for compatibility
- Added more test workspaces
- Removed tests that use `proto_source_root`
- Added fix for duplicate proto files when using `import_prefix`

### Closure

- The required WORKSPACE rules has been updated for all Closure-based rules, please check the documentation for the current recommended set

### Go / GoGo / grpc-gateway

- The required WORKSPACE rules has been updated for all Go-based rules, please check the documentation for the current recommended set

### gRPC.js

- Support for gRPC.js has been removed

### Python

- The way dependencies are pulled in has changed from using `rules_pip` to the standard `rules_python`. Please check the documentation for the new WORKSPACE rules required and remove the old ones

### Scala

- Scala gRPC rules are currently not working fully. Due to delays in publishing support for Bazel 1.0, this support has been pushed back to 1.1.0
- The required WORKSPACE rules has been updated for all Scala rules, please check the documentation for the current recommended set

---

## 0.2.0

### General
- Tests generated by the routeguide test matrix now correctly us the client/server executables

### Ruby
- Well-known proto files are excluded from generation in the Ruby plugins
- The naming of the Ruby gems workspace has changed to remove the 'routeguide' prefix
- Ruby client/server is now included in the non-manual test matrix

---

# 0.1.0

Initial release of `rules_proto_grpc`. For changes from predecessor `rules_proto`, please see [MIGRATION.md](https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/docs/MIGRATION.md)
