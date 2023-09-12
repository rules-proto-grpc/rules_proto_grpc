.PHONY: cpp_cpp_proto_compile_example
cpp_cpp_proto_compile_example:
	cd example/cpp/cpp_proto_compile; \
	bazel --batch build --enable_bzlmod --cxxopt=-std=c++17 --host_cxxopt=-std=c++17 ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_grpc_compile_example
cpp_cpp_grpc_compile_example:
	cd example/cpp/cpp_grpc_compile; \
	bazel --batch build --enable_bzlmod --cxxopt=-std=c++17 --host_cxxopt=-std=c++17 ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_proto_library_example
cpp_cpp_proto_library_example:
	cd example/cpp/cpp_proto_library; \
	bazel --batch build --enable_bzlmod --cxxopt=-std=c++17 --host_cxxopt=-std=c++17 ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_grpc_library_example
cpp_cpp_grpc_library_example:
	cd example/cpp/cpp_grpc_library; \
	bazel --batch build --enable_bzlmod --cxxopt=-std=c++17 --host_cxxopt=-std=c++17 ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_examples
cpp_examples: cpp_cpp_proto_compile_example cpp_cpp_grpc_compile_example cpp_cpp_proto_library_example cpp_cpp_grpc_library_example

.PHONY: all_examples
all_examples: cpp_cpp_proto_compile_example cpp_cpp_grpc_compile_example cpp_cpp_proto_library_example cpp_cpp_grpc_library_example
