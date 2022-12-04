:author: rules_proto_grpc
:description: rules_proto_grpc Bazel rules for Rust
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, Rust


Rust
====

Rules for generating Rust protobuf and gRPC ``.rs`` files and libraries using `rust-protobuf <https://github.com/stepancheg/rust-protobuf>`_ and `grpc <https://github.com/stepancheg/grpc-rust>`_. Libraries are created with ``rust_library`` from `rules_rust <https://github.com/bazelbuild/rules_rust>`_.

.. list-table:: Rules
   :widths: 1 2
   :header-rows: 1

   * - Rule
     - Description
   * - `rust_proto_compile`_
     - Generates Rust protobuf ``.rs`` files
   * - `rust_grpc_compile`_
     - Generates Rust protobuf and gRPC ``.rs`` files
   * - `rust_proto_library`_
     - Generates a Rust protobuf library using ``rust_library`` from ``rules_rust``
   * - `rust_grpc_library`_
     - Generates a Rust protobuf and gRPC library using ``rust_library`` from ``rules_rust``

.. _rust_proto_compile:

rust_proto_compile
------------------

Generates Rust protobuf ``.rs`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/rust/rust_proto_compile>`__

``WORKSPACE``
^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos = "rust_repos")
   
   rules_proto_grpc_rust_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()
   
   load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")
   
   rules_rust_dependencies()
   
   rust_register_toolchains(edition = "2021")

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

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

.. list-table:: Attributes for rust_proto_compile
   :widths: 1 1 1 1 4
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - ``protos``
     - ``label_list``
     - true
     - 
     - List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``rules_proto``)
   * - ``options``
     - ``string_list_dict``
     - false
     - ``[]``
     - Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins
   * - ``verbose``
     - ``int``
     - false
     - ``0``
     - The verbosity level. Supported values and results are 0: Show nothing, 1: Show command, 2: Show command and sandbox after running protoc, 3: Show command and sandbox before and after running protoc, 4. Show env, command, expected outputs and sandbox before and after running protoc
   * - ``prefix_path``
     - ``string``
     - false
     - ``""``
     - Path to prefix to the generated files in the output directory
   * - ``extra_protoc_args``
     - ``string_list``
     - false
     - ``[]``
     - A list of extra command line arguments to pass directly to protoc, not as plugin options
   * - ``extra_protoc_files``
     - ``label_list``
     - false
     - ``[]``
     - List of labels that provide extra files to be available during protoc execution
   * - ``output_mode``
     - ``string``
     - false
     - ``PREFIXED``
     - The output mode for the target. PREFIXED (the default) will output to a directory named by the target within the current package root, NO_PREFIX will output directly to the current package. Using NO_PREFIX may lead to conflicting writes

Plugins
*******

- `@rules_proto_grpc//rust:rust_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/rust/BUILD.bazel>`__

.. _rust_grpc_compile:

rust_grpc_compile
-----------------

Generates Rust protobuf and gRPC ``.rs`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/rust/rust_grpc_compile>`__

``WORKSPACE``
^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos = "rust_repos")
   
   rules_proto_grpc_rust_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()
   
   load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")
   
   rules_rust_dependencies()
   
   rust_register_toolchains(edition = "2021")

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

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

.. list-table:: Attributes for rust_grpc_compile
   :widths: 1 1 1 1 4
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - ``protos``
     - ``label_list``
     - true
     - 
     - List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``rules_proto``)
   * - ``options``
     - ``string_list_dict``
     - false
     - ``[]``
     - Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins
   * - ``verbose``
     - ``int``
     - false
     - ``0``
     - The verbosity level. Supported values and results are 0: Show nothing, 1: Show command, 2: Show command and sandbox after running protoc, 3: Show command and sandbox before and after running protoc, 4. Show env, command, expected outputs and sandbox before and after running protoc
   * - ``prefix_path``
     - ``string``
     - false
     - ``""``
     - Path to prefix to the generated files in the output directory
   * - ``extra_protoc_args``
     - ``string_list``
     - false
     - ``[]``
     - A list of extra command line arguments to pass directly to protoc, not as plugin options
   * - ``extra_protoc_files``
     - ``label_list``
     - false
     - ``[]``
     - List of labels that provide extra files to be available during protoc execution
   * - ``output_mode``
     - ``string``
     - false
     - ``PREFIXED``
     - The output mode for the target. PREFIXED (the default) will output to a directory named by the target within the current package root, NO_PREFIX will output directly to the current package. Using NO_PREFIX may lead to conflicting writes

Plugins
*******

- `@rules_proto_grpc//rust:rust_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/rust/BUILD.bazel>`__
- `@rules_proto_grpc//rust:grpc_rust_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/rust/BUILD.bazel>`__

.. _rust_proto_library:

rust_proto_library
------------------

Generates a Rust protobuf library using ``rust_library`` from ``rules_rust``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/rust/rust_proto_library>`__

``WORKSPACE``
^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos = "rust_repos")
   
   rules_proto_grpc_rust_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()
   
   load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")
   
   rules_rust_dependencies()
   
   rust_register_toolchains(edition = "2021")

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

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

.. list-table:: Attributes for rust_proto_library
   :widths: 1 1 1 1 4
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - ``protos``
     - ``label_list``
     - true
     - 
     - List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``rules_proto``)
   * - ``options``
     - ``string_list_dict``
     - false
     - ``[]``
     - Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins
   * - ``verbose``
     - ``int``
     - false
     - ``0``
     - The verbosity level. Supported values and results are 0: Show nothing, 1: Show command, 2: Show command and sandbox after running protoc, 3: Show command and sandbox before and after running protoc, 4. Show env, command, expected outputs and sandbox before and after running protoc
   * - ``prefix_path``
     - ``string``
     - false
     - ``""``
     - Path to prefix to the generated files in the output directory
   * - ``extra_protoc_args``
     - ``string_list``
     - false
     - ``[]``
     - A list of extra command line arguments to pass directly to protoc, not as plugin options
   * - ``extra_protoc_files``
     - ``label_list``
     - false
     - ``[]``
     - List of labels that provide extra files to be available during protoc execution
   * - ``output_mode``
     - ``string``
     - false
     - ``PREFIXED``
     - The output mode for the target. PREFIXED (the default) will output to a directory named by the target within the current package root, NO_PREFIX will output directly to the current package. Using NO_PREFIX may lead to conflicting writes
   * - ``deps``
     - ``label_list``
     - false
     - ``[]``
     - List of labels to pass as deps attr to underlying lang_library rule

.. _rust_grpc_library:

rust_grpc_library
-----------------

Generates a Rust protobuf and gRPC library using ``rust_library`` from ``rules_rust``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/rust/rust_grpc_library>`__

``WORKSPACE``
^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//rust:repositories.bzl", rules_proto_grpc_rust_repos = "rust_repos")
   
   rules_proto_grpc_rust_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()
   
   load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")
   
   rules_rust_dependencies()
   
   rust_register_toolchains(edition = "2021")

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

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

.. list-table:: Attributes for rust_grpc_library
   :widths: 1 1 1 1 4
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - ``protos``
     - ``label_list``
     - true
     - 
     - List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``rules_proto``)
   * - ``options``
     - ``string_list_dict``
     - false
     - ``[]``
     - Extra options to pass to plugins, as a dict of plugin label -> list of strings. The key * can be used exclusively to apply to all plugins
   * - ``verbose``
     - ``int``
     - false
     - ``0``
     - The verbosity level. Supported values and results are 0: Show nothing, 1: Show command, 2: Show command and sandbox after running protoc, 3: Show command and sandbox before and after running protoc, 4. Show env, command, expected outputs and sandbox before and after running protoc
   * - ``prefix_path``
     - ``string``
     - false
     - ``""``
     - Path to prefix to the generated files in the output directory
   * - ``extra_protoc_args``
     - ``string_list``
     - false
     - ``[]``
     - A list of extra command line arguments to pass directly to protoc, not as plugin options
   * - ``extra_protoc_files``
     - ``label_list``
     - false
     - ``[]``
     - List of labels that provide extra files to be available during protoc execution
   * - ``output_mode``
     - ``string``
     - false
     - ``PREFIXED``
     - The output mode for the target. PREFIXED (the default) will output to a directory named by the target within the current package root, NO_PREFIX will output directly to the current package. Using NO_PREFIX may lead to conflicting writes
   * - ``deps``
     - ``label_list``
     - false
     - ``[]``
     - List of labels to pass as deps attr to underlying lang_library rule
