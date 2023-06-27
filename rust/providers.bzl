ProstProtoInfo = provider(
    doc = "Additional information needed for prost compilation rules.",
    fields = {
        "crate_name": "Name of the crate that will wrap this module.",
        "declared_proto_packages": "All proto packages that this compile rule generates bindings for.",
    }
)
