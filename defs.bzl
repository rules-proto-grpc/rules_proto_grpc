"""Top level definition exports for rules_proto_grpc."""

load("//internal:compile.bzl", _proto_compile_aspect_attrs = "proto_compile_aspect_attrs", _proto_compile_aspect_impl = "proto_compile_aspect_impl", _proto_compile_attrs = "proto_compile_attrs", _proto_compile_impl = "proto_compile_impl")
load("//internal:plugin.bzl", _proto_plugin = "proto_plugin")
load("//internal:providers.bzl", _ProtoCompileInfo = "ProtoCompileInfo", _ProtoLibraryAspectNodeInfo = "ProtoLibraryAspectNodeInfo", _ProtoPluginInfo = "ProtoPluginInfo")

# Export providers
ProtoPluginInfo = _ProtoPluginInfo
ProtoLibraryAspectNodeInfo = _ProtoLibraryAspectNodeInfo
ProtoCompileInfo = _ProtoCompileInfo

# Export plugin rule
proto_plugin = _proto_plugin

# Export compile and aspect rules
proto_compile_attrs = _proto_compile_attrs
proto_compile_aspect_attrs = _proto_compile_aspect_attrs
proto_compile_impl = _proto_compile_impl
proto_compile_aspect_impl = _proto_compile_aspect_impl
