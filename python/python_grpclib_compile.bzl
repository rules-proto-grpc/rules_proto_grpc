"""Generated definition of python_grpclib_compile."""

load("@rules_proto//proto:defs.bzl", "ProtoInfo")
load(
    "//:defs.bzl",
    "ProtoLibraryAspectNodeInfo",
    "ProtoPluginInfo",
    "proto_compile_aspect_attrs",
    "proto_compile_aspect_impl",
    "proto_compile_attrs",
    "proto_compile_impl",
)

# Create aspect for python_grpclib_compile
python_grpclib_compile_aspect = aspect(
    implementation = proto_compile_aspect_impl,
    provides = [ProtoLibraryAspectNodeInfo],
    attr_aspects = ["deps"],
    attrs = dict(
        proto_compile_aspect_attrs,
        _plugins = attr.label_list(
            doc = "List of protoc plugins to apply",
            providers = [ProtoPluginInfo],
            default = [
                Label("//python:python_plugin"),
                Label("//python:grpclib_python_plugin"),
            ],
        ),
        _prefix = attr.string(
            doc = "String used to disambiguate aspects when generating outputs",
            default = "python_grpclib_compile_aspect",
        ),
    ),
    toolchains = [str(Label("//protobuf:toolchain_type"))],
)

# Create compile rule
_rule = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        protos = attr.label_list(
            mandatory = False,  # TODO: set to true in 4.0.0 when deps removed below
            providers = [ProtoInfo],
            doc = "List of labels that provide the ProtoInfo provider (such as proto_library from rules_proto)",
        ),
        deps = attr.label_list(
            mandatory = False,
            providers = [ProtoInfo, ProtoLibraryAspectNodeInfo],
            aspects = [python_grpclib_compile_aspect],
            doc = "DEPRECATED: Use protos attr",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//python:python_plugin"),
                Label("//python:grpclib_python_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("//protobuf:toolchain_type"))],
)

# Create macro for converting attrs and passing to compile
def python_grpclib_compile(**kwargs):
    _rule(
        verbose_string = "{}".format(kwargs.get("verbose", 0)),
        **kwargs
    )
