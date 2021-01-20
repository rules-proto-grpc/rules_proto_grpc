# Java rules

Rules for generating Java protobuf and gRPC `.jar` files and libraries using standard Protocol Buffers and [gRPC-Java](https://github.com/grpc/grpc-java). Libraries are created with the Bazel native `java_library`

| Rule | Description |
| ---: | :--- |
| [java_proto_compile](#java_proto_compile) | Generates a Java protobuf srcjar artifact |
| [java_grpc_compile](#java_grpc_compile) | Generates a Java protobuf+gRPC srcjar artifact |
| [java_proto_library](#java_proto_library) | Generates a Java protobuf library using `java_library` |
| [java_grpc_library](#java_grpc_library) | Generates a Java protobuf+gRPC library using `java_library` |

---

## `java_proto_compile`

Generates a Java protobuf srcjar artifact

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos="java_repos")

rules_proto_grpc_java_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//java:defs.bzl", "java_proto_compile")

java_proto_compile(
    name = "person_java_proto",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `java_grpc_compile`

Generates a Java protobuf+gRPC srcjar artifact

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos="java_repos")

rules_proto_grpc_java_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//java:defs.bzl", "java_grpc_compile")

java_grpc_compile(
    name = "greeter_java_grpc",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `java_proto_library`

Generates a Java protobuf library using `java_library`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos="java_repos")

rules_proto_grpc_java_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//java:defs.bzl", "java_proto_library")

java_proto_library(
    name = "person_java_library",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `java_grpc_library`

Generates a Java protobuf+gRPC library using `java_library`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos="java_repos")

rules_proto_grpc_java_repos()

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

grpc_java_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//java:defs.bzl", "java_grpc_library")

java_grpc_library(
    name = "greeter_java_library",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
