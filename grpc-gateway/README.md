# grpc-gateway rules

| Rule | Description |
| ---: | :--- |
| [gateway_grpc_compile](#gateway_grpc_compile) | Generates grpc-gateway `.go` files |
| [gateway_openapiv2_compile](#gateway_openapiv2_compile) | Generates grpc-gateway OpenAPI v2 `.json` files |
| [gateway_grpc_library](#gateway_grpc_library) | Generates grpc-gateway library files |

---

## `gateway_grpc_compile`

Generates grpc-gateway `.go` files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//:repositories.bzl", "bazel_gazelle", "io_bazel_rules_go")

io_bazel_rules_go()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(
    version = "1.15.8",
)

bazel_gazelle()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("@rules_proto_grpc//grpc-gateway:repositories.bzl", rules_proto_grpc_gateway_repos="gateway_repos")

rules_proto_grpc_gateway_repos()

load("@grpc_ecosystem_grpc_gateway//:repositories.bzl", "go_repositories")

go_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//grpc-gateway:defs.bzl", "gateway_grpc_compile")

gateway_grpc_compile(
    name = "api_gateway_grpc",
    deps = ["@rules_proto_grpc//grpc-gateway/example/api:api_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `gateway_openapiv2_compile`

Generates grpc-gateway OpenAPI v2 `.json` files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//:repositories.bzl", "bazel_gazelle", "io_bazel_rules_go")

io_bazel_rules_go()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(
    version = "1.15.8",
)

bazel_gazelle()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("@rules_proto_grpc//grpc-gateway:repositories.bzl", rules_proto_grpc_gateway_repos="gateway_repos")

rules_proto_grpc_gateway_repos()

load("@grpc_ecosystem_grpc_gateway//:repositories.bzl", "go_repositories")

go_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//grpc-gateway:defs.bzl", "gateway_openapiv2_compile")

gateway_openapiv2_compile(
    name = "api_gateway_grpc",
    deps = ["@rules_proto_grpc//grpc-gateway/example/api:api_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `gateway_grpc_library`

Generates grpc-gateway library files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//:repositories.bzl", "bazel_gazelle", "io_bazel_rules_go")

io_bazel_rules_go()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(
    version = "1.15.8",
)

bazel_gazelle()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("@rules_proto_grpc//grpc-gateway:repositories.bzl", rules_proto_grpc_gateway_repos="gateway_repos")

rules_proto_grpc_gateway_repos()

load("@grpc_ecosystem_grpc_gateway//:repositories.bzl", "go_repositories")

go_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//grpc-gateway:defs.bzl", "gateway_grpc_library")

gateway_grpc_library(
    name = "api_gateway_library",
    importpath = "github.com/rules-proto-grpc/rules_proto_grpc/grpc-gateway/examples/api",
    deps = ["@rules_proto_grpc//grpc-gateway/example/api:api_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `importpath` | `string` | false | `None`    | Importpath for the generated artifacts          |