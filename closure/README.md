# Closure rules

Rules for generating Closure protobuf `.js` files and libraries using standard Protocol Buffers. Libraries are created with `closure_js_library` from [rules_closure](https://github.com/bazelbuild/rules_closure)

| Rule | Description |
| ---: | :--- |
| [closure_proto_compile](#closure_proto_compile) | Generates Closure protobuf `.js` files |
| [closure_proto_library](#closure_proto_library) | Generates a Closure library with compiled protobuf `.js` files using `closure_js_library` from `rules_closure` |

---

## `closure_proto_compile`

Generates Closure protobuf `.js` files

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//closure:repositories.bzl", rules_proto_grpc_closure_repos="closure_repos")

rules_proto_grpc_closure_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//closure:defs.bzl", "closure_proto_compile")

closure_proto_compile(
    name = "person_closure_proto",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `closure_proto_library`

Generates a Closure library with compiled protobuf `.js` files using `closure_js_library` from `rules_closure`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//closure:repositories.bzl", rules_proto_grpc_closure_repos="closure_repos")

rules_proto_grpc_closure_repos()

load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")

rules_closure_dependencies(
    omit_bazel_skylib = True,
    omit_com_google_protobuf = True,
    omit_zlib = True,
)
rules_closure_toolchains()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//closure:defs.bzl", "closure_proto_library")

closure_proto_library(
    name = "person_closure_library",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
