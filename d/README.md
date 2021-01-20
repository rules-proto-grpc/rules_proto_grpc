# D rules

Rules for generating D protobuf `.d` files and libraries using [protobuf-d](https://github.com/dcarp/protobuf-d). Libraries are created with `d_library` from [rules_d](https://github.com/bazelbuild/rules_d)

**NOTE**: These rules use the protoc-gen-d plugin, which only supports proto3 .proto files.

| Rule | Description |
| ---: | :--- |
| [d_proto_compile](#d_proto_compile) | Generates D protobuf `.d` artifacts |
| [d_proto_library](#d_proto_library) | Generates a D protobuf library using `d_library` from `rules_d` |

---

## `d_proto_compile`

Generates D protobuf `.d` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//d:repositories.bzl", rules_proto_grpc_d_repos="d_repos")

rules_proto_grpc_d_repos()

load("@io_bazel_rules_d//d:d.bzl", "d_repositories")

d_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//d:defs.bzl", "d_proto_compile")

d_proto_compile(
    name = "person_d_proto",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `d_proto_library`

Generates a D protobuf library using `d_library` from `rules_d`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//d:repositories.bzl", rules_proto_grpc_d_repos="d_repos")

rules_proto_grpc_d_repos()

load("@io_bazel_rules_d//d:d.bzl", "d_repositories")

d_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//d:defs.bzl", "d_proto_library")

d_proto_library(
    name = "person_d_library",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
