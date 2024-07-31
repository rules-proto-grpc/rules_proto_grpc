:author: rules_proto_grpc
:description: rules_proto_grpc Bazel rules for Objective-C
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, Objective-C


Objective-C
===========

Rules for generating Objective-C protobuf and gRPC ``.m`` & ``.h`` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with the Bazel native ``objc_library``

.. list-table:: Rules
   :widths: 1 2
   :header-rows: 1

   * - Rule
     - Description
   * - `objc_proto_compile`_
     - Generates Objective-C protobuf ``.m`` & ``.h`` files
   * - `objc_grpc_compile`_
     - Generates Objective-C protobuf and gRPC ``.m`` & ``.h`` files
   * - `objc_proto_library`_
     - Generates an Objective-C protobuf library using ``objc_library``
   * - `objc_grpc_library`_
     - Generates an Objective-C protobuf and gRPC library using ``objc_library``

Installation
------------

The Objective-C module can be installed by adding the following lines to your MODULE.bazel file, replacing the version number placeholder with the desired version:

.. code-block:: python

   bazel_dep(name = "rules_proto_grpc_objc", version = "<version number here>")

.. _objc_proto_compile:

objc_proto_compile
------------------

Generates Objective-C protobuf ``.m`` & ``.h`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/objc/objc_proto_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_objc//:defs.bzl", "objc_proto_compile")
   
   objc_proto_compile(
       name = "person_objc_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
   )
   
   objc_proto_compile(
       name = "place_objc_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
   )
   
   objc_proto_compile(
       name = "thing_objc_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for objc_proto_compile
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

- `@rules_proto_grpc_objc//:proto_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/objc/BUILD.bazel>`__

.. _objc_grpc_compile:

objc_grpc_compile
-----------------

Generates Objective-C protobuf and gRPC ``.m`` & ``.h`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/objc/objc_grpc_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_objc//:defs.bzl", "objc_grpc_compile")
   
   objc_grpc_compile(
       name = "thing_objc_grpc",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )
   
   objc_grpc_compile(
       name = "greeter_objc_grpc",
       protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for objc_grpc_compile
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

- `@rules_proto_grpc_objc//:proto_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/objc/BUILD.bazel>`__
- `@rules_proto_grpc_objc//:grpc_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/objc/BUILD.bazel>`__

.. _objc_proto_library:

objc_proto_library
------------------

Generates an Objective-C protobuf library using ``objc_library``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/objc/objc_proto_library>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_objc//:defs.bzl", "objc_proto_library")
   
   objc_proto_library(
       name = "person_objc_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
       deps = ["place_objc_proto"],
   )
   
   objc_proto_library(
       name = "place_objc_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
       deps = ["thing_objc_proto"],
   )
   
   objc_proto_library(
       name = "thing_objc_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for objc_proto_library
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
   * - ``alwayslink``
     - ``bool``
     - false
     - ``None``
     - Passed to the ``alwayslink`` attribute of ``cc_library``.
   * - ``copts``
     - ``string_list``
     - false
     - ``None``
     - Passed to the ``opts`` attribute of ``cc_library``.
   * - ``defines``
     - ``string_list``
     - false
     - ``None``
     - Passed to the ``defines`` attribute of ``cc_library``.
   * - ``include_prefix``
     - ``string``
     - false
     - ``None``
     - Passed to the ``include_prefix`` attribute of ``cc_library``.
   * - ``linkopts``
     - ``string_list``
     - false
     - ``None``
     - Passed to the ``linkopts`` attribute of ``cc_library``.
   * - ``linkstatic``
     - ``bool``
     - false
     - ``None``
     - Passed to the ``linkstatic`` attribute of ``cc_library``.
   * - ``local_defines``
     - ``string_list``
     - false
     - ``None``
     - Passed to the ``local_defines`` attribute of ``cc_library``.
   * - ``nocopts``
     - ``string``
     - false
     - ``None``
     - Passed to the ``nocopts`` attribute of ``cc_library``.
   * - ``strip_include_prefix``
     - ``string``
     - false
     - ``None``
     - Passed to the ``strip_include_prefix`` attribute of ``cc_library``.

.. _objc_grpc_library:

objc_grpc_library
-----------------

.. warning:: This rule is experimental. It may not work correctly or may change in future releases!

Generates an Objective-C protobuf and gRPC library using ``objc_library``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/objc/objc_grpc_library>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_objc//:defs.bzl", "objc_grpc_library")
   
   objc_grpc_library(
       name = "thing_objc_grpc",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )
   
   objc_grpc_library(
       name = "greeter_objc_grpc",
       protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
       deps = ["thing_objc_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for objc_grpc_library
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
   * - ``alwayslink``
     - ``bool``
     - false
     - ``None``
     - Passed to the ``alwayslink`` attribute of ``cc_library``.
   * - ``copts``
     - ``string_list``
     - false
     - ``None``
     - Passed to the ``opts`` attribute of ``cc_library``.
   * - ``defines``
     - ``string_list``
     - false
     - ``None``
     - Passed to the ``defines`` attribute of ``cc_library``.
   * - ``include_prefix``
     - ``string``
     - false
     - ``None``
     - Passed to the ``include_prefix`` attribute of ``cc_library``.
   * - ``linkopts``
     - ``string_list``
     - false
     - ``None``
     - Passed to the ``linkopts`` attribute of ``cc_library``.
   * - ``linkstatic``
     - ``bool``
     - false
     - ``None``
     - Passed to the ``linkstatic`` attribute of ``cc_library``.
   * - ``local_defines``
     - ``string_list``
     - false
     - ``None``
     - Passed to the ``local_defines`` attribute of ``cc_library``.
   * - ``nocopts``
     - ``string``
     - false
     - ``None``
     - Passed to the ``nocopts`` attribute of ``cc_library``.
   * - ``strip_include_prefix``
     - ``string``
     - false
     - ``None``
     - Passed to the ``strip_include_prefix`` attribute of ``cc_library``.
