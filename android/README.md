# Android rules

Rules for generating Android protobuf and gRPC `.jar` files and libraries using standard Protocol Buffers and [gRPC-Java](https://github.com/grpc/grpc-java). Libraries are created with `android_library` from [rules_android](https://github.com/bazelbuild/rules_android)

| Rule | Description |
| ---: | :--- |
| [android_proto_compile](#android_proto_compile) | Generates an Android protobuf `.jar` artifact |
| [android_grpc_compile](#android_grpc_compile) | Generates Android protobuf+gRPC `.jar` artifacts |
| [android_proto_library](#android_proto_library) | Generates an Android protobuf library using `android_library` from `rules_android` |
| [android_grpc_library](#android_grpc_library) | Generates Android protobuf+gRPC library using `android_library` from `rules_android` |

---

## `android_proto_compile`

Generates an Android protobuf `.jar` artifact

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//android:repositories.bzl", rules_proto_grpc_android_repos = "android_repos")

rules_proto_grpc_android_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//android:defs.bzl", "android_proto_compile")

android_proto_compile(
    name = "person_android_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

android_proto_compile(
    name = "place_android_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

android_proto_compile(
    name = "thing_android_proto",
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

## `android_grpc_compile`

Generates Android protobuf+gRPC `.jar` artifacts

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//android:repositories.bzl", rules_proto_grpc_android_repos = "android_repos")

rules_proto_grpc_android_repos()

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@io_grpc_grpc_java//:repositories.bzl", "IO_GRPC_GRPC_JAVA_ARTIFACTS", "IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS", "grpc_java_repositories")

maven_install(
    artifacts = IO_GRPC_GRPC_JAVA_ARTIFACTS,
    generate_compat_repositories = True,
    override_targets = IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS,
    repositories = [
        "https://repo.maven.apache.org/maven2/",
    ],
)

load("@maven//:compat.bzl", "compat_repositories")

compat_repositories()

grpc_java_repositories()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//android:defs.bzl", "android_grpc_compile")

android_grpc_compile(
    name = "thing_android_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

android_grpc_compile(
    name = "greeter_android_grpc",
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

## `android_proto_library`

Generates an Android protobuf library using `android_library` from `rules_android`

### `WORKSPACE`

```starlark
# The set of dependencies loaded here is excessive for android proto alone
# (but simplifies our setup)
load("@rules_proto_grpc//android:repositories.bzl", rules_proto_grpc_android_repos = "android_repos")

rules_proto_grpc_android_repos()

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@io_grpc_grpc_java//:repositories.bzl", "IO_GRPC_GRPC_JAVA_ARTIFACTS", "IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS", "grpc_java_repositories")

maven_install(
    artifacts = IO_GRPC_GRPC_JAVA_ARTIFACTS,
    generate_compat_repositories = True,
    override_targets = IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS,
    repositories = [
        "https://repo.maven.apache.org/maven2/",
    ],
)

load("@maven//:compat.bzl", "compat_repositories")

compat_repositories()

grpc_java_repositories()

load("@build_bazel_rules_android//android:sdk_repository.bzl", "android_sdk_repository")

android_sdk_repository(name = "androidsdk")
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//android:defs.bzl", "android_proto_library")

android_proto_library(
    name = "person_android_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
    deps = ["place_android_proto"],
)

android_proto_library(
    name = "place_android_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
    deps = ["thing_android_proto"],
)

android_proto_library(
    name = "thing_android_proto",
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
| `exports` | `list` | false | `[]`    | List of labels to pass as exports attr to underlying lang_library rule          |

---

## `android_grpc_library`

Generates Android protobuf+gRPC library using `android_library` from `rules_android`

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//android:repositories.bzl", rules_proto_grpc_android_repos = "android_repos")

rules_proto_grpc_android_repos()

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@io_grpc_grpc_java//:repositories.bzl", "IO_GRPC_GRPC_JAVA_ARTIFACTS", "IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS", "grpc_java_repositories")

maven_install(
    artifacts = IO_GRPC_GRPC_JAVA_ARTIFACTS,
    generate_compat_repositories = True,
    override_targets = IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS,
    repositories = [
        "https://repo.maven.apache.org/maven2/",
    ],
)

load("@maven//:compat.bzl", "compat_repositories")

compat_repositories()

grpc_java_repositories()

load("@build_bazel_rules_android//android:sdk_repository.bzl", "android_sdk_repository")

android_sdk_repository(name = "androidsdk")
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//android:defs.bzl", "android_grpc_library")

android_grpc_library(
    name = "thing_android_grpc",
    protos = ["@rules_proto_grpc//example/proto:thing_proto"],
)

android_grpc_library(
    name = "greeter_android_grpc",
    protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
    deps = ["thing_android_grpc"],
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
| `exports` | `list` | false | `[]`    | List of labels to pass as exports attr to underlying lang_library rule          |
