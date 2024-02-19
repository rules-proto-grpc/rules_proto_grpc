.PHONY: buf_buf_proto_breaking_test_example
buf_buf_proto_breaking_test_example:
	cd examples/buf/buf_proto_breaking_test; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --test_output=errors --disk_cache=../../bazel-disk-cache //...

.PHONY: buf_buf_proto_lint_test_example
buf_buf_proto_lint_test_example:
	cd examples/buf/buf_proto_lint_test; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --test_output=errors --disk_cache=../../bazel-disk-cache //...

.PHONY: buf_examples
buf_examples: buf_buf_proto_breaking_test_example buf_buf_proto_lint_test_example

.PHONY: c_c_proto_compile_example
c_c_proto_compile_example:
	cd examples/c/c_proto_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: c_c_proto_library_example
c_c_proto_library_example:
	cd examples/c/c_proto_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: c_examples
c_examples: c_c_proto_compile_example c_c_proto_library_example

.PHONY: cpp_cpp_proto_compile_example
cpp_cpp_proto_compile_example:
	cd examples/cpp/cpp_proto_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_grpc_compile_example
cpp_cpp_grpc_compile_example:
	cd examples/cpp/cpp_grpc_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_proto_library_example
cpp_cpp_proto_library_example:
	cd examples/cpp/cpp_proto_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_grpc_library_example
cpp_cpp_grpc_library_example:
	cd examples/cpp/cpp_grpc_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_examples
cpp_examples: cpp_cpp_proto_compile_example cpp_cpp_grpc_compile_example cpp_cpp_proto_library_example cpp_cpp_grpc_library_example

.PHONY: doc_doc_docbook_compile_example
doc_doc_docbook_compile_example:
	cd examples/doc/doc_docbook_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: doc_doc_html_compile_example
doc_doc_html_compile_example:
	cd examples/doc/doc_html_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: doc_doc_json_compile_example
doc_doc_json_compile_example:
	cd examples/doc/doc_json_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: doc_doc_markdown_compile_example
doc_doc_markdown_compile_example:
	cd examples/doc/doc_markdown_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: doc_doc_template_compile_example
doc_doc_template_compile_example:
	cd examples/doc/doc_template_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: doc_examples
doc_examples: doc_doc_docbook_compile_example doc_doc_html_compile_example doc_doc_json_compile_example doc_doc_markdown_compile_example doc_doc_template_compile_example

.PHONY: go_go_proto_compile_example
go_go_proto_compile_example:
	cd examples/go/go_proto_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_grpc_compile_example
go_go_grpc_compile_example:
	cd examples/go/go_grpc_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_proto_library_example
go_go_proto_library_example:
	cd examples/go/go_proto_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_grpc_library_example
go_go_grpc_library_example:
	cd examples/go/go_grpc_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_examples
go_examples: go_go_proto_compile_example go_go_grpc_compile_example go_go_proto_library_example go_go_grpc_library_example

.PHONY: grpc_gateway_gateway_grpc_compile_example
grpc_gateway_gateway_grpc_compile_example:
	cd examples/grpc_gateway/gateway_grpc_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: grpc_gateway_gateway_openapiv2_compile_example
grpc_gateway_gateway_openapiv2_compile_example:
	cd examples/grpc_gateway/gateway_openapiv2_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: grpc_gateway_gateway_grpc_library_example
grpc_gateway_gateway_grpc_library_example:
	cd examples/grpc_gateway/gateway_grpc_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: grpc_gateway_examples
grpc_gateway_examples: grpc_gateway_gateway_grpc_compile_example grpc_gateway_gateway_openapiv2_compile_example grpc_gateway_gateway_grpc_library_example

.PHONY: java_java_proto_compile_example
java_java_proto_compile_example:
	cd examples/java/java_proto_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: java_java_grpc_compile_example
java_java_grpc_compile_example:
	cd examples/java/java_grpc_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: java_java_proto_library_example
java_java_proto_library_example:
	cd examples/java/java_proto_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: java_java_grpc_library_example
java_java_grpc_library_example:
	cd examples/java/java_grpc_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: java_examples
java_examples: java_java_proto_compile_example java_java_grpc_compile_example java_java_proto_library_example java_java_grpc_library_example

.PHONY: objc_objc_proto_compile_example
objc_objc_proto_compile_example:
	cd examples/objc/objc_proto_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: objc_objc_grpc_compile_example
objc_objc_grpc_compile_example:
	cd examples/objc/objc_grpc_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: objc_objc_proto_library_example
objc_objc_proto_library_example:
	cd examples/objc/objc_proto_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: objc_objc_grpc_library_example
objc_objc_grpc_library_example:
	cd examples/objc/objc_grpc_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: objc_examples
objc_examples: objc_objc_proto_compile_example objc_objc_grpc_compile_example objc_objc_proto_library_example objc_objc_grpc_library_example

.PHONY: python_python_proto_compile_example
python_python_proto_compile_example:
	cd examples/python/python_proto_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpc_compile_example
python_python_grpc_compile_example:
	cd examples/python/python_grpc_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpclib_compile_example
python_python_grpclib_compile_example:
	cd examples/python/python_grpclib_compile; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_proto_library_example
python_python_proto_library_example:
	cd examples/python/python_proto_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpc_library_example
python_python_grpc_library_example:
	cd examples/python/python_grpc_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpclib_library_example
python_python_grpclib_library_example:
	cd examples/python/python_grpclib_library; \
	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_examples
python_examples: python_python_proto_compile_example python_python_grpc_compile_example python_python_grpclib_compile_example python_python_proto_library_example python_python_grpc_library_example python_python_grpclib_library_example

.PHONY: all_examples
all_examples: buf_buf_proto_breaking_test_example buf_buf_proto_lint_test_example c_c_proto_compile_example c_c_proto_library_example cpp_cpp_proto_compile_example cpp_cpp_grpc_compile_example cpp_cpp_proto_library_example cpp_cpp_grpc_library_example doc_doc_docbook_compile_example doc_doc_html_compile_example doc_doc_json_compile_example doc_doc_markdown_compile_example doc_doc_template_compile_example go_go_proto_compile_example go_go_grpc_compile_example go_go_proto_library_example go_go_grpc_library_example grpc_gateway_gateway_grpc_compile_example grpc_gateway_gateway_openapiv2_compile_example grpc_gateway_gateway_grpc_library_example java_java_proto_compile_example java_java_grpc_compile_example java_java_proto_library_example java_java_grpc_library_example objc_objc_proto_compile_example objc_objc_grpc_compile_example objc_objc_proto_library_example objc_objc_grpc_library_example python_python_proto_compile_example python_python_grpc_compile_example python_python_grpclib_compile_example python_python_proto_library_example python_python_grpc_library_example python_python_grpclib_library_example
