load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("//internal:common.bzl", "check_bazel_minimum_version")

# Versions
MINIMUM_BAZEL_VERSION = "1.0.0"
VERSIONS = {
    # Core
    "com_google_protobuf": { # When updating, also update Node.js requirements, Ruby requirements and C# requirements
        "type": "github",
        "org": "protocolbuffers",
        "repo": "protobuf",
        "ref": "v3.10.0",
        "sha256": "758249b537abba2f21ebc2d02555bf080917f0f2f88f4cbe2903e0e28c4187ed",
        "binds": [
            {
                "name": "protobuf_clib",
                "actual": "@com_google_protobuf//:protoc_lib",
            },
            {
                "name": "protobuf_headers",
                "actual": "@com_google_protobuf//:protobuf_headers",
            },
        ],
    },
    "com_github_grpc_grpc": { # When updating, also update Python requirements, Node.js requirements, Ruby requirements and C# requirements
        "type": "github",
        "org": "grpc",
        "repo": "grpc",
        "ref": "v1.24.2",
        "sha256": "fd040f5238ff1e32b468d9d38e50f0d7f8da0828019948c9001e9a03093e1d8f",
    },
    "zlib": {
        "type": "http",
        "urls": ["https://zlib.net/zlib-1.2.11.tar.gz"],
        "sha256": "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
        "strip_prefix": "zlib-1.2.11",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.zlib",
    },
    "rules_python": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_python",
        "ref": "0.0.1",
        "sha256": "fa53cc0afe276d8f6675df1a424592e00e4f37b2a497e48399123233902e2e76",
    },
    "build_bazel_rules_swift": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_swift",
        "ref": "0.13.0",
        "sha256": "617e568aa8263c454f63362f5ab837038da710d646510b8f4a6760ff6361f714",
    },
    "build_bazel_apple_support": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "apple_support",
        "ref": "8c585c66c29b9d528e5fcf78da8057a6f3a4f001",
        "sha256": "0a8831032b06cabae582b604e734e10f32742311de8975d5182933e586760c5f",
    },
    "bazel_skylib": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-skylib",
        "ref": "1.0.2",
        "sha256": "e5d90f0ec952883d56747b7604e2a15ee36e288bb556c3d0ed33e818a4d971f2",
    },


    # Misc
    "com_github_bazelbuild_buildtools": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "buildtools",
        "ref": "0.28.0",
        "sha256": "d1e28237d1a4c2255c504246b4f3fd36f74d590f2974491b4399a84c58b495ed",
    },

    # Android
    "build_bazel_rules_android": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_android",
        "ref": "9ab1134546364c6de84fc6c80b4202fdbebbbb35",
        "sha256": "f329928c62ade05ceda72c4e145fd300722e6e592627d43580dd0a8211c14612",
    },
    "com_google_guava_guava_android": {
        "type": "jvm_maven_import_external",
        "artifact": "com.google.guava:guava:27.0.1-android",
        "server_urls": ["http://central.maven.org/maven2"],
        "artifact_sha256": "caf0955aed29a1e6d149f85cfb625a89161b5cf88e0e246552b7ffa358204e28",
    },
    "com_google_protobuf_javalite": {
        "type": "github",
        "org": "protocolbuffers",
        "repo": "protobuf",
        "ref": "fa08222434bc58d743e8c2cc716bc219c3d0f44e", # Jul 2019
        "sha256": "b04b08d31208be32aafdf5842d1b6073d527a67ff8d2cf4b17ee8f22a5273758",
    },

    # C Sharp
    "io_bazel_rules_dotnet": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_dotnet",
        "ref": "420a6b6cf49223bb372e734da8dc181d615ed01c", # June 26, 2019
        "sha256": "e6e0e513d23c655a97f3700683aba924c578cb1458bcd42bbbc5e5c512f6d86b",
    },

    # Closure
    "io_bazel_rules_closure": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_closure",
        "ref": "b2a6fb762a2a655d9970d88a9218b7a1cf098ffa",
        "sha256": "f2badc609a80a234bb51d1855281dd46cac90eadc57545880a3b5c38be0960e7",
    },

    # D
    "io_bazel_rules_d": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_d",
        "ref": "c4af62269c85dd5dcab0be119196baa5da4662b6", # June 28, 2019 + PR 30
        "sha256": "ef380076035d42bfc8b9a5547092779792de4b0cf718b9623a7c1923b0cd23e6",
    },
    "com_github_dcarp_protobuf_d": {
        "type": "http",
        "urls": ["https://github.com/dcarp/protobuf-d/archive/v0.5.0.tar.gz"],
        "sha256": "67a037dc29242f0d2f099746da67f40afff27c07f9ab48dda53d5847620db421",
        "strip_prefix": "protobuf-d-0.5.0",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_dcarp_protobuf_d",
    },

    # Go
    "io_bazel_rules_go": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_go",
        "ref": "v0.20.1",
        "sha256": "58f52fb4d67506f5e58490146fca5ca41583b36b74e4cd8dcd2a1d9c46ca8c62",
    },
    "bazel_gazelle": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-gazelle",
        "ref": "0.18.1",
        "sha256": "40f6b81c163d190ce7e16ea734ee748ad45e371306a46653fcab93aecda5c0da",
    },

    # gRPC gateway
    "grpc_ecosystem_grpc_gateway": {
        "type": "github",
        "org": "grpc-ecosystem",
        "repo": "grpc-gateway",
        "ref": "v1.9.5",
        "sha256": "2e38be4cd2801c1ff8ed87b8310437d9d289460ea102ad75ea37e3793af62151",
    },

    # gRPC web
    "com_github_grpc_grpc_web": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-web",
        "ref": "1.0.6",
        "sha256": "304e3c7e65e71a63e2d981df8c3f6604a3314f9e388ce704ced46b8b60dddae3",
    },

    # gRPC.js
    "com_github_stackb_grpc_js": {
        "type": "github",
        "org": "stackb",
        "repo": "grpc.js",
        "ref": "d075960a9e62846ce92ae1029a777c141809f489",
        "sha256": "c0f422823486986ea965fd36a0f5d3380151516421a6de8b69b72778cf3798a4",
    },

    # Java
    "rules_jvm_external": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_jvm_external",
        "ref": "2.6.1",
        "sha256": "19fd7312feda452744c0b738260941f7be15bf9894aecdf7c81d19738cebb673",
    },
    "io_grpc_grpc_java": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-java",
        "ref": "v1.23.0",
        "sha256": "9618a6f4ec0f2bdb77d9b6e01865af9796f370e63e1352210798bacfc99ccdac",
    },
    "javax_annotation_javax_annotation_api": {
        "type": "jvm_maven_import_external",
        "artifact": "javax.annotation:javax.annotation-api:1.2",
        "server_urls": ["http://central.maven.org/maven2"],
        "artifact_sha256": "5909b396ca3a2be10d0eea32c74ef78d816e1b4ead21de1d78de1f890d033e04",
        "licenses": ["reciprocal"], # CDDL License
    },
    "com_google_errorprone_error_prone_annotations": {
        "type": "jvm_maven_import_external",
        "artifact": "com.google.errorprone:error_prone_annotations:2.3.2",
        "server_urls": ["http://central.maven.org/maven2"],
        "artifact_sha256": "357cd6cfb067c969226c442451502aee13800a24e950fdfde77bcdb4565a668d",
        "licenses": ["notice"], # Apache 2.0
        "binds": [
            {
                "name": "error_prone_annotations",
                "actual": "@com_google_errorprone_error_prone_annotations//jar",
            },
        ]
    },

    # NodeJS
    "build_bazel_rules_nodejs": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_nodejs",
        "ref": "0.35.0",
        "sha256": "48be6c21d4ee7bf2a6c3dd35ac54f8ff430944b65ab7a43a9cd742f23c9a7279",
    },

    # Python
    "com_apt_itude_rules_pip": {
        "type": "github",
        "org": "apt-itude",
        "repo": "rules_pip",
        "ref": "ce667087818553cdc4b1a2258fc53df917c4f87c", # 2019-07-07
        "sha256": "5cabd6bfb9cef095d0d076faf5e7acd5698f7172e803059c21c4e700a07b131b",
    },
    "subpar": {
        "type": "github",
        "org": "google",
        "repo": "subpar",
        "ref": "2.0.0",
        "sha256": "b80297a1b8d38027a86836dbadc22f55dc3ecad56728175381aa6330705ac10f",
    },
    "six": {
        "type": "http",
        "urls": ["https://pypi.python.org/packages/source/s/six/six-1.12.0.tar.gz"],
        "sha256": "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73",
        "strip_prefix": "six-1.12.0",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.six",
    },

    # Ruby
    "com_github_yugui_rules_ruby": {
        "type": "github",
        "org": "yugui",
        "repo": "rules_ruby",
        "ref": "73479cdc6a34a8d940cc3c904badf7a2ae6bdc6d", # PR#8
        "sha256": "bd88b1aa144f70bb3f069ff3ddc5ddba032311ce27fb40b7276db694dcb63490",
    },

    # Rust
    "io_bazel_rules_rust": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_rust",
        "ref": "05bd7d1d1bd34225a6614fc131267181aee2b61e",
        "sha256": "55968c5377d9d9f4a5c61780c8a041d478eaac26d984d19fd589afaf12b353dc",
    },

    # Scala
    "io_bazel_rules_scala": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_scala",
        "ref": "f985e5e0d6364970be8d6f15d262c8b0e0973d1b",
        "sha256": "4276b2ab877d6e1271825933eea00869248d32948d42770bfe4fedd491b2824c",
    },
    "com_github_scalapb_scalapb": {
        "type": "http",
        "urls": ["https://github.com/scalapb/ScalaPB/releases/download/v0.9.4/scalapbc-0.9.4.zip"],
        "sha256": "7fe84b201195cd437c4393d882d08cb6354f6f24804c2a782a5c3379a2beb48d",
        "strip_prefix": "scalapbc-0.9.4",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_scalapb_scalapb",
    },

    # Swift
    "com_github_apple_swift_swift_protobuf": {
        "type": "github",
        "org": "apple",
        "repo": "swift-protobuf",
        "ref": "1.6.0",
        "sha256": "33ab0124f9ebc31d44bd26f40e797a70de89d0b693ac17a3eb726c5ba02fa43b",
        "build_file": "@build_bazel_rules_swift//third_party:com_github_apple_swift_swift_protobuf/BUILD.overlay",
    },
}


def _generic_dependency(name, **kwargs):
    if name not in VERSIONS:
        fail("Name {} not in VERSIONS".format(name))
    dep = VERSIONS[name]

    existing_rules = native.existing_rules()
    if dep["type"] == "github":
        # Resolve ref and sha256
        ref = kwargs.get(name + "_ref", dep["ref"])
        sha256 = kwargs.get(name + "_sha256", dep["sha256"])

        # Fix GitHub naming quirk in path
        strippedRef = ref
        if strippedRef.startswith("v"):
            strippedRef = ref[1:]

        # Generate URLs
        urls = [
            "https://github.com/{}/{}/archive/{}.tar.gz".format(dep["org"], dep["repo"], ref),
        ]

        # Check for existing rule
        if name not in existing_rules:
            http_archive(
                name = name,
                strip_prefix = dep["repo"] + "-" + strippedRef,
                urls = urls,
                sha256 = sha256,
            )
        elif existing_rules[name]["kind"] != "http_archive":
            print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected http_archive".format(
                name, existing_rules[name]["kind"],
            ))
        elif existing_rules[name]["urls"] != tuple(urls):
            print("Dependency '{}' has already been declared with a different version. Found urls={}, expected {}".format(
                name, existing_rules[name]["urls"], tuple(urls)
            ))

    elif dep["type"] == "http":
        if name not in existing_rules:
            args = {k: v for k, v in dep.items() if k in ["urls", "sha256", "strip_prefix", "build_file", "build_file_content"]}
            http_archive(name = name, **args)
        elif existing_rules[name]["kind"] != "http_archive":
            print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected http_archive".format(
                name, existing_rules[name]["kind"],
            ))
        elif existing_rules[name]["urls"] != tuple(dep["urls"]):
            print("Dependency '{}' has already been declared with a different version. Found urls={}, expected {}".format(
                name, existing_rules[name]["urls"], tuple(dep["urls"])
            ))

    elif dep["type"] == "jvm_maven_import_external":
        if name not in existing_rules:
            args = {k: v for k, v in dep.items() if k in ["artifact", "server_urls", "artifact_sha256"]}
            jvm_maven_import_external(name = name, **args)
        elif existing_rules[name]["kind"] != "jvm_import_external":
            print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected jvm_import_external".format(
                name, existing_rules[name]["kind"],
            ))
        elif existing_rules[name]["artifact_sha256"] != dep["artifact_sha256"]:
            print("Dependency '{}' has already been declared with a different version. Found artifact_sha256={}, expected {}".format(
                name, existing_rules[name]["artifact_sha256"], dep["artifact_sha256"]
            ))

    else:
        fail("Unknown dependency type {}".format(dep))

    if "binds" in dep:
        for bind in dep["binds"]:
            if bind["name"] not in native.existing_rules():
                native.bind(
                    name = bind["name"],
                    actual = bind["actual"],
                )


# Write version data. Required for both upb and rules_rust
def _store_bazel_version(repository_ctx):
    repository_ctx.file("BUILD", "exports_files(['def.bzl'])")
    repository_ctx.file("bazel_version.bzl", "bazel_version = \"{}\"".format(native.bazel_version))
    repository_ctx.file("def.bzl", "BAZEL_VERSION='{}'".format(native.bazel_version))

bazel_version_repository = repository_rule(
    implementation = _store_bazel_version,
)


#
# Toolchains
#
def rules_proto_grpc_toolchains():
    check_bazel_minimum_version(MINIMUM_BAZEL_VERSION)
    native.register_toolchains(str(Label("//protobuf:protoc_toolchain")))


#
# Core
#
def rules_proto_grpc_dependencies(**kwargs):
    check_bazel_minimum_version(MINIMUM_BAZEL_VERSION)

    bazel_version_repository(
        name = "bazel_version"
    )

    rules_python(**kwargs)
    build_bazel_rules_swift(**kwargs)
    build_bazel_apple_support(**kwargs)
    bazel_skylib(**kwargs)

    com_google_protobuf(**kwargs)
    com_github_grpc_grpc(**kwargs)
    external_zlib(**kwargs)

def rules_python(**kwargs):
    _generic_dependency("rules_python", **kwargs)

def build_bazel_rules_swift(**kwargs):
    _generic_dependency("build_bazel_rules_swift", **kwargs)

def build_bazel_apple_support(**kwargs):
    _generic_dependency("build_bazel_apple_support", **kwargs)

def com_google_protobuf(**kwargs):
    _generic_dependency("com_google_protobuf", **kwargs)

def com_github_grpc_grpc(**kwargs):
    _generic_dependency("com_github_grpc_grpc", **kwargs)

def external_zlib(**kwargs):
    _generic_dependency("zlib", **kwargs)



#
# Misc
#
def bazel_skylib(**kwargs):
    _generic_dependency("bazel_skylib", **kwargs)

def com_github_bazelbuild_buildtools(**kwargs):
    _generic_dependency("com_github_bazelbuild_buildtools", **kwargs)


#
# Android
#
def build_bazel_rules_android(**kwargs):
    _generic_dependency("build_bazel_rules_android", **kwargs)

def com_google_guava_guava_android(**kwargs):
    _generic_dependency("com_google_guava_guava_android", **kwargs)

def com_google_protobuf_javalite(**kwargs):
    _generic_dependency("com_google_protobuf_javalite", **kwargs)


#
# Closure
#
def io_bazel_rules_closure(**kwargs):
    _generic_dependency("io_bazel_rules_closure", **kwargs)


#
# C Sharp
#
def io_bazel_rules_dotnet(**kwargs):
    _generic_dependency("io_bazel_rules_dotnet", **kwargs)


#
# D
#
def io_bazel_rules_d(**kwargs):
    _generic_dependency("io_bazel_rules_d", **kwargs)

def com_github_dcarp_protobuf_d(**kwargs):
    _generic_dependency("com_github_dcarp_protobuf_d", **kwargs)


#
# Go
#
def io_bazel_rules_go(**kwargs):
    _generic_dependency("io_bazel_rules_go", **kwargs)

def bazel_gazelle(**kwargs):
    _generic_dependency("bazel_gazelle", **kwargs)


#
# gRPC gateway
#
def grpc_ecosystem_grpc_gateway(**kwargs):
    _generic_dependency("grpc_ecosystem_grpc_gateway", **kwargs)


#
# gRPC web
#
def com_github_grpc_grpc_web(**kwargs):
    _generic_dependency("com_github_grpc_grpc_web", **kwargs)


#
# gRPC.js
#
def com_github_stackb_grpc_js(**kwargs):
    _generic_dependency("com_github_stackb_grpc_js", **kwargs)


#
# Java
#
def rules_jvm_external(**kwargs):
    _generic_dependency("rules_jvm_external", **kwargs)

def io_grpc_grpc_java(**kwargs):
    _generic_dependency("io_grpc_grpc_java", **kwargs)

def javax_annotation_javax_annotation_api(**kwargs):
    # Use //stub:javax_annotation for neverlink=1 support.
    _generic_dependency("javax_annotation_javax_annotation_api", **kwargs)

def com_google_errorprone_error_prone_annotations(**kwargs):
    # Use //stub:javax_annotation for neverlink=1 support.
    _generic_dependency("javax_annotation_javax_annotation_api", **kwargs)


#
# NodeJS
#
def build_bazel_rules_nodejs(**kwargs):
    _generic_dependency("build_bazel_rules_nodejs", **kwargs)


#
# Python
#
def com_apt_itude_rules_pip(**kwargs):
    _generic_dependency("com_apt_itude_rules_pip", **kwargs)

def subpar(**kwargs):
    _generic_dependency("subpar", **kwargs)

def six(**kwargs):
    _generic_dependency("six", **kwargs)


#
# Ruby
#
def com_github_yugui_rules_ruby(**kwargs):
    _generic_dependency("com_github_yugui_rules_ruby", **kwargs)


#
# Rust
#
def io_bazel_rules_rust(**kwargs):
    _generic_dependency("io_bazel_rules_rust", **kwargs)


#
# Scala
#
def io_bazel_rules_scala(**kwargs):
    _generic_dependency("io_bazel_rules_scala", **kwargs)

def com_github_scalapb_scalapb(**kwargs):
    _generic_dependency("com_github_scalapb_scalapb", **kwargs)


#
# Swift
#
def com_github_apple_swift_swift_protobuf(**kwargs):
    _generic_dependency("com_github_apple_swift_swift_protobuf", **kwargs)
