# Node.js rules

Rules for generating Node.js protobuf and gRPC `.js` files using standard Protocol Buffers and gRPC.

| Rule | Description |
| ---: | :--- |
| [nodejs_proto_compile](#nodejs_proto_compile) | Generates Node.js protobuf `.js` artifacts |
| [nodejs_grpc_compile](#nodejs_grpc_compile) | Generates Node.js protobuf+gRPC `.js` artifacts |
| [nodejs_proto_library](#nodejs_proto_library) | Generates a Node.js protobuf library using `js_library` from `rules_nodejs` |
| [nodejs_grpc_library](#nodejs_grpc_library) | Generates a Node.js protobuf+gRPC library using `js_library` from `rules_nodejs` |

---

## `nodejs_proto_compile`

Generates Node.js protobuf `.js` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//nodejs:repositories.bzl", rules_proto_grpc_nodejs_repos="nodejs_repos")

rules_proto_grpc_nodejs_repos()

load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

yarn_install(
    name = "nodejs_modules",
    package_json = "@rules_proto_grpc//nodejs:requirements/package.json",
    yarn_lock = "@rules_proto_grpc//nodejs:requirements/yarn.lock",
)
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//nodejs:defs.bzl", "nodejs_proto_compile")

nodejs_proto_compile(
    name = "person_nodejs_proto",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `nodejs_grpc_compile`

Generates Node.js protobuf+gRPC `.js` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//nodejs:repositories.bzl", rules_proto_grpc_nodejs_repos="nodejs_repos")

rules_proto_grpc_nodejs_repos()

load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

yarn_install(
    name = "nodejs_modules",
    package_json = "@rules_proto_grpc//nodejs:requirements/package.json",
    yarn_lock = "@rules_proto_grpc//nodejs:requirements/yarn.lock",
)
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//nodejs:defs.bzl", "nodejs_grpc_compile")

nodejs_grpc_compile(
    name = "greeter_nodejs_grpc",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `nodejs_proto_library`

> NOTE: this rule is EXPERIMENTAL.  It may not work correctly or even compile!

Generates a Node.js protobuf library using `js_library` from `rules_nodejs`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//nodejs:repositories.bzl", rules_proto_grpc_nodejs_repos="nodejs_repos")

rules_proto_grpc_nodejs_repos()

load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

yarn_install(
    name = "nodejs_modules",
    package_json = "@rules_proto_grpc//nodejs:requirements/package.json",
    yarn_lock = "@rules_proto_grpc//nodejs:requirements/yarn.lock",
)
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//nodejs:defs.bzl", "nodejs_proto_library")

nodejs_proto_library(
    name = "person_nodejs_library",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `nodejs_grpc_library`

> NOTE: this rule is EXPERIMENTAL.  It may not work correctly or even compile!

Generates a Node.js protobuf+gRPC library using `js_library` from `rules_nodejs`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//nodejs:repositories.bzl", rules_proto_grpc_nodejs_repos="nodejs_repos")

rules_proto_grpc_nodejs_repos()

load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

yarn_install(
    name = "nodejs_modules",
    package_json = "@rules_proto_grpc//nodejs:requirements/package.json",
    yarn_lock = "@rules_proto_grpc//nodejs:requirements/yarn.lock",
)
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//nodejs:defs.bzl", "nodejs_grpc_library")

nodejs_grpc_library(
    name = "greeter_nodejs_library",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
