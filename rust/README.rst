Rust rules
==========

Rules for generating Rust protobuf and gRPC `.rs` files and libraries using [rust-protobuf](https://github.com/stepancheg/rust-protobuf) and [grpc-rs](https://github.com/tikv/grpc-rs). Libraries are created with `rust_library` from [rules_rust](https://github.com/bazelbuild/rules_rust).

.. list-table:: Rules
   :widths: 1 1
   :header-rows: 1

   * - Rule
     - Description
   * - `rust_proto_compile <rust_proto_compile>`_
     - Generates Rust protobuf `.rs` files
   * - `rust_grpc_compile <rust_grpc_compile>`_
     - Generates Rust protobuf and gRPC `.rs` files
   * - `rust_proto_library <rust_proto_library>`_
     - Generates a Rust protobuf library using `rust_library` from `rules_rust`
   * - `rust_grpc_library <rust_grpc_library>`_
     - Generates a Rust protobuf and gRPC library using `rust_library` from `rules_rust`

``rust_proto_compile``
----------------------

Generates Rust protobuf `.rs` files

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos = "rust_repos")
   
   rules_proto_grpc_rust_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()
   
   load("@rules_rust//rust:repositories.bzl", "rust_repositories")
   
   rust_repositories()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//rust:defs.bzl", "rust_proto_compile")
   
   rust_proto_compile(
       name = "person_rust_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
   )
   
   rust_proto_compile(
       name = "place_rust_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
   )
   
   rust_proto_compile(
       name = "thing_rust_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Rules
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - `protos`
     - `label_list`
     - true
     - ``
     - List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)
   * - `options`
     - `string_list_dict`
     - false
     - `[]`
     - Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins
   * - `verbose`
     - `int`
     - false
     - `0`
     - The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*
   * - `prefix_path`
     - `string`
     - false
     - `""`
     - Path to prefix to the generated files in the output directory
   * - `extra_protoc_args`
     - `string_list`
     - false
     - `[]`
     - A list of extra args to pass directly to protoc, not as plugin options

Plugins
*******

- ``@rules_proto_grpc//rust:rust_plugin``

``rust_grpc_compile``
---------------------

Generates Rust protobuf and gRPC `.rs` files

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos = "rust_repos")
   
   rules_proto_grpc_rust_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()
   
   load("@rules_rust//rust:repositories.bzl", "rust_repositories")
   
   rust_repositories()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//rust:defs.bzl", "rust_grpc_compile")
   
   rust_grpc_compile(
       name = "thing_rust_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   rust_grpc_compile(
       name = "greeter_rust_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Rules
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - `protos`
     - `label_list`
     - true
     - ``
     - List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)
   * - `options`
     - `string_list_dict`
     - false
     - `[]`
     - Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins
   * - `verbose`
     - `int`
     - false
     - `0`
     - The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*
   * - `prefix_path`
     - `string`
     - false
     - `""`
     - Path to prefix to the generated files in the output directory
   * - `extra_protoc_args`
     - `string_list`
     - false
     - `[]`
     - A list of extra args to pass directly to protoc, not as plugin options

Plugins
*******

- ``@rules_proto_grpc//rust:rust_plugin``
- ``@rules_proto_grpc//rust:grpc_rust_plugin``

``rust_proto_library``
----------------------

Generates a Rust protobuf library using `rust_library` from `rules_rust`

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos = "rust_repos")
   
   rules_proto_grpc_rust_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()
   
   load("@rules_rust//rust:repositories.bzl", "rust_repositories")
   
   rust_repositories()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//rust:defs.bzl", "rust_proto_library")
   
   rust_proto_library(
       name = "proto_rust_proto",
       protos = [
           "@rules_proto_grpc//example/proto:person_proto",
           "@rules_proto_grpc//example/proto:place_proto",
           "@rules_proto_grpc//example/proto:thing_proto",
       ],
   )

Attributes
**********

.. list-table:: Rules
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - `protos`
     - `label_list`
     - true
     - ``
     - List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)
   * - `options`
     - `string_list_dict`
     - false
     - `[]`
     - Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins
   * - `verbose`
     - `int`
     - false
     - `0`
     - The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*
   * - `prefix_path`
     - `string`
     - false
     - `""`
     - Path to prefix to the generated files in the output directory
   * - `extra_protoc_args`
     - `string_list`
     - false
     - `[]`
     - A list of extra args to pass directly to protoc, not as plugin options
   * - `deps`
     - `label_list`
     - false
     - `[]`
     - List of labels to pass as deps attr to underlying lang_library rule

``rust_grpc_library``
---------------------

Generates a Rust protobuf and gRPC library using `rust_library` from `rules_rust`

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos = "rust_repos")
   
   rules_proto_grpc_rust_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()
   
   load("@rules_rust//rust:repositories.bzl", "rust_repositories")
   
   rust_repositories()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//rust:defs.bzl", "rust_grpc_library")
   
   rust_grpc_library(
       name = "greeter_rust_grpc",
       protos = [
           "@rules_proto_grpc//example/proto:greeter_grpc",
           "@rules_proto_grpc//example/proto:thing_proto",
       ],
   )

Attributes
**********

.. list-table:: Rules
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - `protos`
     - `label_list`
     - true
     - ``
     - List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)
   * - `options`
     - `string_list_dict`
     - false
     - `[]`
     - Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins
   * - `verbose`
     - `int`
     - false
     - `0`
     - The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*
   * - `prefix_path`
     - `string`
     - false
     - `""`
     - Path to prefix to the generated files in the output directory
   * - `extra_protoc_args`
     - `string_list`
     - false
     - `[]`
     - A list of extra args to pass directly to protoc, not as plugin options
   * - `deps`
     - `label_list`
     - false
     - `[]`
     - List of labels to pass as deps attr to underlying lang_library rule
