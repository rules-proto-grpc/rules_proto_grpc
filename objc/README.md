# Objective-C rules

Rules for generating Objective-C protobuf and gRPC `.m` & `.h` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with the Bazel native `objc_library`

| Rule | Description |
| ---: | :--- |
| [objc_proto_compile](#objc_proto_compile) | Generates Objective-C protobuf `.m` & `.h` artifacts |
| [objc_grpc_compile](#objc_grpc_compile) | Generates Objective-C protobuf+gRPC `.m` & `.h` artifacts |
| [objc_proto_library](#objc_proto_library) | Generates an Objective-C protobuf library using `objc_library` |

---

## `objc_proto_compile`

Generates Objective-C protobuf `.m` & `.h` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//objc:repositories.bzl", rules_proto_grpc_objc_repos = "objc_repos")

rules_proto_grpc_objc_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//objc:defs.bzl", "objc_proto_compile")

objc_proto_compile(
    name = "person_objc_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

objc_proto_compile(
    name = "place_objc_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

objc_proto_compile(
    name = "thing_objc_proto",
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

---

## `objc_grpc_compile`

Generates Objective-C protobuf+gRPC `.m` & `.h` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//objc:repositories.bzl", rules_proto_grpc_objc_repos = "objc_repos")

rules_proto_grpc_objc_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//objc:defs.bzl", "objc_grpc_compile")

objc_grpc_compile(
    name = "thing_objc_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

objc_grpc_compile(
    name = "greeter_objc_grpc",
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

---

## `objc_proto_library`

Generates an Objective-C protobuf library using `objc_library`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//objc:repositories.bzl", rules_proto_grpc_objc_repos = "objc_repos")

rules_proto_grpc_objc_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//objc:defs.bzl", "objc_proto_library")

objc_proto_library(
    name = "person_objc_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_objc_proto"],
)

objc_proto_library(
    name = "place_objc_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_objc_proto"],
)

objc_proto_library(
    name = "thing_objc_proto",
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
