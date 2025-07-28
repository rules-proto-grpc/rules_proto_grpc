:author: rules_proto_grpc
:description: rules_proto_grpc Bazel rules for JavaScript
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, JavaScript


JavaScript
==========

Rules for generating JavaScript protobuf, gRPC-js and gRPC-Web ``.js`` and ``.d.ts`` files using standard Protocol Buffers and gRPC.

.. list-table:: Rules
   :widths: 1 2
   :header-rows: 1

   * - Rule
     - Description
   * - `js_proto_compile`_
     - Generates JavaScript protobuf ``.js`` and ``.d.ts`` files
   * - `js_grpc_compile`_
     - Generates JavaScript protobuf and gRPC-js ``.js`` and ``.d.ts`` files
   * - `js_grpc_web_compile`_
     - Generates JavaScript protobuf and gRPC-Web ``.js`` and ``.d.ts`` files
   * - `js_proto_library`_
     - Generates a JavaScript protobuf library using ``js_library`` from ``aspect_rules_js``
   * - `js_grpc_library`_
     - Generates a Node.js protobuf + gRPC-js library using ``js_library`` from ``aspect_rules_js``
   * - `js_grpc_web_library`_
     - Generates a JavaScript protobuf + gRPC-Web library using ``js_library`` from ``aspect_rules_js``

Installation
------------

The JavaScript module can be installed by adding the following lines to your MODULE.bazel file, replacing the version number placeholder with the desired version:

.. code-block:: python

   bazel_dep(name = "rules_proto_grpc_js", version = "<version number here>")
   bazel_dep(name = "aspect_rules_js", version = "2.4.1")
   
   # Allow npm_link_all_packages of rules_proto_grpc_js_npm from rules_proto_grpc_js
   npm = use_extension("@aspect_rules_js//npm:extensions.bzl", "npm")
   use_repo(npm, "rules_proto_grpc_js_npm")

.. _js_proto_compile:

js_proto_compile
----------------

Generates JavaScript protobuf ``.js`` and ``.d.ts`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/js/js_proto_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_js//:defs.bzl", "js_proto_compile")
   
   js_proto_compile(
       name = "person_js_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
   )
   
   js_proto_compile(
       name = "place_js_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
   )
   
   js_proto_compile(
       name = "thing_js_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for js_proto_compile
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

- `@rules_proto_grpc_js//:proto_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__
- `@rules_proto_grpc_js//:proto_ts_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__

.. _js_grpc_compile:

js_grpc_compile
---------------

Generates JavaScript protobuf and gRPC-js ``.js`` and ``.d.ts`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/js/js_grpc_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_js//:defs.bzl", "js_grpc_compile")
   
   js_grpc_compile(
       name = "thing_js_grpc",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )
   
   js_grpc_compile(
       name = "greeter_js_grpc",
       protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for js_grpc_compile
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

- `@rules_proto_grpc_js//:proto_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__
- `@rules_proto_grpc_js//:proto_ts_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__
- `@rules_proto_grpc_js//:grpc_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__
- `@rules_proto_grpc_js//:grpc_ts_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__

.. _js_grpc_web_compile:

js_grpc_web_compile
-------------------

Generates JavaScript protobuf and gRPC-Web ``.js`` and ``.d.ts`` files

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/js/js_grpc_web_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_js//:defs.bzl", "js_grpc_web_compile")
   
   js_grpc_web_compile(
       name = "thing_js_grpc",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )
   
   js_grpc_web_compile(
       name = "greeter_js_grpc",
       protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for js_grpc_web_compile
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

- `@rules_proto_grpc_js//:proto_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__
- `@rules_proto_grpc_js//:proto_ts_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__
- `@rules_proto_grpc_js//:grpc_web_js_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/js/BUILD.bazel>`__

.. _js_proto_library:

js_proto_library
----------------

Generates a JavaScript protobuf library using ``js_library`` from ``aspect_rules_js``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/js/js_proto_library>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_js//:defs.bzl", "js_proto_library")
   load("@rules_proto_grpc_js_npm//:defs.bzl", "npm_link_all_packages")
   
   npm_link_all_packages(name = "node_modules")
   
   js_proto_library(
       name = "person_js_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
       deps = ["place_js_proto"],
   )
   
   js_proto_library(
       name = "place_js_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
       deps = ["thing_js_proto"],
   )
   
   js_proto_library(
       name = "thing_js_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for js_proto_library
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

.. _js_grpc_library:

js_grpc_library
---------------

Generates a Node.js protobuf + gRPC-js library using ``js_library`` from ``aspect_rules_js``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/js/js_grpc_library>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_js//:defs.bzl", "js_grpc_library")
   load("@rules_proto_grpc_js_npm//:defs.bzl", "npm_link_all_packages")
   
   npm_link_all_packages(name = "node_modules")
   
   js_grpc_library(
       name = "thing_js_grpc",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )
   
   js_grpc_library(
       name = "greeter_js_grpc",
       protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
       deps = ["thing_js_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for js_grpc_library
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

.. _js_grpc_web_library:

js_grpc_web_library
-------------------

Generates a JavaScript protobuf + gRPC-Web library using ``js_library`` from ``aspect_rules_js``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/js/js_grpc_web_library>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_js//:defs.bzl", "js_grpc_web_library")
   load("@rules_proto_grpc_js_npm//:defs.bzl", "npm_link_all_packages")
   
   npm_link_all_packages(name = "node_modules")
   
   js_grpc_web_library(
       name = "thing_js_grpc",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )
   
   js_grpc_web_library(
       name = "greeter_js_grpc",
       protos = ["@rules_proto_grpc_example_protos//:greeter_grpc"],
       deps = ["thing_js_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for js_grpc_web_library
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
