Buf rules
=========

Rules for linting and detecting breaking changes in .proto files with [Buf](https://buf.build).

Note that these rules behave differently from the other rules in this repo, since these produce no output and are instead used as tests.

Only Linux and Darwin (MacOS) is currently supported by Buf.

.. list-table:: Rules
   :widths: 1 1
   :header-rows: 1

   * - Rule
     - Description
   * - `buf_proto_breaking_test <buf_proto_breaking_test>`_
     - Checks .proto files for breaking changes
   * - `buf_proto_lint_test <buf_proto_lint_test>`_
     - Lints .proto files

``buf_proto_breaking_test``
---------------------------

.. note:: This rule is experimental. It may not work correctly!

Checks .proto files for breaking changes

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//buf:repositories.bzl", rules_proto_grpc_buf_repos = "buf_repos")
   
   rules_proto_grpc_buf_repos()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//buf:defs.bzl", "buf_proto_breaking_test")
   
   buf_proto_breaking_test(
       name = "buf_proto_lint",
       against_input = "@rules_proto_grpc//buf/example:image.json",
       protos = [
           "@rules_proto_grpc//example/proto:person_proto",
           "@rules_proto_grpc//example/proto:place_proto",
           "@rules_proto_grpc//example/proto:routeguide_proto",
           "@rules_proto_grpc//example/proto:thing_proto",
       ],
   )

Attributes
**********

.. list-table:: Rules
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - `protos`
     - `label_list`
     - true
     - `[]`
     - List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)
   * - `against_input`
     - `label`
     - true
     - ``
     - Label of an existing input image file to check against (.json or .bin)
   * - `use_rules`
     - `string_list`
     - false
     - `["FILE"]`
     - List of Buf breaking rule IDs or categories to use
   * - `except_rules`
     - `string_list`
     - false
     - `[]`
     - List of Buf breaking rule IDs or categories to drop
   * - `ignore_unstable_packages`
     - `bool`
     - false
     - `False`
     - Whether to ignore breaking changes in unstable package versions

Plugins
*******

- ``@rules_proto_grpc//buf:breaking_plugin``

``buf_proto_lint_test``
-----------------------

.. note:: This rule is experimental. It may not work correctly!

Lints .proto files

``WORKSPACE``
*************

.. code-block:: starlark

   load("@rules_proto_grpc//buf:repositories.bzl", rules_proto_grpc_buf_repos = "buf_repos")
   
   rules_proto_grpc_buf_repos()

``BUILD.bazel``
***************

.. code-block:: starlark

   load("@rules_proto_grpc//buf:defs.bzl", "buf_proto_lint_test")
   
   buf_proto_lint_test(
       name = "person_buf_proto_lint",
       except_rules = ["PACKAGE_VERSION_SUFFIX"],
       protos = ["@rules_proto_grpc//example/proto:person_proto"],
       use_rules = [
           "DEFAULT",
           "COMMENTS",
       ],
   )
   
   buf_proto_lint_test(
       name = "place_buf_proto_lint",
       except_rules = ["PACKAGE_VERSION_SUFFIX"],
       protos = ["@rules_proto_grpc//example/proto:place_proto"],
       use_rules = [
           "DEFAULT",
           "COMMENTS",
       ],
   )
   
   buf_proto_lint_test(
       name = "thing_buf_proto_lint",
       except_rules = ["PACKAGE_VERSION_SUFFIX"],
       protos = ["@rules_proto_grpc//example/proto:thing_proto"],
       use_rules = [
           "DEFAULT",
           "COMMENTS",
       ],
   )
   
   buf_proto_lint_test(
       name = "routeguide_buf_proto_lint",
       except_rules = [
           "PACKAGE_VERSION_SUFFIX",
           "RPC_REQUEST_STANDARD_NAME",
           "RPC_RESPONSE_STANDARD_NAME",
           "SERVICE_SUFFIX",
           "PACKAGE_DIRECTORY_MATCH",
           "RPC_REQUEST_RESPONSE_UNIQUE",
       ],
       protos = ["@rules_proto_grpc//example/proto:routeguide_proto"],
       use_rules = [
           "DEFAULT",
           "COMMENTS",
       ],
   )

Attributes
**********

.. list-table:: Rules
   :header-rows: 1

   * - Name
     - Type
     - Mandatory
     - Default
     - Description
   * - `protos`
     - `label_list`
     - true
     - ``
     - List of labels that provide the `ProtoInfo` provider (such as `proto_library` from `rules_proto`)
   * - `use_rules`
     - `string_list`
     - false
     - `["DEFAULT"]`
     - List of Buf lint rule IDs or categories to use
   * - `except_rules`
     - `string_list`
     - false
     - `[]`
     - List of Buf lint rule IDs or categories to drop
   * - `enum_zero_value_suffix`
     - `string`
     - false
     - `"_UNSPECIFIED"`
     - Specify the allowed suffix for the zero enum value
   * - `rpc_allow_same_request_response`
     - `bool`
     - false
     - `False`
     - Allow request and response message to be reused in a single RPC
   * - `rpc_allow_google_protobuf_empty_requests`
     - `bool`
     - false
     - `False`
     - Allow request message to be `google.protobuf.Empty`
   * - `rpc_allow_google_protobuf_empty_responses`
     - `bool`
     - false
     - `False`
     - Allow response message to be `google.protobuf.Empty`
   * - `service_suffix`
     - `string`
     - false
     - `"Service"`
     - The suffix to allow for services

Plugins
*******

- ``@rules_proto_grpc//buf:lint_plugin``
