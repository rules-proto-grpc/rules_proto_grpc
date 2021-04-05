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

.. _doc_docbook_compile:

doc_docbook_compile
-------------------

**Note**: This rule is experimental. It may not work correctly!

Generates DocBook ``.xml`` documentation file

``WORKSPACE``
*************

.. code-block:: python

   load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")
   
   rules_proto_grpc_doc_repos()

``BUILD.bazel``
***************

.. code-block:: python

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
     - The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*
   * - ``prefix_path``
     - ``string``
     - false
     - ``""``
     - Path to prefix to the generated files in the output directory
   * - ``extra_protoc_args``
     - ``string_list``
     - false
     - ``[]``
     - A list of extra args to pass directly to protoc, not as plugin options

Plugins
*******

- ``@rules_proto_grpc//doc:docbook_plugin``

.. _doc_html_compile:

doc_html_compile
----------------

**Note**: This rule is experimental. It may not work correctly!

Generates ``.html`` documentation file

``WORKSPACE``
*************

.. code-block:: python

   load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")
   
   rules_proto_grpc_doc_repos()

``BUILD.bazel``
***************

.. code-block:: python

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
     - The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*
   * - ``prefix_path``
     - ``string``
     - false
     - ``""``
     - Path to prefix to the generated files in the output directory
   * - ``extra_protoc_args``
     - ``string_list``
     - false
     - ``[]``
     - A list of extra args to pass directly to protoc, not as plugin options

Plugins
*******

- ``@rules_proto_grpc//doc:html_plugin``

.. _doc_json_compile:

doc_json_compile
----------------

**Note**: This rule is experimental. It may not work correctly!

Generates ``.json`` documentation file

``WORKSPACE``
*************

.. code-block:: python

   load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")
   
   rules_proto_grpc_doc_repos()

``BUILD.bazel``
***************

.. code-block:: python

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
     - The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*
   * - ``prefix_path``
     - ``string``
     - false
     - ``""``
     - Path to prefix to the generated files in the output directory
   * - ``extra_protoc_args``
     - ``string_list``
     - false
     - ``[]``
     - A list of extra args to pass directly to protoc, not as plugin options

Plugins
*******

- ``@rules_proto_grpc//doc:json_plugin``

.. _doc_markdown_compile:

doc_markdown_compile
--------------------

**Note**: This rule is experimental. It may not work correctly!

Generates Markdown ``.md`` documentation file

``WORKSPACE``
*************

.. code-block:: python

   load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")
   
   rules_proto_grpc_doc_repos()

``BUILD.bazel``
***************

.. code-block:: python

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
     - The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*
   * - ``prefix_path``
     - ``string``
     - false
     - ``""``
     - Path to prefix to the generated files in the output directory
   * - ``extra_protoc_args``
     - ``string_list``
     - false
     - ``[]``
     - A list of extra args to pass directly to protoc, not as plugin options

Plugins
*******

- ``@rules_proto_grpc//doc:markdown_plugin``
