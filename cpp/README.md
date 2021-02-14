# C++ rules

Rules for generating C++ protobuf and gRPC `.cc` & `.h` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with the Bazel native `cc_library`

| Rule | Description |
| ---: | :--- |
| [cpp_proto_compile](#cpp_proto_compile) | Generates C++ protobuf `.h` & `.cc` artifacts |
| [cpp_grpc_compile](#cpp_grpc_compile) | Generates C++ protobuf+gRPC `.h` & `.cc` artifacts |
| [cpp_proto_library](#cpp_proto_library) | Generates a C++ protobuf library using `cc_library`, with dependencies linked |
| [cpp_grpc_library](#cpp_grpc_library) | Generates a C++ protobuf+gRPC library using `cc_library`, with dependencies linked |

---

## `cpp_proto_compile`

Generates C++ protobuf `.h` & `.cc` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")

rules_proto_grpc_cpp_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_compile")

cpp_proto_compile(
    name = "person_cpp_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

cpp_proto_compile(
    name = "place_cpp_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

cpp_proto_compile(
    name = "thing_cpp_proto",
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

## `cpp_grpc_compile`

Generates C++ protobuf+gRPC `.h` & `.cc` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")

rules_proto_grpc_cpp_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//cpp:defs.bzl", "cpp_grpc_compile")

cpp_grpc_compile(
    name = "thing_cpp_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

cpp_grpc_compile(
    name = "greeter_cpp_grpc",
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

## `cpp_proto_library`

Generates a C++ protobuf library using `cc_library`, with dependencies linked

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")

rules_proto_grpc_cpp_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_library")

cpp_proto_library(
    name = "person_cpp_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_cpp_proto"],
)

cpp_proto_library(
    name = "place_cpp_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_cpp_proto"],
)

cpp_proto_library(
    name = "thing_cpp_proto",
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

## `cpp_grpc_library`

Generates a C++ protobuf+gRPC library using `cc_library`, with dependencies linked

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")

rules_proto_grpc_cpp_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//cpp:defs.bzl", "cpp_grpc_library")

cpp_grpc_library(
    name = "thing_cpp_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

cpp_grpc_library(
    name = "greeter_cpp_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
    deps = ["thing_cpp_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `deps` | `list<Label/string>` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
