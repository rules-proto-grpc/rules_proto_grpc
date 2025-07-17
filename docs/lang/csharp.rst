:author: rules_proto_grpc
:description: rules_proto_grpc Bazel rules for C#
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, C#


C#
==

Rules for generating C# protobuf and gRPC ``.cs`` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with ``csharp_library`` from `rules_dotnet <https://github.com/bazel-contrib/rules_dotnet>`_

.. list-table:: Rules
   :widths: 1 2
   :header-rows: 1

   * - Rule
     - Description
   * - `csharp_proto_compile`_
     - Generates C# protobuf ``.cs`` files
   * - `csharp_grpc_compile`_
     - Generates C# protobuf and gRPC ``.cs`` files
   * - `csharp_proto_library`_
     - Generates a C# protobuf library using ``csharp_library`` from ``rules_dotnet``
   * - `csharp_grpc_library`_
     - Generates a C# protobuf and gRPC library using ``csharp_library`` from ``rules_dotnet``

Installation
------------

The C# module can be installed by adding the following lines to your MODULE.bazel file, replacing the version number placeholder with the desired version:

.. code-block:: python

   bazel_dep(name = "rules_proto_grpc_csharp", version = "<version number here>")

.. _csharp_proto_compile:

csharp_proto_compile
--------------------

Generates C# protobuf ``.cs`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/csharp/csharp_proto_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_csharp//:defs.bzl", "csharp_proto_compile")
   
   csharp_proto_compile(
       name = "person_csharp_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
   )
   
   csharp_proto_compile(
       name = "place_csharp_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
   )
   
   csharp_proto_compile(
       name = "thing_csharp_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for csharp_proto_compile
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
     - List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``@protobuf``)
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

- `@rules_proto_grpc_csharp//:proto_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/csharp/BUILD.bazel>`__

.. _csharp_grpc_compile:

csharp_grpc_compile
-------------------

Generates C# protobuf and gRPC ``.cs`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/csharp/csharp_grpc_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_csharp//:defs.bzl", "csharp_grpc_compile")
   
   csharp_grpc_compile(
       name = "thing_csharp_grpc",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )
   
   csharp_grpc_compile(
       name = "greeter_csharp_grpc",
       protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for csharp_grpc_compile
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
     - List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``@protobuf``)
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

- `@rules_proto_grpc_csharp//:proto_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/csharp/BUILD.bazel>`__
- `@rules_proto_grpc_csharp//:grpc_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/csharp/BUILD.bazel>`__

.. _csharp_proto_library:

csharp_proto_library
--------------------

Generates a C# protobuf library using ``csharp_library`` from ``rules_dotnet``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/csharp/csharp_proto_library>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_csharp//:defs.bzl", "csharp_proto_library")
   
   csharp_proto_library(
       name = "person_csharp_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
       deps = ["place_csharp_proto"],
   )
   
   csharp_proto_library(
       name = "place_csharp_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
       deps = ["thing_csharp_proto"],
   )
   
   csharp_proto_library(
       name = "thing_csharp_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for csharp_proto_library
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
     - List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``@protobuf``)
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

.. _csharp_grpc_library:

csharp_grpc_library
-------------------

Generates a C# protobuf and gRPC library using ``csharp_library`` from ``rules_dotnet``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/csharp/csharp_grpc_library>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_csharp//:defs.bzl", "csharp_grpc_library")
   
   csharp_grpc_library(
       name = "thing_csharp_grpc",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )
   
   csharp_grpc_library(
       name = "greeter_csharp_grpc",
       protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
       deps = ["thing_csharp_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for csharp_grpc_library
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
     - List of labels that provide the ``ProtoInfo`` provider (such as ``proto_library`` from ``@protobuf``)
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
