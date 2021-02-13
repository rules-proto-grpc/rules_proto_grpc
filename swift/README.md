# Swift rules

Rules for generating Swift protobuf and gRPC `.swift` files and libraries using [Swift Protobuf](https://github.com/apple/swift-protobuf) and [Swift gRPC](https://github.com/grpc/grpc-swift)

| Rule | Description |
| ---: | :--- |
| [swift_proto_compile](#swift_proto_compile) | Generates Swift protobuf `.swift` artifacts |
| [swift_grpc_compile](#swift_grpc_compile) | Generates Swift protobuf+gRPC `.swift` artifacts |
| [swift_proto_library](#swift_proto_library) | Generates a Swift protobuf library using `swift_library` from `rules_swift` |
| [swift_grpc_library](#swift_grpc_library) | Generates a Swift protobuf+gRPC library using `swift_library` from `rules_swift` |

---

## `swift_proto_compile`

Generates Swift protobuf `.swift` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//swift:repositories.bzl", rules_proto_grpc_swift_repos="swift_repos")

rules_proto_grpc_swift_repos()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//swift:defs.bzl", "swift_proto_compile")

swift_proto_compile(
    name = "person_swift_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

swift_proto_compile(
    name = "place_swift_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

swift_proto_compile(
    name = "thing_swift_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `swift_grpc_compile`

Generates Swift protobuf+gRPC `.swift` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//swift:repositories.bzl", rules_proto_grpc_swift_repos="swift_repos")

rules_proto_grpc_swift_repos()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//swift:defs.bzl", "swift_grpc_compile")

swift_grpc_compile(
    name = "thing_swift_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

swift_grpc_compile(
    name = "greeter_swift_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `swift_proto_library`

Generates a Swift protobuf library using `swift_library` from `rules_swift`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//swift:repositories.bzl", rules_proto_grpc_swift_repos="swift_repos")

rules_proto_grpc_swift_repos()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//swift:defs.bzl", "swift_proto_library")

swift_proto_library(
    name = "person_swift_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_swift_proto"],
)

swift_proto_library(
    name = "place_swift_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_swift_proto"],
)

swift_proto_library(
    name = "thing_swift_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `deps` | `list` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |

---

## `swift_grpc_library`

Generates a Swift protobuf+gRPC library using `swift_library` from `rules_swift`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//swift:repositories.bzl", rules_proto_grpc_swift_repos="swift_repos")

rules_proto_grpc_swift_repos()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//swift:defs.bzl", "swift_grpc_library")

swift_grpc_library(
    name = "person_swift_grpc",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_swift_grpc"],
)

swift_grpc_library(
    name = "place_swift_grpc",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_swift_grpc"],
)

swift_grpc_library(
    name = "thing_swift_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `deps` | `list` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
