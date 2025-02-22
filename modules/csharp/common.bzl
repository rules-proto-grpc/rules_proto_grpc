# All common build attrs from https://bazel.build/reference/be/common-definitions#common-attributes
# These are listed here to be correctly propagated through *_library macros to the underlying
# rules without just passing the entirety of kwargs, although maybe that's the better choice...
csharp_library_attrs = [
    "data",
    "resources",
    "out",
    "additionalfiles",
    # more
    "target_frameworks",
]
