# PHP rules

Rules for generating PHP protobuf and gRPC `.php` files and libraries using standard Protocol Buffers and gRPC

| Rule | Description |
| ---: | :--- |
| [php_proto_compile](#php_proto_compile) | Generates PHP protobuf `.php` artifacts |
| [php_grpc_compile](#php_grpc_compile) | Generates PHP protobuf+gRPC `.php` artifacts |

---

## `php_proto_compile`

Generates PHP protobuf `.php` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//php:repositories.bzl", rules_proto_grpc_php_repos = "php_repos")

rules_proto_grpc_php_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//php:defs.bzl", "php_proto_compile")

php_proto_compile(
    name = "person_php_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

php_proto_compile(
    name = "place_php_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

php_proto_compile(
    name = "thing_php_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `php_grpc_compile`

Generates PHP protobuf+gRPC `.php` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//php:repositories.bzl", rules_proto_grpc_php_repos = "php_repos")

rules_proto_grpc_php_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//php:defs.bzl", "php_grpc_compile")

php_grpc_compile(
    name = "thing_php_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

php_grpc_compile(
    name = "greeter_php_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
