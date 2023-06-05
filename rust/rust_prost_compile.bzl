"""Rules for compiling .proto files using the prost via the prost protoc plugins."""
load(
    "//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile",
)

prost_compile_attrs = [
    "declared_proto_packages",
    "crate_name",
]
ProstProtoInfo = provider(
    doc = "Additional information needed for prost compilation rules.",
    fields = {
        "crate_name": "Name of the crate that will wrap this module.",
        "declared_proto_packages": "All proto packages that this compile rule generates bindings for.",
    }
)

def rust_prost_proto_compile_impl(ctx):
    """Implements rust prost proto library.

    Args:
        ctx (Context): The context object passed by bazel.
    Returns:
        list: A list of the following providers:
            - (ProstProtoInfo): Information upstream prost compliation rules need to know about this rule.
            - (ProtoCompileInfo): From core proto_compile function
            - (DefaultInfo): Default build rule info.
    """

    # 
    externs = []
    for dep in ctx.attr.prost_proto_deps:
        if ProstProtoInfo not in dep:
            continue
        proto_info = dep[ProstProtoInfo]
        packages = proto_info.declared_proto_packages
        dep_crate = proto_info.crate_name or proto_info.name
        
        for package in packages:
            externs.append("extern_path={}=::{}::{}".format(
                "." + package,
                dep_crate,
                package.replace(".", "::"),
            ))
    options = {}
    for option in ctx.attr.options:
        options[option] = ctx.attr.options[option]
    if "//rust:rust_prost_plugin" not in options:
        options["//rust:rust_prost_plugin"] = []
    options["//rust:rust_prost_plugin"] = options["//rust:rust_prost_plugin"] + externs
    
    compile_result = proto_compile(
        ctx,
        options,
        getattr(ctx.attr, "extra_protoc_args", []),
        ctx.files.extra_protoc_files)
    crate_name = ctx.attr.crate_name or ctx.attr.name
    return compile_result + [ProstProtoInfo(
        declared_proto_packages = ctx.attr.declared_proto_packages,
        crate_name = crate_name
    )]


rust_prost_proto_compile = rule(
    implementation = rust_prost_proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        prost_proto_deps = attr.label_list(
            providers = [ProstProtoInfo],
            mandatory = False,
            doc = "Other protos compiled by prost that our proto directly depends upon. Used to generated externs_path=... options for prost."
        ),
        declared_proto_packages = attr.string_list(
            mandatory = True,
            doc = "List of labels that provide the ProtoInfo provider (such as proto_library from rules_proto)",
        ),
        crate_name = attr.string(
            mandatory = False,
            doc = "Name of the crate these protos will be compiled into later using rust_library. See rust_prost_proto_library macro for more details.",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//rust:rust_prost_plugin"),
                Label("//rust:rust_crate_plugin"),
                Label("//rust:rust_serde_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("//protobuf:toolchain_type"))],
)

rust_tonic_grpc_compile = rule(
    implementation = rust_prost_proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        prost_proto_deps = attr.label_list(
            providers = [ProstProtoInfo],
            mandatory = False,
            doc = "Other protos compiled by prost that our proto directly depends upon. Used to generated externs_path=... options for prost."
        ),
        declared_proto_packages = attr.string_list(
            mandatory = True,
            doc = "List of labels that provide the ProtoInfo provider (such as proto_library from rules_proto)",
        ),
        crate_name = attr.string(
            mandatory = False,
            doc = "Name of the crate these protos will be compiled into later using rust_library. See rust_prost_proto_library macro for more details.",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//rust:rust_prost_plugin"),
                Label("//rust:rust_crate_plugin"),
                Label("//rust:rust_tonic_plugin"),
                Label("//rust:rust_serde_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("//protobuf:toolchain_type"))],
)