:author: rules_proto_grpc
:description: Example usage for the rules_proto_grpc Bazel rules
:keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, Example, Usage


Example Usage
=============

These steps walk through the actions required to go from a raw ``.proto`` file to a C++ library. Other languages will have
a similar high-level layout.

**Step 1**: Write a Protocol Buffer .proto file (example: ``thing.proto``):

.. code-block:: proto

   syntax = "proto3";

   package example;

   import "google/protobuf/any.proto";

   message Thing {
       string name = 1;
       google.protobuf.Any payload = 2;
   }

**Step 2**: Write a ``BAZEL.build`` file with a
`proto_library <https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library>`_ target:

.. code-block:: python

   proto_library(
       name = "thing_proto",
       srcs = ["thing.proto"],
       deps = ["@com_google_protobuf//:any_proto"],
   )

In this example we have a dependency on a well-known type ``any.proto``, hence the ``proto_library`` to ``proto_library``
dependency (``"@com_google_protobuf//:any_proto"``)

**Step 3**: Add a ``cpp_proto_compile`` target

**Note**: In this example ``thing.proto`` does not include service definitions (gRPC). For protos with services, use the
``cpp_grpc_compile`` rule instead.

.. code-block:: python

   # BUILD.bazel
   load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_compile")

   cpp_proto_compile(
       name = "cpp_thing_proto",
       protos = [":thing_proto"],
   )

But wait, before we can build this, we need to load the dependencies necessary for this rule
(see `cpp </cpp>`_):

**Step 4**: Load the workspace macro corresponding to the build rule.

.. code-block:: python

   # WORKSPACE
   load("@rules_proto_grpc//cpp:repositories.bzl", "cpp_repos")

   cpp_repos()

We're now ready to build the target.

**Step 5**: Build it!

.. code-block:: bash

   $ bazel build //example/proto:cpp_thing_proto
   Target //example/proto:cpp_thing_proto up-to-date:
     bazel-genfiles/example/proto/cpp_thing_proto/example/proto/thing.pb.h
     bazel-genfiles/example/proto/cpp_thing_proto/example/proto/thing.pb.cc

If we were only interested in the generated files, the ``cpp_grpc_compile`` rule would be fine. However, for
convenience we'd rather have the outputs compiled into a C++ library. To do that, let's change the  rule from
``cpp_proto_compile`` to ``cpp_proto_library``:

.. code-block:: python

   # BUILD.bazel
   load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_library")

   cpp_proto_library(
       name = "cpp_thing_proto",
       protos = [":thing_proto"],
   )


.. code-block:: bash

   $ bazel build //example/proto:cpp_thing_proto
   Target //example/proto:cpp_thing_proto up-to-date:
     bazel-bin/example/proto/libcpp_thing_proto.a
     bazel-bin/example/proto/libcpp_thing_proto.so  bazel-genfiles/example/proto/cpp_thing_proto/example/proto/thing.pb.h
     bazel-genfiles/example/proto/cpp_thing_proto/example/proto/thing.pb.cc

This way, we can use ``//example/proto:cpp_thing_proto`` as a dependency of any other ``cc_library`` or ``cc_binary`` target
as per normal.

**Note**: The ``cpp_proto_library`` target implicitly calls ``cpp_proto_compile``, and we can access that rule's by adding
``_pb`` at the end of the target name, like ``bazel build //example/proto:cpp_thing_proto_pb``