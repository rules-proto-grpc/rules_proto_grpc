"""Top level definition exports for rules_proto_grpc."""

load("//internal:compile.bzl", _proto_compile_attrs = "proto_compile_attrs", _proto_compile_impl = "proto_compile_impl")
load("//internal:filter_files.bzl", _filter_files = "filter_files")
load("//internal:plugin.bzl", _proto_plugin = "proto_plugin")
load("//internal:providers.bzl", _ProtoCompileInfo = "ProtoCompileInfo", _ProtoPluginInfo = "ProtoPluginInfo")

# Export providers
ProtoPluginInfo = _ProtoPluginInfo
ProtoCompileInfo = _ProtoCompileInfo

# Export plugin rule
proto_plugin = _proto_plugin

# Export compile rule implementation and attrs
proto_compile_attrs = _proto_compile_attrs
proto_compile_impl = _proto_compile_impl

# Export utils
filter_files = _filter_files
