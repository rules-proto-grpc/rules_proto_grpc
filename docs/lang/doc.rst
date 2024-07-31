:author: rules_proto_grpc
:description: rules_proto_grpc Bazel rules for Documentation
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, Documentation


Documentation
=============

Rules for generating protobuf Markdown, JSON, HTML or DocBook documentation with `protoc-gen-doc <https://github.com/pseudomuto/protoc-gen-doc>`_

.. list-table:: Rules
   :widths: 1 2
   :header-rows: 1

   * - Rule
     - Description
   * - `doc_docbook_compile`_
     - Generates DocBook ``.xml`` documentation file
   * - `doc_html_compile`_
     - Generates ``.html`` documentation file
   * - `doc_json_compile`_
     - Generates ``.json`` documentation file
   * - `doc_markdown_compile`_
     - Generates Markdown ``.md`` documentation file
   * - `doc_template_compile`_
     - Generates documentation file using Go template file

Installation
------------

The Documentation module can be installed by adding the following lines to your MODULE.bazel file, replacing the version number placeholder with the desired version:

.. code-block:: python

   bazel_dep(name = "rules_proto_grpc_doc", version = "<version number here>")

.. _doc_docbook_compile:

doc_docbook_compile
-------------------

Generates DocBook ``.xml`` documentation file

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/doc/doc_docbook_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_doc//:defs.bzl", "doc_docbook_compile")
   
   doc_docbook_compile(
       name = "person_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
   )
   
   doc_docbook_compile(
       name = "place_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
   )
   
   doc_docbook_compile(
       name = "thing_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for doc_docbook_compile
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

- `@rules_proto_grpc_doc//:docbook_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/doc/BUILD.bazel>`__

.. _doc_html_compile:

doc_html_compile
----------------

Generates ``.html`` documentation file

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/doc/doc_html_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_doc//:defs.bzl", "doc_html_compile")
   
   doc_html_compile(
       name = "person_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
   )
   
   doc_html_compile(
       name = "place_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
   )
   
   doc_html_compile(
       name = "thing_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for doc_html_compile
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

- `@rules_proto_grpc_doc//:html_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/doc/BUILD.bazel>`__

.. _doc_json_compile:

doc_json_compile
----------------

Generates ``.json`` documentation file

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/doc/doc_json_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_doc//:defs.bzl", "doc_json_compile")
   
   doc_json_compile(
       name = "person_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
   )
   
   doc_json_compile(
       name = "place_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
   )
   
   doc_json_compile(
       name = "thing_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for doc_json_compile
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

- `@rules_proto_grpc_doc//:json_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/doc/BUILD.bazel>`__

.. _doc_markdown_compile:

doc_markdown_compile
--------------------

Generates Markdown ``.md`` documentation file

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/doc/doc_markdown_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_doc//:defs.bzl", "doc_markdown_compile")
   
   doc_markdown_compile(
       name = "person_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:person_proto"],
   )
   
   doc_markdown_compile(
       name = "place_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:place_proto"],
   )
   
   doc_markdown_compile(
       name = "thing_doc_proto",
       protos = ["@rules_proto_grpc_example_protos//:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for doc_markdown_compile
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

- `@rules_proto_grpc_doc//:markdown_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/doc/BUILD.bazel>`__

.. _doc_template_compile:

doc_template_compile
--------------------

.. warning:: This rule is experimental. It may not work correctly or may change in future releases!

Generates documentation file using Go template file

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/doc/doc_template_compile>`__

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc_doc//:defs.bzl", "doc_template_compile")
   
   doc_template_compile(
       name = "greeter_doc_proto.txt",
       output_mode = "NO_PREFIX",
       protos = [
           "@rules_proto_grpc_example_protos//:greeter_grpc",
           "@rules_proto_grpc_example_protos//:thing_proto",
       ],
       template = "template.txt",
   )

Attributes
**********

.. list-table:: Attributes for doc_template_compile
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
   * - ``template``
     - ``label``
     - true
     - ``None``
     - The documentation template file.

Plugins
*******

- `@rules_proto_grpc_doc//:template_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/doc/BUILD.bazel>`__
