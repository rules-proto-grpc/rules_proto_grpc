# Ruby rules

Rules for generating Ruby protobuf and gRPC `.rb` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with `ruby_library` from [rules_ruby](https://github.com/yugui/rules_ruby). Note, the Ruby library rules presently cannot set the `includes` attribute correctly, requiring users to set this manually. See https://github.com/yugui/rules_ruby/pull/8

| Rule | Description |
| ---: | :--- |
| [ruby_proto_compile](#ruby_proto_compile) | Generates Ruby protobuf `.rb` artifacts |
| [ruby_grpc_compile](#ruby_grpc_compile) | Generates Ruby protobuf+gRPC `.rb` artifacts |
| [ruby_proto_library](#ruby_proto_library) | Generates a Ruby protobuf library using `ruby_library` from `rules_ruby` |
| [ruby_grpc_library](#ruby_grpc_library) | Generates a Ruby protobuf+gRPC library using `ruby_library` from `rules_ruby` |

---

## `ruby_proto_compile`

Generates Ruby protobuf `.rb` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//ruby:repositories.bzl", rules_proto_grpc_ruby_repos = "ruby_repos")

rules_proto_grpc_ruby_repos()

load("@bazelruby_rules_ruby//ruby:deps.bzl", "rules_ruby_dependencies", "rules_ruby_select_sdk")

rules_ruby_dependencies()

rules_ruby_select_sdk(version = "2.7.1")

load("@bazelruby_rules_ruby//ruby:defs.bzl", "ruby_bundle")

ruby_bundle(
    name = "rules_proto_grpc_bundle",
    gemfile = "@rules_proto_grpc//ruby:Gemfile",
    gemfile_lock = "@rules_proto_grpc//ruby:Gemfile.lock",
)
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//ruby:defs.bzl", "ruby_proto_compile")

ruby_proto_compile(
    name = "person_ruby_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

ruby_proto_compile(
    name = "place_ruby_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

ruby_proto_compile(
    name = "thing_ruby_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `ruby_grpc_compile`

Generates Ruby protobuf+gRPC `.rb` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//ruby:repositories.bzl", rules_proto_grpc_ruby_repos = "ruby_repos")

rules_proto_grpc_ruby_repos()

load("@bazelruby_rules_ruby//ruby:deps.bzl", "rules_ruby_dependencies", "rules_ruby_select_sdk")

rules_ruby_dependencies()

rules_ruby_select_sdk(version = "2.7.1")

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@bazelruby_rules_ruby//ruby:defs.bzl", "ruby_bundle")

ruby_bundle(
    name = "rules_proto_grpc_bundle",
    gemfile = "@rules_proto_grpc//ruby:Gemfile",
    gemfile_lock = "@rules_proto_grpc//ruby:Gemfile.lock",
)
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//ruby:defs.bzl", "ruby_grpc_compile")

ruby_grpc_compile(
    name = "thing_ruby_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

ruby_grpc_compile(
    name = "greeter_ruby_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `ruby_proto_library`

Generates a Ruby protobuf library using `ruby_library` from `rules_ruby`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//ruby:repositories.bzl", rules_proto_grpc_ruby_repos = "ruby_repos")

rules_proto_grpc_ruby_repos()

load("@bazelruby_rules_ruby//ruby:deps.bzl", "rules_ruby_dependencies", "rules_ruby_select_sdk")

rules_ruby_dependencies()

rules_ruby_select_sdk(version = "2.7.1")

load("@bazelruby_rules_ruby//ruby:defs.bzl", "ruby_bundle")

ruby_bundle(
    name = "rules_proto_grpc_bundle",
    gemfile = "@rules_proto_grpc//ruby:Gemfile",
    gemfile_lock = "@rules_proto_grpc//ruby:Gemfile.lock",
)
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//ruby:defs.bzl", "ruby_proto_library")

ruby_proto_library(
    name = "person_ruby_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_ruby_proto"],
)

ruby_proto_library(
    name = "place_ruby_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_ruby_proto"],
)

ruby_proto_library(
    name = "thing_ruby_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `deps` | `list<Label/string>` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |

---

## `ruby_grpc_library`

Generates a Ruby protobuf+gRPC library using `ruby_library` from `rules_ruby`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//ruby:repositories.bzl", rules_proto_grpc_ruby_repos = "ruby_repos")

rules_proto_grpc_ruby_repos()

load("@bazelruby_rules_ruby//ruby:deps.bzl", "rules_ruby_dependencies", "rules_ruby_select_sdk")

rules_ruby_dependencies()

rules_ruby_select_sdk(version = "2.7.1")

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@bazelruby_rules_ruby//ruby:defs.bzl", "ruby_bundle")

ruby_bundle(
    name = "rules_proto_grpc_bundle",
    gemfile = "@rules_proto_grpc//ruby:Gemfile",
    gemfile_lock = "@rules_proto_grpc//ruby:Gemfile.lock",
)
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//ruby:defs.bzl", "ruby_grpc_library")

ruby_grpc_library(
    name = "thing_ruby_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

ruby_grpc_library(
    name = "greeter_ruby_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
    deps = ["thing_ruby_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `deps` | `list<Label/string>` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
