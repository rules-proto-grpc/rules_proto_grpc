Java rules
==========

Rules for generating Java protobuf and gRPC ``.jar`` files and libraries using standard Protocol Buffers and `gRPC-Java <https://github.com/grpc/grpc-java>`_. Libraries are created with the Bazel native ``java_library``

.. list-table:: Rules
   :widths: 1 1
   :header-rows: 1

   * - Rule
     - Description
   * - `java_proto_compile <#java_proto_compile>`_
     - Generates a Java protobuf srcjar file
   * - `java_grpc_compile <#java_grpc_compile>`_
     - Generates a Java protobuf and gRPC srcjar file
   * - `java_proto_library <#java_proto_library>`_
     - Generates a Java protobuf library using ``java_library``
   * - `java_grpc_library <#java_grpc_library>`_
     - Generates a Java protobuf and gRPC library using ``java_library``

``java_proto_compile``
----------------------

Generates a Java protobuf srcjar file

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos = "java_repos")
   
   rules_proto_grpc_java_repos()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//java:defs.bzl", "java_proto_compile")
   
   java_proto_compile(
       name = "person_java_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
   )
   
   java_proto_compile(
       name = "place_java_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
   )
   
   java_proto_compile(
       name = "thing_java_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for java_proto_compile
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - ``protos``
     - ``label_list``
     - true
     - ````
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

- ``@rules_proto_grpc//java:java_plugin``

``java_grpc_compile``
---------------------

Generates a Java protobuf and gRPC srcjar file

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos = "java_repos")
   
   rules_proto_grpc_java_repos()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//java:defs.bzl", "java_grpc_compile")
   
   java_grpc_compile(
       name = "thing_java_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   java_grpc_compile(
       name = "greeter_java_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for java_grpc_compile
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - ``protos``
     - ``label_list``
     - true
     - ````
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

- ``@rules_proto_grpc//java:java_plugin``
- ``@rules_proto_grpc//java:grpc_java_plugin``

``java_proto_library``
----------------------

Generates a Java protobuf library using ``java_library``

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos = "java_repos")
   
   rules_proto_grpc_java_repos()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//java:defs.bzl", "java_proto_library")
   
   java_proto_library(
       name = "person_java_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
       deps = ["place_java_proto"],
   )
   
   java_proto_library(
       name = "place_java_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
       deps = ["thing_java_proto"],
   )
   
   java_proto_library(
       name = "thing_java_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for java_proto_library
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - ``protos``
     - ``label_list``
     - true
     - ````
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
   * - ``exports``
     - ``label_list``
     - false
     - ``[]``
     - List of labels to pass as exports attr to underlying lang_library rule

``java_grpc_library``
---------------------

Generates a Java protobuf and gRPC library using ``java_library``

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos = "java_repos")
   
   rules_proto_grpc_java_repos()
   
   load("@rules_jvm_external//:defs.bzl", "maven_install")
   load("@io_grpc_grpc_java//:repositories.bzl", "IO_GRPC_GRPC_JAVA_ARTIFACTS", "IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS", "grpc_java_repositories")
   
   maven_install(
       artifacts = IO_GRPC_GRPC_JAVA_ARTIFACTS,
       generate_compat_repositories = True,
       override_targets = IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS,
       repositories = [
           "https://repo.maven.apache.org/maven2/",
       ],
   )
   
   load("@maven//:compat.bzl", "compat_repositories")
   
   compat_repositories()
   
   grpc_java_repositories()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//java:defs.bzl", "java_grpc_library")
   
   java_grpc_library(
       name = "thing_java_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   java_grpc_library(
       name = "greeter_java_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
       deps = ["thing_java_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for java_grpc_library
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - ``protos``
     - ``label_list``
     - true
     - ````
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
   * - ``exports``
     - ``label_list``
     - false
     - ``[]``
     - List of labels to pass as exports attr to underlying lang_library rule
