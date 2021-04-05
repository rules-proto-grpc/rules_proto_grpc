Android rules
=============

Rules for generating Android protobuf and gRPC ``.jar`` files and libraries using standard Protocol Buffers and `gRPC-Java <https://github.com/grpc/grpc-java>`_. Libraries are created with ``android_library`` from `rules_android <https://github.com/bazelbuild/rules_android>`_

.. list-table:: Rules
   :widths: 1 1
   :header-rows: 1

   * - Rule
     - Description
   * - `android_proto_compile <#android_proto_compile>`_
     - Generates an Android protobuf ``.jar`` file
   * - `android_grpc_compile <#android_grpc_compile>`_
     - Generates Android protobuf and gRPC ``.jar`` files
   * - `android_proto_library <#android_proto_library>`_
     - Generates an Android protobuf library using ``android_library`` from ``rules_android``
   * - `android_grpc_library <#android_grpc_library>`_
     - Generates Android protobuf and gRPC library using ``android_library`` from ``rules_android``

``android_proto_compile``
-------------------------

Generates an Android protobuf ``.jar`` file

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//android:repositories.bzl", rules_proto_grpc_android_repos = "android_repos")
   
   rules_proto_grpc_android_repos()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//android:defs.bzl", "android_proto_compile")
   
   android_proto_compile(
       name = "person_android_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
   )
   
   android_proto_compile(
       name = "place_android_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
   )
   
   android_proto_compile(
       name = "thing_android_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for android_proto_compile
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

- ``@rules_proto_grpc//android:javalite_plugin``

``android_grpc_compile``
------------------------

Generates Android protobuf and gRPC ``.jar`` files

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//android:repositories.bzl", rules_proto_grpc_android_repos = "android_repos")
   
   rules_proto_grpc_android_repos()
   
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

   load("@rules_proto_grpc//android:defs.bzl", "android_grpc_compile")
   
   android_grpc_compile(
       name = "thing_android_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   android_grpc_compile(
       name = "greeter_android_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for android_grpc_compile
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

- ``@rules_proto_grpc//android:javalite_plugin``
- ``@rules_proto_grpc//android:grpc_javalite_plugin``

``android_proto_library``
-------------------------

Generates an Android protobuf library using ``android_library`` from ``rules_android``

``WORKSPACE``
*************

.. code-block:: starlark

   # The set of dependencies loaded here is excessive for android proto alone
   # (but simplifies our setup)
   load("@rules_proto_grpc//android:repositories.bzl", rules_proto_grpc_android_repos = "android_repos")
   
   rules_proto_grpc_android_repos()
   
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
   
   load("@build_bazel_rules_android//android:sdk_repository.bzl", "android_sdk_repository")
   
   android_sdk_repository(name = "androidsdk")

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//android:defs.bzl", "android_proto_library")
   
   android_proto_library(
       name = "person_android_proto",
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
       deps = ["place_android_proto"],
   )
   
   android_proto_library(
       name = "place_android_proto",
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
       deps = ["thing_android_proto"],
   )
   
   android_proto_library(
       name = "thing_android_proto",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )

Attributes
**********

.. list-table:: Attributes for android_proto_library
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

``android_grpc_library``
------------------------

Generates Android protobuf and gRPC library using ``android_library`` from ``rules_android``

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//android:repositories.bzl", rules_proto_grpc_android_repos = "android_repos")
   
   rules_proto_grpc_android_repos()
   
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
   
   load("@build_bazel_rules_android//android:sdk_repository.bzl", "android_sdk_repository")
   
   android_sdk_repository(name = "androidsdk")

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//android:defs.bzl", "android_grpc_library")
   
   android_grpc_library(
       name = "thing_android_grpc",
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
   )
   
   android_grpc_library(
       name = "greeter_android_grpc",
       protos = ["@rules_proto_grpc//example/proto:greeter_grpc"],
       deps = ["thing_android_grpc"],
   )

Attributes
**********

.. list-table:: Attributes for android_grpc_library
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
