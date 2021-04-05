:author: rules_proto_grpc
:description: rules_proto_grpc Bazel rules for C++
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, C++


C++
===

Rules for generating C++ protobuf and gRPC ``.cc`` & ``.h`` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with the Bazel native ``cc_library``

.. list-table:: Rules
   :widths: 1 2
   :header-rows: 1

   * - Rule
     - Description
   * - `cpp_proto_compile <#cpp_proto_compile>`_
     - Generates C++ protobuf ``.h`` & ``.cc`` files
   * - `cpp_grpc_compile <#cpp_grpc_compile>`_
     - Generates C++ protobuf and gRPC ``.h`` & ``.cc`` files
   * - `cpp_proto_library <#cpp_proto_library>`_
     - Generates a C++ protobuf library using ``cc_library``, with dependencies linked
   * - `cpp_grpc_library <#cpp_grpc_library>`_
     - Generates a C++ protobuf and gRPC library using ``cc_library``, with dependencies linked

cpp_proto_compile
-----------------

Generates C++ protobuf ``.h`` & ``.cc`` files

``WORKSPACE``
*************

.. code-block:: python

   load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")
   
   rules_proto_grpc_cpp_repos()

``BUILD.bazel``
***************

.. code-block:: python

   load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_compile")
   
   cpp_proto_compile(
       name = "person_cpp_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
   )
   
   cpp_proto_compile(
       name = "place_cpp_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
   )
   
   cpp_proto_compile(
       name = "thing_cpp_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for cpp_proto_compile
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

- ``@rules_proto_grpc//cpp:cpp_plugin``

cpp_grpc_compile
----------------

Generates C++ protobuf and gRPC ``.h`` & ``.cc`` files

``WORKSPACE``
*************

.. code-block:: python

   load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")
   
   rules_proto_grpc_cpp_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()

``BUILD.bazel``
***************

.. code-block:: python

   load("@rules_proto_grpc//cpp:defs.bzl", "cpp_grpc_compile")
   
   cpp_grpc_compile(
       name = "thing_cpp_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   cpp_grpc_compile(
       name = "greeter_cpp_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for cpp_grpc_compile
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

- ``@rules_proto_grpc//cpp:cpp_plugin``
- ``@rules_proto_grpc//cpp:grpc_cpp_plugin``

cpp_proto_library
-----------------

Generates a C++ protobuf library using ``cc_library``, with dependencies linked

``WORKSPACE``
*************

.. code-block:: python

   load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")
   
   rules_proto_grpc_cpp_repos()

``BUILD.bazel``
***************

.. code-block:: python

   load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_library")
   
   cpp_proto_library(
       name = "person_cpp_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
       deps = ["place_cpp_proto"],
   )
   
   cpp_proto_library(
       name = "place_cpp_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
       deps = ["thing_cpp_proto"],
   )
   
   cpp_proto_library(
       name = "thing_cpp_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for cpp_proto_library
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

cpp_grpc_library
----------------

Generates a C++ protobuf and gRPC library using ``cc_library``, with dependencies linked

``WORKSPACE``
*************

.. code-block:: python

   load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")
   
   rules_proto_grpc_cpp_repos()
   
   load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
   
   grpc_deps()

``BUILD.bazel``
***************

.. code-block:: python

   load("@rules_proto_grpc//cpp:defs.bzl", "cpp_grpc_library")
   
   cpp_grpc_library(
       name = "thing_cpp_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   cpp_grpc_library(
       name = "greeter_cpp_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
       deps = ["thing_cpp_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for cpp_grpc_library
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
