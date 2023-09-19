<div align="center">
    <img width="200" height="200" src="https://raw.githubusercontent.com/rules-proto-grpc/rules_proto_grpc/master/docs/_static/logo.svg">
    <h1>Protobuf and gRPC rules for <a href="https://bazel.build">Bazel</a></h1>
</div>

<div align="center">
    <a href="https://bazel.build">Bazel</a> rules for building <a href="https://developers.google.com/protocol-buffers">Protobuf</a> and <a href="https://grpc.io/">gRPC</a> code and libraries from <a href="https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library">proto_library</a> targets<br><br>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/releases"><img src="https://img.shields.io/github/v/tag/rules-proto-grpc/rules_proto_grpc?label=release&sort=semver&color=38a3a5"></a>
    <a href="https://buildkite.com/bazel/rules-proto-grpc-rules-proto-grpc"><img src="https://badge.buildkite.com/a0c88e60f21c85a8bb53a8c73175aebd64f50a0d4bacbdb038.svg?branch=master"></a>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/actions"><img src="https://github.com/rules-proto-grpc/rules_proto_grpc/workflows/CI/badge.svg"></a>
    <a href="https://bazelbuild.slack.com/archives/CKU1D04RM"><img src="https://img.shields.io/badge/bazelbuild-%23proto-38a3a5?logo=slack"></a>
</div>

> [!IMPORTANT]
> You are looking at the `next` branch, which contains highly experimental bzlmod support. It is not
> recommended that you use this version of these rules at present

## Announcements 📣

#### 2023/09/12 - Version 4.5.0

[Version 4.5.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/4.5.0),
which contains a number of version updates, bug fixes and usability improvements over 4.4.0.
Additionally, the Rust rules contain a major change of underlying gRPC and Protobuf library; the
rules now use Tonic and Prost respectively

#### 2023/05/03 - Version 4.4.0

[Version 4.4.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/4.4.0),
which mainly contains fixes for build edge-cases and wider compatibility

#### 2022/12/04 - Version 4.3.0

[Version 4.3.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/4.3.0),
which contains support for more plugins features, fixes for proto paths containing special
characters and updates to the core dependencies


## Usage

Full documentation for the current and previous versions [can be found here](https://rules-proto-grpc.com)

- [Overview](https://rules-proto-grpc.com/en/latest/)
- [Installation](https://rules-proto-grpc.com/en/latest/#installation)
- [Example Usage](https://rules-proto-grpc.com/en/latest/example.html)
- [Custom Plugins](https://rules-proto-grpc.com/en/latest/custom_plugins.html)
- [Changelog](https://rules-proto-grpc.com/en/latest/changelog.html)


## Rules

| Language | Rule | Description
| ---: | :--- | :--- |
| [C++](https://rules-proto-grpc.com/en/latest/lang/cpp.html) | [cpp_proto_compile](https://rules-proto-grpc.com/en/latest/lang/cpp.html#cpp-proto-compile) | Generates C++ protobuf ``.h`` & ``.cc`` files ([example](/examples/cpp/cpp_proto_compile)) |
| [C++](https://rules-proto-grpc.com/en/latest/lang/cpp.html) | [cpp_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/cpp.html#cpp-grpc-compile) | Generates C++ protobuf and gRPC ``.h`` & ``.cc`` files ([example](/examples/cpp/cpp_grpc_compile)) |
| [C++](https://rules-proto-grpc.com/en/latest/lang/cpp.html) | [cpp_proto_library](https://rules-proto-grpc.com/en/latest/lang/cpp.html#cpp-proto-library) | Generates a C++ protobuf library using ``cc_library``, with dependencies linked ([example](/examples/cpp/cpp_proto_library)) |
| [C++](https://rules-proto-grpc.com/en/latest/lang/cpp.html) | [cpp_grpc_library](https://rules-proto-grpc.com/en/latest/lang/cpp.html#cpp-grpc-library) | Generates a C++ protobuf and gRPC library using ``cc_library``, with dependencies linked ([example](/examples/cpp/cpp_grpc_library)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_proto_compile](https://rules-proto-grpc.com/en/latest/lang/python.html#python-proto-compile) | Generates Python protobuf ``.py`` files ([example](/examples/python/python_proto_compile)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_grpc_compile](https://rules-proto-grpc.com/en/latest/lang/python.html#python-grpc-compile) | Generates Python protobuf and gRPC ``.py`` files ([example](/examples/python/python_grpc_compile)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_grpclib_compile](https://rules-proto-grpc.com/en/latest/lang/python.html#python-grpclib-compile) | Generates Python protobuf and grpclib ``.py`` files (supports Python 3 only) ([example](/examples/python/python_grpclib_compile)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_proto_library](https://rules-proto-grpc.com/en/latest/lang/python.html#python-proto-library) | Generates a Python protobuf library using ``py_library`` from ``rules_python`` ([example](/examples/python/python_proto_library)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_grpc_library](https://rules-proto-grpc.com/en/latest/lang/python.html#python-grpc-library) | Generates a Python protobuf and gRPC library using ``py_library`` from ``rules_python`` ([example](/examples/python/python_grpc_library)) |
| [Python](https://rules-proto-grpc.com/en/latest/lang/python.html) | [python_grpclib_library](https://rules-proto-grpc.com/en/latest/lang/python.html#python-grpclib-library) | Generates a Python protobuf and grpclib library using ``py_library`` from ``rules_python`` (supports Python 3 only) ([example](/examples/python/python_grpclib_library)) |

## License

This project is derived from [stackb/rules_proto](https://github.com/stackb/rules_proto) under the
[Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0) license and  this project therefore maintains the terms of that
license