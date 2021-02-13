# gRPC-Web rules

| Rule | Description |
| ---: | :--- |
| [closure_grpc_compile](#closure_grpc_compile) | Generates Closure *.js protobuf+gRPC files |
| [commonjs_grpc_compile](#commonjs_grpc_compile) | Generates CommonJS *.js protobuf+gRPC files |
| [commonjs_dts_grpc_compile](#commonjs_dts_grpc_compile) | Generates commonjs_dts *.js protobuf+gRPC files |
| [ts_grpc_compile](#ts_grpc_compile) | Generates CommonJS *.ts protobuf+gRPC files |
| [closure_grpc_library](#closure_grpc_library) | Generates protobuf closure library *.js files |

---

## `closure_grpc_compile`

Generates Closure *.js protobuf+gRPC files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//grpc-web:repositories.bzl", rules_proto_grpc_grpc_web_repos="grpc_web_repos")

rules_proto_grpc_grpc_web_repos()

load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")
rules_closure_dependencies(
    omit_com_google_protobuf = True,
)
rules_closure_toolchains()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//grpc-web:defs.bzl", "closure_grpc_compile")

closure_grpc_compile(
    name = "thing_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

closure_grpc_compile(
    name = "greeter_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `commonjs_grpc_compile`

Generates CommonJS *.js protobuf+gRPC files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//grpc-web:repositories.bzl", rules_proto_grpc_grpc_web_repos="grpc_web_repos")

rules_proto_grpc_grpc_web_repos()

load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")
rules_closure_dependencies(
    omit_com_google_protobuf = True,
)
rules_closure_toolchains()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//grpc-web:defs.bzl", "commonjs_grpc_compile")

commonjs_grpc_compile(
    name = "thing_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

commonjs_grpc_compile(
    name = "greeter_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `commonjs_dts_grpc_compile`

Generates commonjs_dts *.js protobuf+gRPC files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//grpc-web:repositories.bzl", rules_proto_grpc_grpc_web_repos="grpc_web_repos")

rules_proto_grpc_grpc_web_repos()

load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")
rules_closure_dependencies(
    omit_com_google_protobuf = True,
)
rules_closure_toolchains()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//grpc-web:defs.bzl", "commonjs_dts_grpc_compile")

commonjs_dts_grpc_compile(
    name = "thing_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

commonjs_dts_grpc_compile(
    name = "greeter_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `ts_grpc_compile`

Generates CommonJS *.ts protobuf+gRPC files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//grpc-web:repositories.bzl", rules_proto_grpc_grpc_web_repos="grpc_web_repos")

rules_proto_grpc_grpc_web_repos()

load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")
rules_closure_dependencies(
    omit_com_google_protobuf = True,
)
rules_closure_toolchains()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//grpc-web:defs.bzl", "ts_grpc_compile")

ts_grpc_compile(
    name = "thing_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

ts_grpc_compile(
    name = "greeter_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `closure_grpc_library`

Generates protobuf closure library *.js files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//grpc-web:repositories.bzl", rules_proto_grpc_grpc_web_repos="grpc_web_repos")

rules_proto_grpc_grpc_web_repos()

load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")
rules_closure_dependencies(
    omit_com_google_protobuf = True,
)
rules_closure_toolchains()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//grpc-web:defs.bzl", "closure_grpc_library")

closure_grpc_library(
    name = "thing_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

closure_grpc_library(
    name = "greeter_grpc-web_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
    deps = ["thing_grpc-web_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `protos` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `rules_proto` `proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
| `deps` | `list` | false | `[]`    | List of labels to pass as deps attr to underlying lang_library rule          |
