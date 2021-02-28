# Documentation rules

Rules for generating protobuf Markdown, JSON, HTML or DocBook documentation with [protoc-gen-doc](https://github.com/pseudomuto/protoc-gen-doc)

| Rule | Description |
| ---: | :--- |
| [doc_docbook_compile](#doc_docbook_compile) | Generates DocBook `.xml` documentation file |
| [doc_html_compile](#doc_html_compile) | Generates `.html` documentation file |
| [doc_json_compile](#doc_json_compile) | Generates `.json` documentation file |
| [doc_markdown_compile](#doc_markdown_compile) | Generates Markdown `.md` documentation file |

---

## `doc_docbook_compile`

Generates DocBook `.xml` documentation file

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")

rules_proto_grpc_doc_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//doc:defs.bzl", "doc_docbook_compile")

doc_docbook_compile(
    name = "person_doc_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

doc_docbook_compile(
    name = "place_doc_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

doc_docbook_compile(
    name = "thing_doc_proto",
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

- `@rules_proto_grpc//doc:docbook_plugin`

---

## `doc_html_compile`

Generates `.html` documentation file

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")

rules_proto_grpc_doc_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//doc:defs.bzl", "doc_html_compile")

doc_html_compile(
    name = "person_doc_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

doc_html_compile(
    name = "place_doc_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

doc_html_compile(
    name = "thing_doc_proto",
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

- `@rules_proto_grpc//doc:html_plugin`

---

## `doc_json_compile`

Generates `.json` documentation file

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")

rules_proto_grpc_doc_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//doc:defs.bzl", "doc_json_compile")

doc_json_compile(
    name = "person_doc_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

doc_json_compile(
    name = "place_doc_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

doc_json_compile(
    name = "thing_doc_proto",
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

- `@rules_proto_grpc//doc:json_plugin`

---

## `doc_markdown_compile`

Generates Markdown `.md` documentation file

### `WORKSPACE`

```starlark
load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")

rules_proto_grpc_doc_repos()
```

### `BUILD.bazel`

```starlark
load("@rules_proto_grpc//doc:defs.bzl", "doc_markdown_compile")

doc_markdown_compile(
    name = "person_doc_proto",
    protos = ["@rules_proto_grpc//example/proto:person_proto"],
)

doc_markdown_compile(
    name = "place_doc_proto",
    protos = ["@rules_proto_grpc//example/proto:place_proto"],
)

doc_markdown_compile(
    name = "thing_doc_proto",
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

- `@rules_proto_grpc//doc:markdown_plugin`
