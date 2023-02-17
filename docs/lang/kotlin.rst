:author: rules_proto_grpc
:description: rules_proto_grpc Bazel rules for Kotlin
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, Kotlin


Kotlin
======

Rules for generating Kotlin protobuf and gRPC ``.jar`` files and libraries using standard Protocol Buffers, `gRPC-Java <https://github.com/grpc/grpc-java>` and `gRPC-Kotlin <https://github.com/grpc/grpc-kotlin>`_. Libraries are created with the `rules_kotlin <https://github.com/bazelbuild/rules_kotlin>` kt_jvm_library``

.. list-table:: Rules
   :widths: 1 2
   :header-rows: 1

   * - Rule
     - Description
   * - `kotlin_proto_compile`_
     - Generates a Kotlin (JVM) protobuf srcjar file
   * - `kotlin_grpc_compile`_
     - Generates a Kotlin (JVM) protobuf and gRPC srcjar file
   * - `kotlin_proto_library`_
     - Generates a Kotlin (JVM) protobuf library using ``kt_jvm_library``
   * - `kotlin_grpc_library`_
     - Generates a Kotlin (JVM) protobuf and gRPC library using ``kt_jvm_library``

.. _kotlin_proto_compile:

kotlin_proto_compile
--------------------

Generates a Kotlin (JVM) protobuf srcjar file

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/kotlin/kotlin_proto_compile>`__

``WORKSPACE``
^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//kotlin:repositories.bzl", rules_proto_grpc_kotlin_repos = "kotlin_repos")
   
   rules_proto_grpc_kotlin_repos()

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//kotlin:defs.bzl", "kotlin_proto_compile")
   
   kotlin_proto_compile(
       name = "person_kotlin_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
   )
   
   kotlin_proto_compile(
       name = "place_kotlin_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
   )
   
   kotlin_proto_compile(
       name = "thing_kotlin_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for kotlin_proto_compile
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

- `@rules_proto_grpc//kotlin:kotlin_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/kotlin/BUILD.bazel>`__

.. _kotlin_grpc_compile:

kotlin_grpc_compile
-------------------

Generates a Kotlin (JVM) protobuf and gRPC srcjar file

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/kotlin/kotlin_grpc_compile>`__

``WORKSPACE``
^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//kotlin:repositories.bzl", rules_proto_grpc_kotlin_repos = "kotlin_repos")
   
   rules_proto_grpc_kotlin_repos()

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//kotlin:defs.bzl", "kotlin_grpc_compile")
   
   kotlin_grpc_compile(
       name = "thing_kotlin_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   kotlin_grpc_compile(
       name = "greeter_kotlin_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for kotlin_grpc_compile
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

- `@rules_proto_grpc//kotlin:kotlin_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/kotlin/BUILD.bazel>`__
- `@rules_proto_grpc//kotlin:grpc_kotlin_plugin <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/kotlin/BUILD.bazel>`__

.. _kotlin_proto_library:

kotlin_proto_library
--------------------

Generates a Kotlin (JVM) protobuf library using ``kt_jvm_library``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/kotlin/kotlin_proto_library>`__

``WORKSPACE``
^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//kotlin:repositories.bzl", rules_proto_grpc_kotlin_repos = "kotlin_repos")
   
   rules_proto_grpc_kotlin_repos()

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//kotlin:defs.bzl", "kotlin_proto_library")
   
   kotlin_proto_library(
       name = "person_kotlin_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
       deps = ["place_kotlin_proto"],
   )
   
   kotlin_proto_library(
       name = "place_kotlin_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
       deps = ["thing_kotlin_proto"],
   )
   
   kotlin_proto_library(
       name = "thing_kotlin_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for kotlin_proto_library
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
   * - ``exports``
     - ``label_list``
     - false
     - ``[]``
     - List of labels to pass as exports attr to underlying lang_library rule

.. _kotlin_grpc_library:

kotlin_grpc_library
-------------------

Generates a Kotlin (JVM) protobuf and gRPC library using ``kt_jvm_library``

Example
*******

Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/example/kotlin/kotlin_grpc_library>`__

``WORKSPACE``
^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//kotlin:repositories.bzl", rules_proto_grpc_kotlin_repos = "kotlin_repos")
   
   rules_proto_grpc_kotlin_repos()
   
   load("@io_bazel_rules_kotlin//kotlin:repositories.bzl", "kotlin_repositories")
   
   kotlin_repositories()
   
   load("@io_bazel_rules_kotlin//kotlin:core.bzl", "kt_register_toolchains")
   
   kt_register_toolchains()
   
   load("@rules_jvm_external//:defs.bzl", "maven_install")
   load("@io_grpc_grpc_java//:repositories.bzl", "IO_GRPC_GRPC_JAVA_ARTIFACTS", "IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS", "grpc_java_repositories")
   load("@com_github_grpc_grpc_kotlin//:repositories.bzl", "IO_GRPC_GRPC_KOTLIN_ARTIFACTS", "IO_GRPC_GRPC_KOTLIN_OVERRIDE_TARGETS", "grpc_kt_repositories")
   
   maven_install(
       artifacts = IO_GRPC_GRPC_JAVA_ARTIFACTS + IO_GRPC_GRPC_KOTLIN_ARTIFACTS,
       generate_compat_repositories = True,
       override_targets = dict(IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS.items() +
                               IO_GRPC_GRPC_KOTLIN_OVERRIDE_TARGETS.items()),
       repositories = [
           "https://repo.maven.apache.org/maven2/",
       ],
   )
   
   load("@maven//:compat.bzl", "compat_repositories")
   
   compat_repositories()
   
   grpc_java_repositories()
   
   grpc_kt_repositories()

``BUILD.bazel``
^^^^^^^^^^^^^^^

.. code-block:: python

   load("@rules_proto_grpc//kotlin:defs.bzl", "kotlin_grpc_library")
   
   kotlin_grpc_library(
       name = "thing_kotlin_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   kotlin_grpc_library(
       name = "greeter_kotlin_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
       deps = ["thing_kotlin_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for kotlin_grpc_library
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
   * - ``exports``
     - ``label_list``
     - false
     - ``[]``
     - List of labels to pass as exports attr to underlying lang_library rule
