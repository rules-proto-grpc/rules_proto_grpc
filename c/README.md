# C rules

Rules for generating C protobuf `.c` & `.h` files and libraries using [upb](https://github.com/protocolbuffers/upb). Libraries are created with the Bazel native `cc_library`

| Rule | Description |
| ---: | :--- |
| [c_proto_compile](#c_proto_compile) | Generates C protobuf `.h` & `.c` files |
| [c_proto_library](#c_proto_library) | Generates a C protobuf library using `cc_library`, with dependencies linked |

---

## `c_proto_compile`

> NOTE: this rule is EXPERIMENTAL.  It may not work correctly or even compile!

Generates C protobuf `.h` & `.c` files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//c:repositories.bzl", rules_proto_grpc_c_repos = "c_repos")

rules_proto_grpc_c_repos()

load("@upb//bazel:workspace_deps.bzl", "upb_deps")

upb_deps()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//c:defs.bzl", "c_proto_compile")

c_proto_compile(
    name = "person_c_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

c_proto_compile(
    name = "place_c_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

c_proto_compile(
    name = "thing_c_proto",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<Label[ProtoInfo]>` | true | `[]`    | List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | `""`    | Path to prefix to the generated files in the output directory          |
| `extra_protoc_args` | `list<string>` | false | `[]`    | A list of extra args to pass directly to protoc, not as plugin options          |

### Plugins

- `@rules_proto_grpc//c:upb_plugin`

---

## `c_proto_library`

> NOTE: this rule is EXPERIMENTAL.  It may not work correctly or even compile!

Generates a C protobuf library using `cc_library`, with dependencies linked

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//c:repositories.bzl", rules_proto_grpc_c_repos = "c_repos")

rules_proto_grpc_c_repos()

load("@upb//bazel:workspace_deps.bzl", "upb_deps")

upb_deps()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//c:defs.bzl", "c_proto_library")

c_proto_library(
    name = "proto_c_proto",
    importpath = "github.com/rules-proto-grpc/rules_proto_grpc/example/proto",
    protos = [
        "@com_google_protobuf//:any_proto",
        "@rules_proto_grpc//example/proto:person_proto",
        "@rules_proto_grpc//example/proto:place_proto",
        "@rules_proto_grpc//example/proto:thing_proto",
    ],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<Label[ProtoInfo]>` | true | `[]`    | List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)          |
| `options` | `dict<string, list(string)>` | false | `[]`    | Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `prefix_path` | `string` | false | `""`    | Path to prefix to the generated files in the output directory          |
| `extra_protoc_args` | `list<string>` | false | `[]`    | A list of extra args to pass directly to protoc, not as plugin options          |
| `deps` | `list<Label/string>` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
| `alwayslink` | `bool` | false | `None`    | Passed to the `alwayslink` attribute of `cc_library`.          |
| `copts` | `list<string>` | false | `None`    | Passed to the `opts` attribute of `cc_library`.          |
| `defines` | `list<string>` | false | `None`    | Passed to the `defines` attribute of `cc_library`.          |
| `include_prefix` | `string` | false | `None`    | Passed to the `include_prefix` attribute of `cc_library`.          |
| `linkopts` | `list<string>` | false | `None`    | Passed to the `linkopts` attribute of `cc_library`.          |
| `linkstatic` | `bool` | false | `None`    | Passed to the `linkstatic` attribute of `cc_library`.          |
| `local_defines` | `list<string>` | false | `None`    | Passed to the `local_defines` attribute of `cc_library`.          |
| `nocopts` | `string` | false | `None`    | Passed to the `nocopts` attribute of `cc_library`.          |
| `strip_include_prefix` | `string` | false | `None`    | Passed to the `strip_include_prefix` attribute of `cc_library`.          |
