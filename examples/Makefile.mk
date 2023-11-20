.PHONY: c_c_proto_compile_example
c_c_proto_compile_example:
	cd examples/c/c_proto_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: c_c_proto_library_example
c_c_proto_library_example:
	cd examples/c/c_proto_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: c_examples
c_examples: c_c_proto_compile_example c_c_proto_library_example

.PHONY: cpp_cpp_proto_compile_example
cpp_cpp_proto_compile_example:
	cd examples/cpp/cpp_proto_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_grpc_compile_example
cpp_cpp_grpc_compile_example:
	cd examples/cpp/cpp_grpc_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_proto_library_example
cpp_cpp_proto_library_example:
	cd examples/cpp/cpp_proto_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_grpc_library_example
cpp_cpp_grpc_library_example:
	cd examples/cpp/cpp_grpc_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_examples
cpp_examples: cpp_cpp_proto_compile_example cpp_cpp_grpc_compile_example cpp_cpp_proto_library_example cpp_cpp_grpc_library_example

.PHONY: go_go_proto_compile_example
go_go_proto_compile_example:
	cd examples/go/go_proto_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_grpc_compile_example
go_go_grpc_compile_example:
	cd examples/go/go_grpc_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_proto_library_example
go_go_proto_library_example:
	cd examples/go/go_proto_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_grpc_library_example
go_go_grpc_library_example:
	cd examples/go/go_grpc_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_examples
go_examples: go_go_proto_compile_example go_go_grpc_compile_example go_go_proto_library_example go_go_grpc_library_example

.PHONY: grpc_gateway_gateway_grpc_compile_example
grpc_gateway_gateway_grpc_compile_example:
	cd examples/grpc_gateway/gateway_grpc_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: grpc_gateway_gateway_openapiv2_compile_example
grpc_gateway_gateway_openapiv2_compile_example:
	cd examples/grpc_gateway/gateway_openapiv2_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: grpc_gateway_gateway_grpc_library_example
grpc_gateway_gateway_grpc_library_example:
	cd examples/grpc_gateway/gateway_grpc_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: grpc_gateway_examples
grpc_gateway_examples: grpc_gateway_gateway_grpc_compile_example grpc_gateway_gateway_openapiv2_compile_example grpc_gateway_gateway_grpc_library_example

.PHONY: python_python_proto_compile_example
python_python_proto_compile_example:
	cd examples/python/python_proto_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpc_compile_example
python_python_grpc_compile_example:
	cd examples/python/python_grpc_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpclib_compile_example
python_python_grpclib_compile_example:
	cd examples/python/python_grpclib_compile; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_proto_library_example
python_python_proto_library_example:
	cd examples/python/python_proto_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpc_library_example
python_python_grpc_library_example:
	cd examples/python/python_grpc_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpclib_library_example
python_python_grpclib_library_example:
	cd examples/python/python_grpclib_library; \
	bazel --batch build --enable_bzlmod ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_examples
python_examples: python_python_proto_compile_example python_python_grpc_compile_example python_python_grpclib_compile_example python_python_proto_library_example python_python_grpc_library_example python_python_grpclib_library_example

.PHONY: all_examples
all_examples: c_c_proto_compile_example c_c_proto_library_example cpp_cpp_proto_compile_example cpp_cpp_grpc_compile_example cpp_cpp_proto_library_example cpp_cpp_grpc_library_example go_go_proto_compile_example go_go_grpc_compile_example go_go_proto_library_example go_go_grpc_library_example grpc_gateway_gateway_grpc_compile_example grpc_gateway_gateway_openapiv2_compile_example grpc_gateway_gateway_grpc_library_example python_python_proto_compile_example python_python_grpc_compile_example python_python_grpclib_compile_example python_python_proto_library_example python_python_grpc_library_example python_python_grpclib_library_example
