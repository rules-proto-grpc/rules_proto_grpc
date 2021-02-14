"""grpc-web protobuf and grpc rules."""

load(":closure_grpc_compile.bzl", _closure_grpc_compile = "closure_grpc_compile")
load(":commonjs_grpc_compile.bzl", _commonjs_grpc_compile = "commonjs_grpc_compile")
load(":commonjs_dts_grpc_compile.bzl", _commonjs_dts_grpc_compile = "commonjs_dts_grpc_compile")
load(":ts_grpc_compile.bzl", _ts_grpc_compile = "ts_grpc_compile")
load(":closure_grpc_library.bzl", _closure_grpc_library = "closure_grpc_library")

# Export grpc-web rules
closure_grpc_compile = _closure_grpc_compile
commonjs_grpc_compile = _commonjs_grpc_compile
commonjs_dts_grpc_compile = _commonjs_dts_grpc_compile
ts_grpc_compile = _ts_grpc_compile
closure_grpc_library = _closure_grpc_library
