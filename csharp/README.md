# C# rules

Rules for generating C# protobuf and gRPC `.cs` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with `core_library` from [rules_dotnet](https://github.com/bazelbuild/rules_dotnet)

| Rule | Description |
| ---: | :--- |
| [csharp_proto_compile](#csharp_proto_compile) | Generates C# protobuf `.cs` artifacts |
| [csharp_grpc_compile](#csharp_grpc_compile) | Generates C# protobuf+gRPC `.cs` artifacts |
| [csharp_proto_library](#csharp_proto_library) | Generates a C# protobuf library using `core_library` from `rules_dotnet`. Note that the library name must end in `.dll` |
| [csharp_grpc_library](#csharp_grpc_library) | Generates a C# protobuf+gRPC library using `core_library` from `rules_dotnet`. Note that the library name must end in `.dll` |

---

## `csharp_proto_compile`

Generates C# protobuf `.cs` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//csharp:repositories.bzl", rules_proto_grpc_csharp_repos = "csharp_repos")

rules_proto_grpc_csharp_repos()

load("@io_bazel_rules_dotnet//dotnet:deps.bzl", "dotnet_repositories")

dotnet_repositories()

load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "core_register_sdk",
    "dotnet_register_toolchains",
    "dotnet_repositories_nugets",
)

dotnet_register_toolchains()

dotnet_repositories_nugets()

core_register_sdk()

load("@rules_proto_grpc//csharp/nuget:nuget.bzl", "nuget_rules_proto_grpc_packages")

nuget_rules_proto_grpc_packages()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//csharp:defs.bzl", "csharp_proto_compile")

csharp_proto_compile(
    name = "person_csharp_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

csharp_proto_compile(
    name = "place_csharp_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

csharp_proto_compile(
    name = "thing_csharp_proto",
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

---

## `csharp_grpc_compile`

Generates C# protobuf+gRPC `.cs` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//csharp:repositories.bzl", rules_proto_grpc_csharp_repos = "csharp_repos")

rules_proto_grpc_csharp_repos()

load("@io_bazel_rules_dotnet//dotnet:deps.bzl", "dotnet_repositories")
load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

dotnet_repositories()

load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "core_register_sdk",
    "dotnet_register_toolchains",
    "dotnet_repositories_nugets",
)

dotnet_register_toolchains()

dotnet_repositories_nugets()

core_register_sdk()

load("@rules_proto_grpc//csharp/nuget:nuget.bzl", "nuget_rules_proto_grpc_packages")

nuget_rules_proto_grpc_packages()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//csharp:defs.bzl", "csharp_grpc_compile")

csharp_grpc_compile(
    name = "thing_csharp_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

csharp_grpc_compile(
    name = "greeter_csharp_grpc",
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

---

## `csharp_proto_library`

Generates a C# protobuf library using `core_library` from `rules_dotnet`. Note that the library name must end in `.dll`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//csharp:repositories.bzl", rules_proto_grpc_csharp_repos = "csharp_repos")

rules_proto_grpc_csharp_repos()

load("@io_bazel_rules_dotnet//dotnet:deps.bzl", "dotnet_repositories")

dotnet_repositories()

load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "core_register_sdk",
    "dotnet_register_toolchains",
    "dotnet_repositories_nugets",
)

dotnet_register_toolchains()

dotnet_repositories_nugets()

core_register_sdk()

load("@rules_proto_grpc//csharp/nuget:nuget.bzl", "nuget_rules_proto_grpc_packages")

nuget_rules_proto_grpc_packages()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//csharp:defs.bzl", "csharp_proto_library")

csharp_proto_library(
    name = "person_csharp_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_csharp_proto"],
)

csharp_proto_library(
    name = "place_csharp_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_csharp_proto"],
)

csharp_proto_library(
    name = "thing_csharp_proto",
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
| `deps` | `list<Label/string>` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |

---

## `csharp_grpc_library`

Generates a C# protobuf+gRPC library using `core_library` from `rules_dotnet`. Note that the library name must end in `.dll`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//csharp:repositories.bzl", rules_proto_grpc_csharp_repos = "csharp_repos")

rules_proto_grpc_csharp_repos()

load("@io_bazel_rules_dotnet//dotnet:deps.bzl", "dotnet_repositories")
load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

dotnet_repositories()

load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "core_register_sdk",
    "dotnet_register_toolchains",
    "dotnet_repositories_nugets",
)

dotnet_register_toolchains()

dotnet_repositories_nugets()

core_register_sdk()

load("@rules_proto_grpc//csharp/nuget:nuget.bzl", "nuget_rules_proto_grpc_packages")

nuget_rules_proto_grpc_packages()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//csharp:defs.bzl", "csharp_grpc_library")

csharp_grpc_library(
    name = "thing_csharp_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

csharp_grpc_library(
    name = "greeter_csharp_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
    deps = ["thing_csharp_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | ``    | Path to prefix to the generated files in the output directory          |
| `deps` | `list<Label/string>` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
