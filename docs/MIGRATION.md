# Migration

For users migrating from the [stackb/rules_proto](https://github.com/stackb/rules_proto)
rules, please see the following sections for general and language-specific
changes that you may need to make to adopt these rules. If you are just an
end-user of the rules, it is mostly minor changes to how the rules are loaded,
for which the language-specific rules pages will get you up to speed. 

If you need help migrating an existing rule-set, please open an Issue and we'll
help where possible.


## General

- All languages are now compiled by the aspect-based compilation described in
  [How-it-works](/README.md#how-it-works). Due to constraints on Bazel aspects,
  this means the `plugin_options` attribute on rules is no longer supportable;
  although this attribute is still supported at the plugin level
- The layout of `.bzl` files to `load()` has been changed. Rules are now in
  `//{lang}:defs.bzl` and workspace rules are in `//{lang}:repositories.bzl`.
  The old paths are still supported, but may be removed in a future release
- The names of the language plugins have been updated from `{lang}` to
  `{lang}_plugin`
- Support has been added for plugins that have non-predictable output file
  layouts by using `ctx.actions.declare_directory`
- Common functions have moved into `.bzl` files in `/internal`
- The previous transitive based compilation method is no longer available
- Dependencies have been updated
- The `protoc` compiler is now resolved via a toolchain, requiring users to
  register the toolchain with `rules_proto_grpc_toolchains`. This is shown in
  the `WORKSPACE` example in the documentation
- Test workspaces have been added to ensure the rules produce the correct
  outputs for a selection of known issues
- The use of `--incompatible-*` flags is no longer required
- Dependencies are now managed at a language-level granularity, rather than at
  rule-level. Bazel will ensure unused dependencies are not loaded

  
## Language Specific

### Dart

- Dart is presently no longer supported, due to lack of maintenance of the
  upstream rules

### Go

- Due to restrictions on attributes sent to a Bazel aspect, the `importmap`
  attribute is no longer supported. If you need this behaviour, you may need to
  re-define your own plugin for the Go protoc plugin


### Node.js

- The Node.js rules have moved to the standard `bazel_build_rules_nodejs` as
  the upstream provider of rules
- The Node.js rules have moved from `/node` to `/nodejs`


### Python

- Python dependencies have been updated. The `protobuf` package is now pulled
  directly from the `@com_google_protobuf` repo rather than via Pip
- The requirements files have been merged and moved to
  `//python:requirements.txt`
- Support for [grpclib](https://github.com/vmagamedov/grpclib) has been added as
  an asyncio gRPC implementation


### Rust

- Rust raze dependencies are now internally managed due to outdated versions
  upstream
- Rust gRPC now uses [grpc-rs](https://github.com/pingcap/grpc-rs)
