.PHONY: android_android_proto_compile_example
android_android_proto_compile_example:
	cd example/android/android_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: android_android_grpc_compile_example
android_android_grpc_compile_example:
	cd example/android/android_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: android_android_proto_library_example
android_android_proto_library_example:
	cd example/android/android_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: android_android_grpc_library_example
android_android_grpc_library_example:
	cd example/android/android_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: android_examples
android_examples: android_android_proto_compile_example android_android_grpc_compile_example android_android_proto_library_example android_android_grpc_library_example

.PHONY: closure_closure_proto_compile_example
closure_closure_proto_compile_example:
	cd example/closure/closure_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: closure_closure_proto_library_example
closure_closure_proto_library_example:
	cd example/closure/closure_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: closure_examples
closure_examples: closure_closure_proto_compile_example closure_closure_proto_library_example

.PHONY: cpp_cpp_proto_compile_example
cpp_cpp_proto_compile_example:
	cd example/cpp/cpp_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_grpc_compile_example
cpp_cpp_grpc_compile_example:
	cd example/cpp/cpp_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_proto_library_example
cpp_cpp_proto_library_example:
	cd example/cpp/cpp_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_cpp_grpc_library_example
cpp_cpp_grpc_library_example:
	cd example/cpp/cpp_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: cpp_examples
cpp_examples: cpp_cpp_proto_compile_example cpp_cpp_grpc_compile_example cpp_cpp_proto_library_example cpp_cpp_grpc_library_example

.PHONY: csharp_csharp_proto_compile_example
csharp_csharp_proto_compile_example:
	cd example/csharp/csharp_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: csharp_csharp_grpc_compile_example
csharp_csharp_grpc_compile_example:
	cd example/csharp/csharp_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: csharp_csharp_proto_library_example
csharp_csharp_proto_library_example:
	cd example/csharp/csharp_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: csharp_csharp_grpc_library_example
csharp_csharp_grpc_library_example:
	cd example/csharp/csharp_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: csharp_examples
csharp_examples: csharp_csharp_proto_compile_example csharp_csharp_grpc_compile_example csharp_csharp_proto_library_example csharp_csharp_grpc_library_example

.PHONY: d_d_proto_compile_example
d_d_proto_compile_example:
	cd example/d/d_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: d_d_proto_library_example
d_d_proto_library_example:
	cd example/d/d_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: d_examples
d_examples: d_d_proto_compile_example d_d_proto_library_example

.PHONY: go_go_proto_compile_example
go_go_proto_compile_example:
	cd example/go/go_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_grpc_compile_example
go_go_grpc_compile_example:
	cd example/go/go_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_proto_library_example
go_go_proto_library_example:
	cd example/go/go_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_go_grpc_library_example
go_go_grpc_library_example:
	cd example/go/go_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: go_examples
go_examples: go_go_proto_compile_example go_go_grpc_compile_example go_go_proto_library_example go_go_grpc_library_example

.PHONY: java_java_proto_compile_example
java_java_proto_compile_example:
	cd example/java/java_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: java_java_grpc_compile_example
java_java_grpc_compile_example:
	cd example/java/java_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: java_java_proto_library_example
java_java_proto_library_example:
	cd example/java/java_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: java_java_grpc_library_example
java_java_grpc_library_example:
	cd example/java/java_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: java_examples
java_examples: java_java_proto_compile_example java_java_grpc_compile_example java_java_proto_library_example java_java_grpc_library_example

.PHONY: nodejs_nodejs_proto_compile_example
nodejs_nodejs_proto_compile_example:
	cd example/nodejs/nodejs_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: nodejs_nodejs_grpc_compile_example
nodejs_nodejs_grpc_compile_example:
	cd example/nodejs/nodejs_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: nodejs_nodejs_proto_library_example
nodejs_nodejs_proto_library_example:
	cd example/nodejs/nodejs_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: nodejs_nodejs_grpc_library_example
nodejs_nodejs_grpc_library_example:
	cd example/nodejs/nodejs_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: nodejs_examples
nodejs_examples: nodejs_nodejs_proto_compile_example nodejs_nodejs_grpc_compile_example nodejs_nodejs_proto_library_example nodejs_nodejs_grpc_library_example

.PHONY: objc_objc_proto_compile_example
objc_objc_proto_compile_example:
	cd example/objc/objc_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: objc_objc_grpc_compile_example
objc_objc_grpc_compile_example:
	cd example/objc/objc_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: objc_objc_proto_library_example
objc_objc_proto_library_example:
	cd example/objc/objc_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: objc_examples
objc_examples: objc_objc_proto_compile_example objc_objc_grpc_compile_example objc_objc_proto_library_example

.PHONY: php_php_proto_compile_example
php_php_proto_compile_example:
	cd example/php/php_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: php_php_grpc_compile_example
php_php_grpc_compile_example:
	cd example/php/php_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: php_examples
php_examples: php_php_proto_compile_example php_php_grpc_compile_example

.PHONY: python_python_proto_compile_example
python_python_proto_compile_example:
	cd example/python/python_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpc_compile_example
python_python_grpc_compile_example:
	cd example/python/python_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpclib_compile_example
python_python_grpclib_compile_example:
	cd example/python/python_grpclib_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_proto_library_example
python_python_proto_library_example:
	cd example/python/python_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpc_library_example
python_python_grpc_library_example:
	cd example/python/python_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_python_grpclib_library_example
python_python_grpclib_library_example:
	cd example/python/python_grpclib_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: python_examples
python_examples: python_python_proto_compile_example python_python_grpc_compile_example python_python_grpclib_compile_example python_python_proto_library_example python_python_grpc_library_example python_python_grpclib_library_example

.PHONY: ruby_ruby_proto_compile_example
ruby_ruby_proto_compile_example:
	cd example/ruby/ruby_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: ruby_ruby_grpc_compile_example
ruby_ruby_grpc_compile_example:
	cd example/ruby/ruby_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: ruby_ruby_proto_library_example
ruby_ruby_proto_library_example:
	cd example/ruby/ruby_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: ruby_ruby_grpc_library_example
ruby_ruby_grpc_library_example:
	cd example/ruby/ruby_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: ruby_examples
ruby_examples: ruby_ruby_proto_compile_example ruby_ruby_grpc_compile_example ruby_ruby_proto_library_example ruby_ruby_grpc_library_example

.PHONY: rust_rust_proto_compile_example
rust_rust_proto_compile_example:
	cd example/rust/rust_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: rust_rust_grpc_compile_example
rust_rust_grpc_compile_example:
	cd example/rust/rust_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: rust_rust_proto_library_example
rust_rust_proto_library_example:
	cd example/rust/rust_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: rust_rust_grpc_library_example
rust_rust_grpc_library_example:
	cd example/rust/rust_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: rust_examples
rust_examples: rust_rust_proto_compile_example rust_rust_grpc_compile_example rust_rust_proto_library_example rust_rust_grpc_library_example

.PHONY: scala_scala_proto_compile_example
scala_scala_proto_compile_example:
	cd example/scala/scala_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: scala_scala_grpc_compile_example
scala_scala_grpc_compile_example:
	cd example/scala/scala_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: scala_scala_proto_library_example
scala_scala_proto_library_example:
	cd example/scala/scala_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: scala_scala_grpc_library_example
scala_scala_grpc_library_example:
	cd example/scala/scala_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: scala_examples
scala_examples: scala_scala_proto_compile_example scala_scala_grpc_compile_example scala_scala_proto_library_example scala_scala_grpc_library_example

.PHONY: swift_swift_proto_compile_example
swift_swift_proto_compile_example:
	cd example/swift/swift_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: swift_swift_grpc_compile_example
swift_swift_grpc_compile_example:
	cd example/swift/swift_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: swift_swift_proto_library_example
swift_swift_proto_library_example:
	cd example/swift/swift_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: swift_swift_grpc_library_example
swift_swift_grpc_library_example:
	cd example/swift/swift_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../bazel-disk-cache //...

.PHONY: swift_examples
swift_examples: swift_swift_proto_compile_example swift_swift_grpc_compile_example swift_swift_proto_library_example swift_swift_grpc_library_example

.PHONY: gogo_gogo_proto_compile_example
gogo_gogo_proto_compile_example:
	cd example/github.com/gogo/protobuf/gogo_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogo_grpc_compile_example
gogo_gogo_grpc_compile_example:
	cd example/github.com/gogo/protobuf/gogo_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogo_proto_library_example
gogo_gogo_proto_library_example:
	cd example/github.com/gogo/protobuf/gogo_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogo_grpc_library_example
gogo_gogo_grpc_library_example:
	cd example/github.com/gogo/protobuf/gogo_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogofast_proto_compile_example
gogo_gogofast_proto_compile_example:
	cd example/github.com/gogo/protobuf/gogofast_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogofast_grpc_compile_example
gogo_gogofast_grpc_compile_example:
	cd example/github.com/gogo/protobuf/gogofast_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogofast_proto_library_example
gogo_gogofast_proto_library_example:
	cd example/github.com/gogo/protobuf/gogofast_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogofast_grpc_library_example
gogo_gogofast_grpc_library_example:
	cd example/github.com/gogo/protobuf/gogofast_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogofaster_proto_compile_example
gogo_gogofaster_proto_compile_example:
	cd example/github.com/gogo/protobuf/gogofaster_proto_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogofaster_grpc_compile_example
gogo_gogofaster_grpc_compile_example:
	cd example/github.com/gogo/protobuf/gogofaster_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogofaster_proto_library_example
gogo_gogofaster_proto_library_example:
	cd example/github.com/gogo/protobuf/gogofaster_proto_library; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_gogofaster_grpc_library_example
gogo_gogofaster_grpc_library_example:
	cd example/github.com/gogo/protobuf/gogofaster_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: gogo_examples
gogo_examples: gogo_gogo_proto_compile_example gogo_gogo_grpc_compile_example gogo_gogo_proto_library_example gogo_gogo_grpc_library_example gogo_gogofast_proto_compile_example gogo_gogofast_grpc_compile_example gogo_gogofast_proto_library_example gogo_gogofast_grpc_library_example gogo_gogofaster_proto_compile_example gogo_gogofaster_grpc_compile_example gogo_gogofaster_proto_library_example gogo_gogofaster_grpc_library_example

.PHONY: grpc-gateway_gateway_grpc_compile_example
grpc-gateway_gateway_grpc_compile_example:
	cd example/github.com/grpc-ecosystem/grpc-gateway/gateway_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: grpc-gateway_gateway_swagger_compile_example
grpc-gateway_gateway_swagger_compile_example:
	cd example/github.com/grpc-ecosystem/grpc-gateway/gateway_swagger_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: grpc-gateway_gateway_grpc_library_example
grpc-gateway_gateway_grpc_library_example:
	cd example/github.com/grpc-ecosystem/grpc-gateway/gateway_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: grpc-gateway_examples
grpc-gateway_examples: grpc-gateway_gateway_grpc_compile_example grpc-gateway_gateway_swagger_compile_example grpc-gateway_gateway_grpc_library_example

.PHONY: grpc-web_closure_grpc_compile_example
grpc-web_closure_grpc_compile_example:
	cd example/github.com/grpc/grpc-web/closure_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: grpc-web_commonjs_grpc_compile_example
grpc-web_commonjs_grpc_compile_example:
	cd example/github.com/grpc/grpc-web/commonjs_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: grpc-web_commonjs_dts_grpc_compile_example
grpc-web_commonjs_dts_grpc_compile_example:
	cd example/github.com/grpc/grpc-web/commonjs_dts_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: grpc-web_ts_grpc_compile_example
grpc-web_ts_grpc_compile_example:
	cd example/github.com/grpc/grpc-web/ts_grpc_compile; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: grpc-web_closure_grpc_library_example
grpc-web_closure_grpc_library_example:
	cd example/github.com/grpc/grpc-web/closure_grpc_library; \
	bazel --batch build --verbose_failures --disk_cache=../../../../bazel-disk-cache //...

.PHONY: grpc-web_examples
grpc-web_examples: grpc-web_closure_grpc_compile_example grpc-web_commonjs_grpc_compile_example grpc-web_commonjs_dts_grpc_compile_example grpc-web_ts_grpc_compile_example grpc-web_closure_grpc_library_example

.PHONY: all_examples
all_examples: android_android_proto_compile_example android_android_grpc_compile_example android_android_proto_library_example android_android_grpc_library_example closure_closure_proto_compile_example closure_closure_proto_library_example cpp_cpp_proto_compile_example cpp_cpp_grpc_compile_example cpp_cpp_proto_library_example cpp_cpp_grpc_library_example csharp_csharp_proto_compile_example csharp_csharp_grpc_compile_example csharp_csharp_proto_library_example csharp_csharp_grpc_library_example d_d_proto_compile_example d_d_proto_library_example go_go_proto_compile_example go_go_grpc_compile_example go_go_proto_library_example go_go_grpc_library_example java_java_proto_compile_example java_java_grpc_compile_example java_java_proto_library_example java_java_grpc_library_example nodejs_nodejs_proto_compile_example nodejs_nodejs_grpc_compile_example nodejs_nodejs_proto_library_example nodejs_nodejs_grpc_library_example objc_objc_proto_compile_example objc_objc_grpc_compile_example objc_objc_proto_library_example php_php_proto_compile_example php_php_grpc_compile_example python_python_proto_compile_example python_python_grpc_compile_example python_python_grpclib_compile_example python_python_proto_library_example python_python_grpc_library_example python_python_grpclib_library_example ruby_ruby_proto_compile_example ruby_ruby_grpc_compile_example ruby_ruby_proto_library_example ruby_ruby_grpc_library_example rust_rust_proto_compile_example rust_rust_grpc_compile_example rust_rust_proto_library_example rust_rust_grpc_library_example scala_scala_proto_compile_example scala_scala_grpc_compile_example scala_scala_proto_library_example scala_scala_grpc_library_example swift_swift_proto_compile_example swift_swift_grpc_compile_example swift_swift_proto_library_example swift_swift_grpc_library_example gogo_gogo_proto_compile_example gogo_gogo_grpc_compile_example gogo_gogo_proto_library_example gogo_gogo_grpc_library_example gogo_gogofast_proto_compile_example gogo_gogofast_grpc_compile_example gogo_gogofast_proto_library_example gogo_gogofast_grpc_library_example gogo_gogofaster_proto_compile_example gogo_gogofaster_grpc_compile_example gogo_gogofaster_proto_library_example gogo_gogofaster_grpc_library_example grpc-gateway_gateway_grpc_compile_example grpc-gateway_gateway_swagger_compile_example grpc-gateway_gateway_grpc_library_example grpc-web_closure_grpc_compile_example grpc-web_commonjs_grpc_compile_example grpc-web_commonjs_dts_grpc_compile_example grpc-web_ts_grpc_compile_example grpc-web_closure_grpc_library_example
