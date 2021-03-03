# D rules

Rules for generating D protobuf `.d` files and libraries using [protobuf-d](https://github.com/dcarp/protobuf-d). Libraries are created with `d_library` from [rules_d](https://github.com/bazelbuild/rules_d)

**NOTE**: These rules use the protoc-gen-d plugin, which only supports proto3 .proto files.

| Rule | Description |
| ---: | :--- |
| [d_proto_compile](#d_proto_compile) | Generates D protobuf `.d` files |
| [d_proto_library](#d_proto_library) | Generates a D protobuf library using `d_library` from `rules_d` |

---

## `d_proto_compile`

Generates D protobuf `.d` files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//d:repositories.bzl", rules_proto_grpc_d_repos = "d_repos")

rules_proto_grpc_d_repos()

load("@io_bazel_rules_d//d:d.bzl", "d_repositories")

d_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//d:defs.bzl", "d_proto_compile")

d_proto_compile(
    name = "person_d_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

d_proto_compile(
    name = "place_d_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

d_proto_compile(
    name = "thing_d_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `label_list` | true | ``    | List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)          |
| `options` | `string_list_dict` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | `""`    | Path to prefix to the generated files in the output directory          |
| `extra_protoc_args` | `string_list` | false | `[]`    | A list of extra args to pass directly to protoc, not as plugin options          |

### Plugins

- `@rules_proto_grpc//d:d_plugin`

---

## `d_proto_library`

Generates a D protobuf library using `d_library` from `rules_d`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//d:repositories.bzl", rules_proto_grpc_d_repos = "d_repos")

rules_proto_grpc_d_repos()

load("@io_bazel_rules_d//d:d.bzl", "d_repositories")

d_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//d:defs.bzl", "d_proto_library")

d_proto_library(
    name = "person_d_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_d_proto"],
)

d_proto_library(
    name = "place_d_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_d_proto"],
)

d_proto_library(
    name = "thing_d_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `label_list` | true | ``    | List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)          |
| `options` | `string_list_dict` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | `""`    | Path to prefix to the generated files in the output directory          |
| `extra_protoc_args` | `string_list` | false | `[]`    | A list of extra args to pass directly to protoc, not as plugin options          |
