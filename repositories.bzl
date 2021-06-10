"""Common dependencies for rules_proto_grpc."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("//internal:common.bzl", "check_bazel_minimum_version")

# Versions
MINIMUM_BAZEL_VERSION = "3.0.0"
ENABLE_VERSION_NAGS = False
VERSIONS = {
    # Core
    "rules_proto": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_proto",
        "ref": "f7a30f6f80006b591fa7c437fe5a951eb10bcbcf",
        "sha256": "9fc210a34f0f9e7cc31598d109b5d069ef44911a82f507d5a88716db171615a8",
    },
    "com_google_protobuf": {
        # When updating, also update JS requirements, JS readme, Ruby requirements and C# requirements
        "type": "github",
        "org": "protocolbuffers",
        "repo": "protobuf",
        "ref": "v3.17.3",
        "sha256": "c6003e1d2e7fefa78a3039f19f383b4f3a61e81be8c19356f85b6461998ad3db",
    },
    "com_github_grpc_grpc": {
        # When updating, also update Go repositories.bzl, JS requirements, JS readme, Ruby requirements and C# requirements
        "type": "github",
        "org": "grpc",
        "repo": "grpc",
        "ref": "v1.38.0",
        "sha256": "abd9e52c69000f2c051761cfa1f12d52d8b7647b6c66828a91d462e796f2aede",
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
        "ref": "f1b6b742254ec11f9e7bd6bff19ad2b327107a45",
        "sha256": "56bae84082f326c5d51fe63a0929a825ae6f415ff7e3e49df20ba799dca62a7f",
    },
    "build_bazel_rules_swift": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_swift",
        "ref": "0.22.0",
        "sha256": "4f9872986eb608c34e2884bd2f2f66f8cce628fd8ed7f2fe690aff574bdb86b7",
    },
    "bazel_skylib": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-skylib",
        "ref": "1.0.3",
        "sha256": "7ac0fa88c0c4ad6f5b9ffb5e09ef81e235492c873659e6bb99efb89d11246bcb",
    },

    # Android
    "build_bazel_rules_android": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_android",
        "ref": "9ab1134546364c6de84fc6c80b4202fdbebbbb35",
        "sha256": "f329928c62ade05ceda72c4e145fd300722e6e592627d43580dd0a8211c14612",
    },

    # Buf
    "protoc_gen_buf_breaking_darwin": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/v0.43.2/protoc-gen-buf-breaking-Darwin-x86_64"],
        "sha256": "6e1e4f071e6a3c96e4a3b198125b8149214617bb42fc240bb79b2de7906636c0",
        "executable": True,
    },
    "protoc_gen_buf_breaking_linux": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/v0.43.2/protoc-gen-buf-breaking-Linux-x86_64"],
        "sha256": "76664b850cc6b2b2c41e96b578c3d4a8c1c0e16ce267538b280e1112d71b3344",
        "executable": True,
    },
    "protoc_gen_buf_lint_darwin": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/v0.43.2/protoc-gen-buf-lint-Darwin-x86_64"],
        "sha256": "88be34101cdeaf313fab9148bc74f87505a8cbbf9af3fb058dae50178e2cbd51",
        "executable": True,
    },
    "protoc_gen_buf_lint_linux": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/v0.43.2/protoc-gen-buf-lint-Linux-x86_64"],
        "sha256": "9e897a52741772aa275513c7d829e107db8f315212cb88f75368ca5b11af0758",
        "executable": True,
    },

    # C
    "upb": {
        "type": "github",
        "org": "protocolbuffers",
        "repo": "upb",
        "ref": "eb0fdda14b7b211872507a66f7d988f7c24a44c9",
        "sha256": "843d0729a0cb53fa2afb46b1c262438beb7477696f31e2fbfd84de97a710f2f1",
    },

    # C#/F#
    "io_bazel_rules_dotnet": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_dotnet",
        "ref": "16a8cfb1895450a75727f85f5f5bde4cff1bf6b6",
        "sha256": "b0e1382115d5dfa2db1dad0b7e72f3d02d930828df113d007121823d1386bfb6",
    },

    # D
    "io_bazel_rules_d": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_d",
        "ref": "40c63a7bd74036be3edaf782d34269c2debed5fd",
        "sha256": "e9a1368f0bb3a513b839f14df8d753d42ae81b437ff107526ad62eebd2b24332",
    },
    "com_github_dcarp_protobuf_d": {
        "type": "http",
        "urls": ["https://github.com/dcarp/protobuf-d/archive/v0.6.2.tar.gz"],
        "sha256": "5509883fa042aa2e1c8c0e072e52c695fb01466f572bd828bcde06347b82d465",
        "strip_prefix": "protobuf-d-0.6.2",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_dcarp_protobuf_d",
    },

    # Doc
    "protoc_gen_doc_darwin": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.4.1/protoc-gen-doc-1.4.1.darwin-amd64.go1.15.2.tar.gz"],
        "sha256": "a5f7ad62d495b5a97a907b5445c23524a9cc312eeab486a79299819286a3f6b0",
        "strip_prefix": "protoc-gen-doc-1.4.1.darwin-amd64.go1.15.2",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },
    "protoc_gen_doc_linux": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.4.1/protoc-gen-doc-1.4.1.linux-amd64.go1.15.2.tar.gz"],
        "sha256": "2e476c67063af55a5608f7ef876260eb4ca400b330b762a4f59096db501c5c8c",
        "strip_prefix": "protoc-gen-doc-1.4.1.linux-amd64.go1.15.2",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },
    "protoc_gen_doc_windows": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.4.1/protoc-gen-doc-1.4.1.windows-amd64.go1.15.2.tar.gz"],
        "sha256": "6ac742671b81d339768a683dfb9a4c03ea5eaa0b6880d47df46819ea1ddb2653",
        "strip_prefix": "protoc-gen-doc-1.4.1.windows-amd64.go1.15.2",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },

    # Go
    "io_bazel_rules_go": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_go",
        "ref": "v0.27.0",
        "sha256": "8a9bcbd7663c994b96faea2518f61737571959f0b7aa5c626559ffff788efdb0",
    },
    "bazel_gazelle": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-gazelle",
        "ref": "v0.23.0",
        "sha256": "0ba1c56b5df496c07b8d258fb97193668baa0b3a93e4dbb0a1559a6dcbd7d057",
    },

    # grpc-gateway
    "grpc_ecosystem_grpc_gateway": {
        "type": "github",
        "org": "grpc-ecosystem",
        "repo": "grpc-gateway",
        "ref": "v2.4.0",
        "sha256": "cc869fdaaba4ce69ddc976cb8d0ced041e392f093062f0a13ba2df2ede57a996",
    },

    # Java
    "io_grpc_grpc_java": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-java",
        "ref": "v1.38.0",
        "sha256": "c454e068bfb5d0b5bdb5e3d7e32cd1fc34aaf22202855e29e048f3ad338e57b2",
    },
    "rules_jvm_external": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_jvm_external",
        "ref": "4.1",
        "sha256": "995ea6b5f41e14e1a17088b727dcff342b2c6534104e73d6f06f1ae0422c2308",
    },

    # JavaScript
    # Use .tar.gz in release assets, not the Github generated source .tar.gz
    "build_bazel_rules_nodejs": {
        "type": "http",
        "urls": ["https://github.com/bazelbuild/rules_nodejs/releases/download/3.6.0/rules_nodejs-3.6.0.tar.gz"],
        "sha256": "0fa2d443571c9e02fcb7363a74ae591bdcce2dd76af8677a95965edf329d778a",
    },
    "grpc_web_plugin_darwin": {
        "type": "http_file",  # When updating, also update in package.json and vice-versa
        "urls": ["https://github.com/grpc/grpc-web/releases/download/1.2.1/protoc-gen-grpc-web-1.2.1-darwin-x86_64"],
        "sha256": "81bb5d4d3ae0340568fd0739402c052f32476dd520b44355e5032b556a3bc0da",
        "executable": True,
    },
    "grpc_web_plugin_linux": {
        "type": "http_file",  # When updating, also update in package.json and vice-versa
        "urls": ["https://github.com/grpc/grpc-web/releases/download/1.2.1/protoc-gen-grpc-web-1.2.1-linux-x86_64"],
        "sha256": "6ce1625db7902d38d38d83690ec578c182e9cf2abaeb58d3fba1dae0c299c597",
        "executable": True,
    },
    "grpc_web_plugin_windows": {
        "type": "http_file",  # When updating, also update in package.json and vice-versa
        "urls": ["https://github.com/grpc/grpc-web/releases/download/1.2.1/protoc-gen-grpc-web-1.2.1-windows-x86_64.exe"],
        "sha256": "5886b4c9886dfdbfd1c7c2f26a15c396c6662b9f1acf9b6d8efbd490bc3736db",
        "executable": True,
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
    "bazelruby_rules_ruby": {
        "type": "github",
        "org": "bazelruby",
        "repo": "rules_ruby",
        "ref": "v0.4.1",
        "sha256": "5a9660a2ef8dc115b192aa89c94e624378078988e2e9bff6792e61b02b390320",
    },

    # Rust
    "rules_rust": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_rust",
        "ref": "087bcab8154f5c0d79980ad32cb6ffb8158de649",
        "sha256": "b47bb71d60ed92ea8c07b9c841291af38e0f265b7f1b37912c90cce0428c2ce7",
    },

    # Scala
    "io_bazel_rules_scala": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_scala",
        "ref": "2b7edf77c153f3fbb882005e0f199f95bd322880",
        "sha256": "e749a8ade22828419e734e2fb94d8af747bcae1b35c1b664eff1f2dc35c1ab76",
    },
    "com_github_scalapb_scalapb": {
        "type": "http",
        "urls": ["https://github.com/scalapb/ScalaPB/releases/download/v0.9.7/scalapbc-0.9.7.zip"],  # Matches version in https://github.com/bazelbuild/rules_scala/blob/master/scala_proto/private/scala_proto_default_repositories.bzl
        "sha256": "623f626e97cca119b2a12c4e1d9a3c85aab9f9fd6dcb8dc22b4f704b824da94e",
        "strip_prefix": "scalapbc-0.9.7",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_scalapb_scalapb",
    },

    # Swift
    "com_github_grpc_grpc_swift": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-swift",
        "ref": "1.1.0",
        "sha256": "e4e83b9a9b9ca88f7c14bd424acb56c10e4f212f31bb2533a7f07fa524fcb780",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_grpc_grpc_swift",
    },
    "com_github_apple_swift_log": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-log",
        "ref": "1.4.0",
        "sha256": "057fb5fd7e7f60a368c0cd4a93cd5ecce701031d8ccafb7973b3635415d2e368",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_log",
    },
    "com_github_apple_swift_nio": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio",
        "ref": "2.25.1",
        "sha256": "ddaeaba8f94d4480a4607ce8f262aa654649632bdf51d280beebf053c8f37b2c",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio",
    },
    "com_github_apple_swift_nio_extras": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio-extras",
        "ref": "1.7.0",
        "sha256": "b718ee9fb24c1f0fa77a54747eba472e50067b90d5df6f2b67cfdea2036b0ee0",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio_extras",
    },
    "com_github_apple_swift_nio_http2": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio-http2",
        "ref": "1.16.2",
        "sha256": "af65870424c6e0eb643365278886d0c5358f6700eae2255f11dbf5b10f90b567",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio_http2",
    },
    "com_github_apple_swift_nio_ssl": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio-ssl",
        "ref": "2.10.2",
        "sha256": "700c69f5496ae473164a338677e07f826eb24d7d3808d6e0fdcf50f27df0614d",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio_ssl",
    },
    "com_github_apple_swift_nio_transport_services": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio-transport-services",
        "ref": "1.9.1",
        "sha256": "2f0283647d8e17dcea6d4b6454c915d10c4c0106c7025d233aec0aaf4a3f2255",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio_transport_services",
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

        # Fix GitHub naming normalisation in path
        stripped_ref = ref
        if stripped_ref.startswith("v"):
            stripped_ref = ref[1:]
        stripped_ref = stripped_ref.replace("@", "-")

        # Generate URLs
        urls = [
            "https://github.com/{}/{}/archive/{}.tar.gz".format(dep["org"], dep["repo"], ref),
        ]

        # Check for existing rule
        if name not in existing_rules:
            http_archive(
                name = name,
                strip_prefix = dep["repo"] + "-" + stripped_ref,
                urls = urls,
                sha256 = sha256,
                **{k: v for k, v in dep.items() if k in ["build_file", "patch_cmds"]}
            )
        elif existing_rules[name]["kind"] != "http_archive":
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected http_archive".format(
                    name,
                    existing_rules[name]["kind"],
                ))  # buildifier: disable=print
        elif existing_rules[name]["urls"] != tuple(urls):
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different version. Found urls={}, expected {}".format(
                    name,
                    existing_rules[name]["urls"],
                    tuple(urls),
                ))  # buildifier: disable=print

    elif dep["type"] == "http":
        if name not in existing_rules:
            args = {k: v for k, v in dep.items() if k in ["urls", "sha256", "strip_prefix", "build_file", "build_file_content"]}
            http_archive(name = name, **args)
        elif existing_rules[name]["kind"] != "http_archive":
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected http_archive".format(
                    name,
                    existing_rules[name]["kind"],
                ))  # buildifier: disable=print
        elif existing_rules[name]["urls"] != tuple(dep["urls"]):
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different version. Found urls={}, expected {}".format(
                    name,
                    existing_rules[name]["urls"],
                    tuple(dep["urls"]),
                ))  # buildifier: disable=print

    elif dep["type"] == "http_file":
        if name not in existing_rules:
            args = {k: v for k, v in dep.items() if k in ["urls", "sha256", "executable"]}
            http_file(name = name, **args)
        elif existing_rules[name]["kind"] != "http_file":
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected http_file".format(
                    name,
                    existing_rules[name]["kind"],
                ))  # buildifier: disable=print
        elif existing_rules[name]["urls"] != tuple(dep["urls"]):
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different version. Found urls={}, expected {}".format(
                    name,
                    existing_rules[name]["urls"],
                    tuple(dep["urls"]),
                ))  # buildifier: disable=print

    elif dep["type"] == "local":
        if name not in existing_rules:
            args = {k: v for k, v in dep.items() if k in ["path"]}
            native.local_repository(name = name, **args)
        elif existing_rules[name]["kind"] != "local_repository":
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different rule kind. Found {}, expected local_repository".format(
                    name,
                    existing_rules[name]["kind"],
                ))  # buildifier: disable=print
        elif existing_rules[name]["path"] != dep["path"]:
            if ENABLE_VERSION_NAGS:
                print("Dependency '{}' has already been declared with a different version. Found path={}, expected {}".format(
                    name,
                    existing_rules[name]["path"],
                    dep["urls"],
                ))  # buildifier: disable=print

    else:
        fail("Unknown dependency type {}".format(dep))

    if "binds" in dep:
        for bind in dep["binds"]:
            if bind["name"] not in native.existing_rules():
                native.bind(
                    name = bind["name"],
                    actual = bind["actual"],
                )

#
# Toolchains
#
def rules_proto_grpc_toolchains(name = ""):
    """Register the rules_proto_grpc toolchains."""
    check_bazel_minimum_version(MINIMUM_BAZEL_VERSION)
    native.register_toolchains(str(Label("//protobuf:protoc_toolchain")))

#
# Core
#
def rules_proto_grpc_repos(**kwargs):
    """Load the rules_proto_grpc common dependencies."""  # buildifier: disable=function-docstring-args
    check_bazel_minimum_version(MINIMUM_BAZEL_VERSION)

    rules_proto(**kwargs)
    rules_python(**kwargs)
    build_bazel_rules_swift(**kwargs)
    bazel_skylib(**kwargs)

    six(**kwargs)
    com_google_protobuf(**kwargs)
    com_github_grpc_grpc(**kwargs)
    external_zlib(**kwargs)

def rules_proto(**kwargs):
    _generic_dependency("rules_proto", **kwargs)

def rules_python(**kwargs):
    _generic_dependency("rules_python", **kwargs)

def build_bazel_rules_swift(**kwargs):
    _generic_dependency("build_bazel_rules_swift", **kwargs)

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

#
# Android
#
def build_bazel_rules_android(**kwargs):
    _generic_dependency("build_bazel_rules_android", **kwargs)

#
# Buf
#
def protoc_gen_buf_breaking_darwin(**kwargs):
    _generic_dependency("protoc_gen_buf_breaking_darwin", **kwargs)

def protoc_gen_buf_breaking_linux(**kwargs):
    _generic_dependency("protoc_gen_buf_breaking_linux", **kwargs)

def protoc_gen_buf_lint_darwin(**kwargs):
    _generic_dependency("protoc_gen_buf_lint_darwin", **kwargs)

def protoc_gen_buf_lint_linux(**kwargs):
    _generic_dependency("protoc_gen_buf_lint_linux", **kwargs)

#
# C
#
def upb(**kwargs):
    _generic_dependency("upb", **kwargs)

#
# C#
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
# Doc
#
def protoc_gen_doc_darwin(**kwargs):
    _generic_dependency("protoc_gen_doc_darwin", **kwargs)

def protoc_gen_doc_linux(**kwargs):
    _generic_dependency("protoc_gen_doc_linux", **kwargs)

def protoc_gen_doc_windows(**kwargs):
    _generic_dependency("protoc_gen_doc_windows", **kwargs)

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
# Java
#
def io_grpc_grpc_java(**kwargs):
    _generic_dependency("io_grpc_grpc_java", **kwargs)

def rules_jvm_external(**kwargs):
    _generic_dependency("rules_jvm_external", **kwargs)

#
# JavaScript
#
def build_bazel_rules_nodejs(**kwargs):
    _generic_dependency("build_bazel_rules_nodejs", **kwargs)

def grpc_web_plugin_darwin(**kwargs):
    _generic_dependency("grpc_web_plugin_darwin", **kwargs)

def grpc_web_plugin_linux(**kwargs):
    _generic_dependency("grpc_web_plugin_linux", **kwargs)

def grpc_web_plugin_windows(**kwargs):
    _generic_dependency("grpc_web_plugin_windows", **kwargs)

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
def bazelruby_rules_ruby(**kwargs):
    _generic_dependency("bazelruby_rules_ruby", **kwargs)

#
# Rust
#
def rules_rust(**kwargs):
    _generic_dependency("rules_rust", **kwargs)

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
def com_github_grpc_grpc_swift(**kwargs):
    _generic_dependency("com_github_grpc_grpc_swift", **kwargs)

def com_github_apple_swift_log(**kwargs):
    _generic_dependency("com_github_apple_swift_log", **kwargs)

def com_github_apple_swift_nio(**kwargs):
    _generic_dependency("com_github_apple_swift_nio", **kwargs)

def com_github_apple_swift_nio_extras(**kwargs):
    _generic_dependency("com_github_apple_swift_nio_extras", **kwargs)

def com_github_apple_swift_nio_http2(**kwargs):
    _generic_dependency("com_github_apple_swift_nio_http2", **kwargs)

def com_github_apple_swift_nio_ssl(**kwargs):
    _generic_dependency("com_github_apple_swift_nio_ssl", **kwargs)

def com_github_apple_swift_nio_transport_services(**kwargs):
    _generic_dependency("com_github_apple_swift_nio_transport_services", **kwargs)
