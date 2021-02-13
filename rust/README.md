# Rust rules

Rules for generating Rust protobuf and gRPC `.rs` files and libraries using [rust-protobuf](https://github.com/stepancheg/rust-protobuf) and [grpc-rs](https://github.com/tikv/grpc-rs). Libraries are created with `rust_library` from [rules_rust](https://github.com/bazelbuild/rules_rust).

| Rule | Description |
| ---: | :--- |
| [rust_proto_compile](#rust_proto_compile) | Generates Rust protobuf `.rs` artifacts |
| [rust_grpc_compile](#rust_grpc_compile) | Generates Rust protobuf+gRPC `.rs` artifacts |
| [rust_proto_library](#rust_proto_library) | Generates a Rust protobuf library using `rust_library` from `rules_rust` |
| [rust_grpc_library](#rust_grpc_library) | Generates a Rust protobuf+gRPC library using `rust_library` from `rules_rust` |

---

## `rust_proto_compile`

Generates Rust protobuf `.rs` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos="rust_repos")

rules_proto_grpc_rust_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//rust:defs.bzl", "rust_proto_compile")

rust_proto_compile(
    name = "person_rust_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

rust_proto_compile(
    name = "place_rust_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

rust_proto_compile(
    name = "thing_rust_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `rust_grpc_compile`

Generates Rust protobuf+gRPC `.rs` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos="rust_repos")

rules_proto_grpc_rust_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//rust:defs.bzl", "rust_grpc_compile")

rust_grpc_compile(
    name = "thing_rust_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

rust_grpc_compile(
    name = "greeter_rust_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `rust_proto_library`

Generates a Rust protobuf library using `rust_library` from `rules_rust`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos="rust_repos")

rules_proto_grpc_rust_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//rust:defs.bzl", "rust_proto_library")

rust_proto_library(
    name = "proto_rust_proto",
    protos = [
        "@rules_proto_grpc//example/proto:person_proto",
        "@rules_proto_grpc//example/proto:place_proto",
        "@rules_proto_grpc//example/proto:thing_proto",
    ],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `deps` | `list` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |

---

## `rust_grpc_library`

Generates a Rust protobuf+gRPC library using `rust_library` from `rules_rust`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos="rust_repos")

rules_proto_grpc_rust_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//rust:defs.bzl", "rust_grpc_library")

rust_grpc_library(
    name = "greeter_rust_grpc",
    protos = [
        "@rules_proto_grpc//example/proto:thing_proto",
        "@rules_proto_grpc//example/proto:greeter_grpc",
    ],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `deps` | `list` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
