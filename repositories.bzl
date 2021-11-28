"""Common dependencies for rules_proto_grpc."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("//internal:common.bzl", "check_bazel_minimum_version")

# Versions
MINIMUM_BAZEL_VERSION = "3.0.0"
ENABLE_VERSION_NAGS = False
PROTOBUF_VERSION = "3.19.1"  # When updating, also update JS requirements, JS rulegen in js.go, Ruby requirements and C#/F# requirements
GRPC_VERSION = "1.42.0"  # When updating, also update grpc hash, grpc-java hash, Go repositories.bzl, Ruby requirements and C#/F# requirements
VERSIONS = {
    # Core
    "rules_proto": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_proto",
        "ref": "4.0.0",
        "sha256": "66bfdf8782796239d3875d37e7de19b1d94301e8972b3cbd2446b332429b4df1",
    },
    "com_google_protobuf": {
        "type": "github",
        "org": "protocolbuffers",
        "repo": "protobuf",
        "ref": "v{}".format(PROTOBUF_VERSION),
        "sha256": "87407cd28e7a9c95d9f61a098a53cf031109d451a7763e7dd1253abf8b4df422",
    },
    "com_github_grpc_grpc": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc",
        "ref": "v{}".format(GRPC_VERSION),
        "sha256": "b2f2620c762427bfeeef96a68c1924319f384e877bc0e084487601e4cc6e434c",
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
        "ref": "0.5.0",
        "sha256": "a2fd4c2a8bcf897b718e5643040b03d9528ac6179f6990774b7c19b2dc6cd96b",
    },
    "build_bazel_rules_swift": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_swift",
        "ref": "0.24.0",
        "sha256": "56f79e7f1b075b0ba9c046db0ff290ad2b5696c47c683ea3faf414bf70e0fa9b",
    },
    "bazel_skylib": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-skylib",
        "ref": "1.1.1",
        "sha256": "07b4117379dde7ab382345c3b0f5edfc6b7cff6c93756eac63da121e0bbcc5de",
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
    "protoc_gen_buf_breaking_darwin_x86_64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/v0.56.0/protoc-gen-buf-breaking-Darwin-x86_64"],
        "sha256": "d7b12a2ccd663f00a068b19cbd2c1e81f4983ea33bd9a92980485e2c4693b75a",
        "executable": True,
    },
    "protoc_gen_buf_breaking_linux_x86_64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/v0.56.0/protoc-gen-buf-breaking-Linux-x86_64"],
        "sha256": "8463f63626327d81f72b4a2ad08b97898753a1ee14899e63728df9e2d110d5bf",
        "executable": True,
    },
    "protoc_gen_buf_lint_darwin_x86_64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/v0.56.0/protoc-gen-buf-lint-Darwin-x86_64"],
        "sha256": "3ff939636e5857f6fe3dcaeae816538fcee41cec66b10b62df5ccb65d0f79e7f",
        "executable": True,
    },
    "protoc_gen_buf_lint_linux_x86_64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/v0.56.0/protoc-gen-buf-lint-Linux-x86_64"],
        "sha256": "a7ab67a5bcc5906366bde424ba63fdcf604e07d4825e5720c8e5b3ab1530bbf7",
        "executable": True,
    },

    # C
    "upb": {
        "type": "github",
        "org": "protocolbuffers",
        "repo": "upb",
        "ref": "982f26aad42291064878ff64cb5a43d69723f91c",
        "sha256": "72d25e544bce0e350612184096ba4cd3454d63c048e5c18a682038c075c947a4",
    },

    # C#/F#
    "io_bazel_rules_dotnet": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_dotnet",
        "ref": "a07119eedbba3aee95cefda1f4db0d6a48c53071",
        "sha256": "75a9c7292e93a7c1b86f59cf457bea5c6e7d6899150e42dbb900ba755f1cbd84",
    },

    # D
    "io_bazel_rules_d": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_d",
        "ref": "73a7fc7d1884b029a4723bef2a0bb1f3f93c3fb6",
        "sha256": "53bbc348ac8e8e66003dee887b2536e45739f649196733eb936991e53fdaac72",
    },
    "com_github_dcarp_protobuf_d": {
        "type": "http",
        "urls": ["https://github.com/dcarp/protobuf-d/archive/v0.6.2.tar.gz"],
        "sha256": "5509883fa042aa2e1c8c0e072e52c695fb01466f572bd828bcde06347b82d465",
        "strip_prefix": "protobuf-d-0.6.2",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_dcarp_protobuf_d",
    },

    # Doc
    "protoc_gen_doc_darwin_x86_64": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.0/protoc-gen-doc-1.5.0.darwin-amd64.go1.16.6.tar.gz"],
        "sha256": "5b74f2b2b98f2c9a0978f42dc1d931e03fc51dd112e56ff9a6252f87fdb879c9",
        "strip_prefix": "protoc-gen-doc-1.5.0.darwin-amd64.go1.16.6",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },
    "protoc_gen_doc_linux_x86_64": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.0/protoc-gen-doc-1.5.0.linux-amd64.go1.16.6.tar.gz"],
        "sha256": "5455f066af1197a7cd3753eed5d8096b310b69b7b3d0f9b81c38223f4e0e5f10",
        "strip_prefix": "protoc-gen-doc-1.5.0.linux-amd64.go1.16.6",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },
    "protoc_gen_doc_windows_x86_64": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.0/protoc-gen-doc-1.5.0.windows-amd64.go1.16.6.tar.gz"],
        "sha256": "b6cc89ed9b9d037433f35a1ae5b593bf528db86e1d07f96533a9be33af9e9a6f",
        "strip_prefix": "protoc-gen-doc-1.5.0.windows-amd64.go1.16.6",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },

    # Go
    # When updating, update go version for go_register_toolchains in WORKSPACE and go.go
    "io_bazel_rules_go": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_go",
        "ref": "v0.29.0",
        "sha256": "7a89df64b765721be9bb73b3aa52c15209af3b6628cae4344b9516e8b21c2b8b",
    },
    "bazel_gazelle": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-gazelle",
        "ref": "v0.24.0",
        "sha256": "fc4c319b9e32ea44be8a5e1a46746d93e8b6a8b104baf7cb6a344a0a08386fed",
    },

    # grpc-gateway
    "grpc_ecosystem_grpc_gateway": {
        "type": "github",
        "org": "grpc-ecosystem",
        "repo": "grpc-gateway",
        "ref": "v2.7.0",
        "sha256": "34d56ba0e4fd6e341d8a9f8cf83c79796525d2175f53944081d17409a736c887",
    },

    # Java
    "io_grpc_grpc_java": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-java",
        "ref": "v{}".format(GRPC_VERSION),
        "sha256": "1289abd750bee2ebc80679435301e046d587bdf0c0802a76907119725d18eef0",
    },
    "rules_jvm_external": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_jvm_external",
        "ref": "4.2",
        "sha256": "2cd77de091e5376afaf9cc391c15f093ebd0105192373b334f0a855d89092ad5",
    },

    # JavaScript
    # Use .tar.gz in release assets, not the Github generated source .tar.gz
    "build_bazel_rules_nodejs": {
        "type": "http",
        "urls": ["https://github.com/bazelbuild/rules_nodejs/releases/download/4.2.0/rules_nodejs-4.2.0.tar.gz"],
        "sha256": "4e1a5633267a0ca1d550cced2919dd4148575c0bafd47608b88aea79c41b5ca3",
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
        "urls": ["https://pypi.python.org/packages/source/s/six/six-1.16.0.tar.gz"],
        "sha256": "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926",
        "strip_prefix": "six-1.16.0",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.six",
    },

    # Ruby
    "bazelruby_rules_ruby": {
        "type": "github",
        "org": "bazelruby",
        "repo": "rules_ruby",
        "ref": "v0.6.0",
        "sha256": "5035393cb5043d49ca9de78acb9e8c8622a193f6463a57ad02383a622b6dc663",
    },

    # Rust
    "rules_rust": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_rust",
        "ref": "75c63c36ab6a268d4de773437400d1d853723e84",
        "sha256": "7acea74e203e0590ecd483139b6cb55b60630227dfc2d0590c39f574ca1b3f8b",
    },

    # Scala
    "io_bazel_rules_scala": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_scala",
        "ref": "2437e40131072cadc1628726775ff00fa3941a4a",
        "sha256": "0701ee4e1cfd59702d780acde907ac657752fbb5c7d08a0ec6f58ebea8cd0efb",
    },

    # Swift
    "com_github_grpc_grpc_swift": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-swift",
        "ref": "1.4.1",
        "sha256": "17ac5ef8d1277d61818c8057c4cf3060d6bd4606827c116933d5b245fcfc5df7",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_grpc_grpc_swift",
    },
    "com_github_apple_swift_log": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-log",
        "ref": "1.4.2",
        "sha256": "de51662b35f47764b6e12e9f1d43e7de28f6dd64f05bc30a318cf978cf3bc473",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_log",
    },
    "com_github_apple_swift_nio": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio",
        "ref": "2.32.3",
        "sha256": "d6b41f67b907b458a4c1c86d3c8549835242cf40c49616b8d7531db002336835",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio",
    },
    "com_github_apple_swift_nio_extras": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio-extras",
        "ref": "1.10.2",
        "sha256": "2f37596dcf26532b867aee3dbd8c5354108a076174751f4e6a72a0b6506df05e",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio_extras",
    },
    "com_github_apple_swift_nio_http2": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio-http2",
        "ref": "1.18.3",
        "sha256": "497882ef4fd6980bd741a7c91783592bbee3bfac15278434cc17753c56d5dc63",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio_http2",
    },
    "com_github_apple_swift_nio_ssl": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio-ssl",
        "ref": "2.15.1",
        "sha256": "eefce9af7904b2e627219b9c78356d0bd3d659f06cdf2b45d931d832b21dcd46",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.com_github_apple_swift_nio_ssl",
    },
    "com_github_apple_swift_nio_transport_services": {
        # Dependency of com_github_grpc_grpc_swift
        "type": "github",
        "org": "apple",
        "repo": "swift-nio-transport-services",
        "ref": "1.11.3",
        "sha256": "1ac6867fb9251a3d4da2834b080c1cf90cf0fbdeccd66ef39b7a315e5d5612b6",
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
def protoc_gen_buf_breaking_darwin_x86_64(**kwargs):
    _generic_dependency("protoc_gen_buf_breaking_darwin_x86_64", **kwargs)

def protoc_gen_buf_breaking_linux_x86_64(**kwargs):
    _generic_dependency("protoc_gen_buf_breaking_linux_x86_64", **kwargs)

def protoc_gen_buf_lint_darwin_x86_64(**kwargs):
    _generic_dependency("protoc_gen_buf_lint_darwin_x86_64", **kwargs)

def protoc_gen_buf_lint_linux_x86_64(**kwargs):
    _generic_dependency("protoc_gen_buf_lint_linux_x86_64", **kwargs)

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
def protoc_gen_doc_darwin_x86_64(**kwargs):
    _generic_dependency("protoc_gen_doc_darwin_x86_64", **kwargs)

def protoc_gen_doc_linux_x86_64(**kwargs):
    _generic_dependency("protoc_gen_doc_linux_x86_64", **kwargs)

def protoc_gen_doc_windows_x86_64(**kwargs):
    _generic_dependency("protoc_gen_doc_windows_x86_64", **kwargs)

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
