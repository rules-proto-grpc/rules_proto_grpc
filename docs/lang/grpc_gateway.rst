:author: rules_proto_grpc
:description: rules_proto_grpc Bazel rules for gRPC-Gateway
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, gRPC-Gateway


gRPC-Gateway
============

.. list-table:: Rules
   :widths: 1 2
   :header-rows: 1

   * - Rule
     - Description
   * - `gateway_grpc_compile`_
     - Generates gRPC-Gateway ``.go`` files
   * - `gateway_openapiv2_compile`_
     - Generates gRPC-Gateway OpenAPI v2 ``.json`` files
   * - `gateway_grpc_library`_
     - Generates gRPC-Gateway library files

Installation
------------

The gRPC-Gateway module can be installed by adding the following lines to your MODULE.bazel file, replacing the version number placeholder with the desired version:

.. code-block:: python

   bazel_dep(name = "rules_proto_grpc_grpc_gateway", version = "<version number here>")

.. _gateway_grpc_compile:

gateway_grpc_compile
--------------------

Generates gRPC-Gateway ``.go`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/grpc_gateway/gateway_grpc_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_grpc_gateway//:defs.bzl", "gateway_grpc_compile")
   
   gateway_grpc_compile(
       name = "api_gateway_grpc",
       protos = ["@rules_proto_grpc_example_protos//:api_proto"],
   )

Attributes
**********

.. list-table:: Attributes for gateway_grpc_compile
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

- `@rules_proto_grpc_grpc_gateway//:plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/grpc_gateway/BUILD.bazel>`__
- `@rules_proto_grpc_grpc_gateway@rules_proto_grpc_go//:grpc_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/grpc_gateway/BUILD.bazel>`__
- `@rules_proto_grpc_grpc_gateway@rules_proto_grpc_go//:proto_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/grpc_gateway/BUILD.bazel>`__

.. _gateway_openapiv2_compile:

gateway_openapiv2_compile
-------------------------

Generates gRPC-Gateway OpenAPI v2 ``.json`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/grpc_gateway/gateway_openapiv2_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_grpc_gateway//:defs.bzl", "gateway_openapiv2_compile")
   
   gateway_openapiv2_compile(
       name = "api_gateway_grpc",
       protos = ["@rules_proto_grpc_example_protos//:api_proto"],
   )

Attributes
**********

.. list-table:: Attributes for gateway_openapiv2_compile
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

- `@rules_proto_grpc_grpc_gateway//:openapiv2_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/grpc_gateway/BUILD.bazel>`__

.. _gateway_grpc_library:

gateway_grpc_library
--------------------

Generates gRPC-Gateway library files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/grpc_gateway/gateway_grpc_library>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_grpc_gateway//:defs.bzl", "gateway_grpc_library")
   
   gateway_grpc_library(
       name = "api_gateway_library",
       importpath = "github.com/rules-proto-grpc/rules_proto_grpc/grpc-gateway/examples/api",
       protos = ["@rules_proto_grpc_example_protos//:api_proto"],
   )

Attributes
**********

.. list-table:: Attributes for gateway_grpc_library
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
   * - ``importpath``
     - ``string``
     - false
     - ``None``
     - Importpath for the generated files
