load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("//internal:common.bzl", "check_bazel_minimum_version")

# Versions
MINIMUM_BAZEL_VERSION = "1.0.0"
ENABLE_VERSION_NAGS = False
VERSIONS = {
    # Core
    "com_google_protobuf": { # When updating, also update Node.js requirements, Ruby requirements and C# requirements
        "type": "github",
        "org": "protocolbuffers",
        "repo": "protobuf",
        "ref": "v3.11.0",
        "sha256": "6d356a6279cc76d2d5c4dfa6541641264b59eae0bc96b852381361e3400d1f1c",
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
        "ref": "v1.25.0",
        "sha256": "ffbe61269160ea745e487f79b0fd06b6edd3d50c6d9123f053b5634737cf2f69",
    },
    "zlib": {
        "type": "http",
        "urls": [
            "https://mirror.bazel.build/zlib.net/zlib-1.2.11.tar.gz",
            "https://zlib.net/zlib-1.2.11.tar.gz",
        ],
        "sha256": "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
        "strip_prefix": "zlib-1.2.11",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.zlib",
    },
    "rules_python": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_python",
        "ref": "94677401bc56ed5d756f50b441a6a5c7f735a6d4",
        "sha256": "acbd018f11355ead06b250b352e59824fbb9e77f4874d250d230138231182c1c",
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
        "ref": "0.7.2",
        "sha256": "519a3bc32132f7b5780e82c2fc6ad2a78d4b28b81561e6fd7b7e0b14ea110074",
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
        "sha256": "5ec71602e9b458b01717fab1d37492154c1c12ea83f881c745dbd88e9b2098d8",
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
        "ref": "0.10.0",
        "sha256": "7d206c2383811f378a5ef03f4aacbcf5f47fd8650f6abbc3fa89f3a27dd8b176",
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
        "ref": "v0.20.2",
        "sha256": "c92e9be17b8f5d3a5cd4b0549a92c4835a37388b50f007c9cdec9f4ad7baf1f4",
    },
    "bazel_gazelle": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-gazelle",
        "ref": "v0.19.1",
        "sha256": "d987004a72697334a095bbaa18d615804a28280201a50ed6c234c40ccc41e493",
    },

    # gRPC gateway
    "grpc_ecosystem_grpc_gateway": {
        "type": "github",
        "org": "grpc-ecosystem",
        "repo": "grpc-gateway",
        "ref": "v1.12.1",
        "sha256": "8a3ce7fa981dd21c0693fb2922457053a7c2e5a5687e22d9f19fe7c35520c35e",
    },

    # gRPC web
    "com_github_grpc_grpc_web": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-web",
        "ref": "1.0.7",
        "sha256": "04460e28ffa80bfc797a8758da10ba40107347ef0af8e9cc065ade10398da4bb",
    },

    # Java
    "rules_jvm_external": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_jvm_external",
        "ref": "2.10",
        "sha256": "5c1b22eab26807d5286ada7392d796cbc8425d3ef9a57d114b79c5f8ef8aca7c",
    },
    "io_grpc_grpc_java": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-java",
        "ref": "v1.24.2",
        "sha256": "83bb3a29b0fcbf6d3242b5827e9e8d3683b4aad907628fcb9a37925dc9d7c867",
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
        "ref": "0.42.1",
        "sha256": "7061f4782999ddfe5dd9a6ffa1945843ed52d5e144ae84e656693e92544e8d41",
    },

    # Python
    "subpar": {
        "type": "github",
        "org": "google",
        "repo": "subpar",
        "ref": "2.0.0",
        "sha256": "b80297a1b8d38027a86836dbadc22f55dc3ecad56728175381aa6330705ac10f",
    },
    "six": {
        "type": "http",
        "urls": ["https://pypi.python.org/packages/source/s/six/six-1.13.0.tar.gz"],
        "sha256": "30f610279e8b2578cab6db20741130331735c781b56053c59c4076da27f06b66",
        "strip_prefix": "six-1.13.0",
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
        "ref": "3251240a915875fc1bb396a4c818472c46e52368",
        "sha256": "06c32fde6db017ac60af099fa17d4dd10ee13811db3f13dad847f7c21a93276f",
    },

    # Scala
    "io_bazel_rules_scala": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_scala",
        "ref": "e56840204179b1f668ba2f6f8f23f28d00d96794",
        "sha256": "4f22711a0e91cbe557ea8402e0a2ad95509db52ead995215f6abd1b94372d278",
    },
    "com_github_scalapb_scalapb": {
        "type": "http",
        "urls": ["https://github.com/scalapb/ScalaPB/releases/download/v0.9.4/scalapbc-0.9.4.zip"],
        "sha256": "7fe84b201195cd437c4393d882d08cb6354f6f24804c2a782a5c3379a2beb48d",
        "strip_prefix": "scalapbc-0.9.4",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_scalapb_scalapb",
    },
    "scalapb_runtime": {
        "type": "jvm_maven_import_external",
        "artifact": "com.thesamet.scalapb:scalapb-runtime_2.12:jar:0.9.4",
        "server_urls": ["http://central.maven.org/maven2"],
        "artifact_sha256": "151b9e353980bc266d4630ed1c2792712e109b02942211115afe97232b15f694",
    },
    "scalapb_runtime_grpc": {
        "type": "jvm_maven_import_external",
        "artifact": "com.thesamet.scalapb:scalapb-runtime-grpc_2.12:jar:0.9.4",
        "server_urls": ["http://central.maven.org/maven2"],
        "artifact_sha256": "249467665168edf58690e81af17b1efb4fbdfd1c68f63b035c1ee5cbdc206eae",
    },
    "scalapb_lenses": {
        "type": "jvm_maven_import_external",
        "artifact": "com.thesamet.scalapb:lenses_2.12:jar:0.9.4",
        "server_urls": ["http://central.maven.org/maven2"],
        "artifact_sha256": "51a82005e64c15690aabfa1641047e584b98eb01157930639c83ecea55d32b42",
    },

    # Swift
    "com_github_apple_swift_swift_protobuf": {
        "type": "github",
        "org": "apple",
        "repo": "swift-protobuf",
        "ref": "1.7.0",
        "sha256": "33ab0124f9ebc31d44bd26f4ae797a70de89d0b693ac17a3eb726c5ba02fa43b",
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
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected http_archive".format(
                    name, existing_rules[name]["kind"],
                ))
        elif existing_rules[name]["urls"] != tuple(urls):
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different version. Found urls={}, expected {}".format(
                    name, existing_rules[name]["urls"], tuple(urls)
                ))

    elif dep["type"] == "http":
        if name not in existing_rules:
            args = {k: v for k, v in dep.items() if k in ["urls", "sha256", "strip_prefix", "build_file", "build_file_content"]}
            http_archive(name = name, **args)
        elif existing_rules[name]["kind"] != "http_archive":
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected http_archive".format(
                    name, existing_rules[name]["kind"],
                ))
        elif existing_rules[name]["urls"] != tuple(dep["urls"]):
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different version. Found urls={}, expected {}".format(
                    name, existing_rules[name]["urls"], tuple(dep["urls"])
                ))

    elif dep["type"] == "jvm_maven_import_external":
        if name not in existing_rules:
            args = {k: v for k, v in dep.items() if k in ["artifact", "server_urls", "artifact_sha256"]}
            jvm_maven_import_external(name = name, **args)
        elif existing_rules[name]["kind"] != "jvm_import_external":
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected jvm_import_external".format(
                    name, existing_rules[name]["kind"],
                ))
        elif existing_rules[name]["artifact_sha256"] != dep["artifact_sha256"]:
            if ENABLE_VERSION_NAGS:
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
def rules_proto_grpc_repos(**kwargs):
    check_bazel_minimum_version(MINIMUM_BAZEL_VERSION)

    bazel_version_repository(
        name = "bazel_version"
    )

    rules_python(**kwargs)
    build_bazel_rules_swift(**kwargs)
    build_bazel_apple_support(**kwargs)
    bazel_skylib(**kwargs)

    six(**kwargs)
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

def scalapb_runtime(**kwargs):
    _generic_dependency("scalapb_runtime", **kwargs)

def scalapb_runtime_grpc(**kwargs):
    _generic_dependency("scalapb_runtime_grpc", **kwargs)

def scalapb_lenses(**kwargs):
    _generic_dependency("scalapb_lenses", **kwargs)


#
# Swift
#
def com_github_apple_swift_swift_protobuf(**kwargs):
    _generic_dependency("com_github_apple_swift_swift_protobuf", **kwargs)
