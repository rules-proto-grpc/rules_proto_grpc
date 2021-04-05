Scala rules
===========

Rules for generating Scala protobuf and gRPC `.jar` files and libraries using [ScalaPB](https://github.com/scalapb/ScalaPB). Libraries are created with `scala_library` from [rules_scala](https://github.com/bazelbuild/rules_scala)

.. list-table:: Rules
   :widths: 1 1
   :header-rows: 1

   * - Rule
     - Description
   * - `scala_proto_compile <scala_proto_compile>`_
     - Generates a Scala protobuf `.jar` file
   * - `scala_grpc_compile <scala_grpc_compile>`_
     - Generates Scala protobuf and gRPC `.jar` file
   * - `scala_proto_library <scala_proto_library>`_
     - Generates a Scala protobuf library using `scala_library` from `rules_scala`
   * - `scala_grpc_library <scala_grpc_library>`_
     - Generates a Scala protobuf and gRPC library using `scala_library` from `rules_scala`

``scala_proto_compile``
-----------------------

Generates a Scala protobuf `.jar` file

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")
   
   rules_proto_grpc_scala_repos()
   
   load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")
   
   scala_config()
   
   load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
   
   scala_repositories()
   
   load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")
   
   scala_proto_repositories()
   
   load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
   
   scala_register_toolchains()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//scala:defs.bzl", "scala_proto_compile")
   
   scala_proto_compile(
       name = "person_scala_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
   )
   
   scala_proto_compile(
       name = "place_scala_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
   )
   
   scala_proto_compile(
       name = "thing_scala_proto",
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

- ``@rules_proto_grpc//scala:scala_plugin``

``scala_grpc_compile``
----------------------

Generates Scala protobuf and gRPC `.jar` file

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")
   
   rules_proto_grpc_scala_repos()
   
   load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")
   
   scala_config()
   
   load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
   
   scala_repositories()
   
   load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")
   
   scala_proto_repositories()
   
   load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
   
   scala_register_toolchains()
   
   load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")
   
   grpc_java_repositories()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//scala:defs.bzl", "scala_grpc_compile")
   
   scala_grpc_compile(
       name = "thing_scala_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   scala_grpc_compile(
       name = "greeter_scala_grpc",
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

- ``@rules_proto_grpc//scala:grpc_scala_plugin``

``scala_proto_library``
-----------------------

Generates a Scala protobuf library using `scala_library` from `rules_scala`

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")
   
   rules_proto_grpc_scala_repos()
   
   load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")
   
   scala_config()
   
   load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
   
   scala_repositories()
   
   load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")
   
   scala_proto_repositories()
   
   load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
   
   scala_register_toolchains()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//scala:defs.bzl", "scala_proto_library")
   
   scala_proto_library(
       name = "person_scala_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
       deps = ["place_scala_proto"],
   )
   
   scala_proto_library(
       name = "place_scala_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
       deps = ["thing_scala_proto"],
   )
   
   scala_proto_library(
       name = "thing_scala_proto",
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
   * - `deps`
     - `label_list`
     - false
     - `[]`
     - List of labels to pass as deps attr to underlying lang_library rule
   * - `exports`
     - `label_list`
     - false
     - `[]`
     - List of labels to pass as exports attr to underlying lang_library rule

``scala_grpc_library``
----------------------

Generates a Scala protobuf and gRPC library using `scala_library` from `rules_scala`

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")
   
   rules_proto_grpc_scala_repos()
   
   load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")
   
   scala_config()
   
   load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
   
   scala_repositories()
   
   load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")
   
   scala_proto_repositories()
   
   load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
   
   scala_register_toolchains()
   
   load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")
   
   grpc_java_repositories()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//scala:defs.bzl", "scala_grpc_library")
   
   scala_grpc_library(
       name = "thing_scala_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   scala_grpc_library(
       name = "greeter_scala_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
       deps = ["thing_scala_grpc"],
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
   * - `exports`
     - `label_list`
     - false
     - `[]`
     - List of labels to pass as exports attr to underlying lang_library rule
