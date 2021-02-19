# Scala rules

Rules for generating Scala protobuf and gRPC `.jar` files and libraries using [ScalaPB](https://github.com/scalapb/ScalaPB). Libraries are created with `scala_library` from [rules_scala](https://github.com/bazelbuild/rules_scala)

| Rule | Description |
| ---: | :--- |
| [scala_proto_compile](#scala_proto_compile) | Generates a Scala protobuf `.jar` artifact |
| [scala_grpc_compile](#scala_grpc_compile) | Generates Scala protobuf+gRPC `.jar` artifacts |
| [scala_proto_library](#scala_proto_library) | Generates a Scala protobuf library using `scala_library` from `rules_scala` |
| [scala_grpc_library](#scala_grpc_library) | Generates a Scala protobuf+gRPC library using `scala_library` from `rules_scala` |

---

## `scala_proto_compile`

Generates a Scala protobuf `.jar` artifact

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")

rules_proto_grpc_scala_repos()

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//scala:defs.bzl", "scala_proto_compile")

scala_proto_compile(
    name = "person_scala_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

scala_proto_compile(
    name = "place_scala_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

scala_proto_compile(
    name = "thing_scala_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | ``    | Path to prefix to the generated files in the output directory          |
| `extra_protoc_args` | `list<string>` | false | `[]`    | A list of extra args to pass directly to protoc, not as plugin options          |

### Plugins

- `@rules_proto_grpc//scala:scala_plugin`

---

## `scala_grpc_compile`

Generates Scala protobuf+gRPC `.jar` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")

rules_proto_grpc_scala_repos()

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

grpc_java_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//scala:defs.bzl", "scala_grpc_compile")

scala_grpc_compile(
    name = "thing_scala_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

scala_grpc_compile(
    name = "greeter_scala_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | ``    | Path to prefix to the generated files in the output directory          |
| `extra_protoc_args` | `list<string>` | false | `[]`    | A list of extra args to pass directly to protoc, not as plugin options          |

### Plugins

- `@rules_proto_grpc//scala:grpc_scala_plugin`

---

## `scala_proto_library`

Generates a Scala protobuf library using `scala_library` from `rules_scala`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")

rules_proto_grpc_scala_repos()

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//scala:defs.bzl", "scala_proto_library")

scala_proto_library(
    name = "person_scala_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_scala_proto"],
)

scala_proto_library(
    name = "place_scala_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_scala_proto"],
)

scala_proto_library(
    name = "thing_scala_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | ``    | Path to prefix to the generated files in the output directory          |
| `extra_protoc_args` | `list<string>` | false | `[]`    | A list of extra args to pass directly to protoc, not as plugin options          |
| `deps` | `list<Label/string>` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
| `exports` | `list` | false | `[]`    | List of labels to pass as exports attr to underlying lang_library rule          |

---

## `scala_grpc_library`

Generates a Scala protobuf+gRPC library using `scala_library` from `rules_scala`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")

rules_proto_grpc_scala_repos()

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

grpc_java_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//scala:defs.bzl", "scala_grpc_library")

scala_grpc_library(
    name = "thing_scala_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

scala_grpc_library(
    name = "greeter_scala_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
    deps = ["thing_scala_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | ``    | Path to prefix to the generated files in the output directory          |
| `extra_protoc_args` | `list<string>` | false | `[]`    | A list of extra args to pass directly to protoc, not as plugin options          |
| `deps` | `list<Label/string>` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
| `exports` | `list` | false | `[]`    | List of labels to pass as exports attr to underlying lang_library rule          |
