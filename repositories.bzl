"""Common dependencies for rules_proto_grpc."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("//internal:common.bzl", "check_bazel_minimum_version")

# Versions
MINIMUM_BAZEL_VERSION = "5.0.0"
ENABLE_VERSION_NAGS = False
PROTOBUF_VERSION = "21.5"  # When updating, also update protobuf-javascript, JS requirements, JS rulegen in js.go, Ruby requirements and C#/F# requirements
GRPC_VERSION = "1.48.0"  # When updating, also update grpc hash, grpc-java hash, Go repositories.bzl, Ruby requirements and C#/F# requirements
BUF_VERSION = "v1.6.0"
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
        "sha256": "4a7e87e4166c358c63342dddcde6312faee06ea9d5bb4e2fa87d3478076f6639",
    },
    "com_github_grpc_grpc": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc",
        "ref": "v{}".format(GRPC_VERSION),
        "sha256": "9b1f348b15a7637f5191e4e673194549384f2eccf01fcef7cc1515864d71b424",
    },
    "zlib": {
        "type": "http",
        "urls": [
            "https://mirror.bazel.build/zlib.net/zlib-1.2.12.tar.gz",
            "https://zlib.net/zlib-1.2.12.tar.gz",
        ],
        "sha256": "91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9",
        "strip_prefix": "zlib-1.2.12",
        "build_file": "@rules_proto_grpc//third_party:BUILD.bazel.zlib",
    },
    "rules_python": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_python",
        "ref": "0.10.2",
        "sha256": "a3a6e99f497be089f81ec082882e40246bfd435f52f4e82f37e89449b04573f6",
    },
    "build_bazel_rules_swift": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_swift",
        "ref": "1.1.0",
        "sha256": "0ad2023c3e6e8f960e4ae24da508fe5cc44032e04af9961478543a5f5802ce6e",
    },
    "bazel_skylib": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-skylib",
        "ref": "1.2.1",
        "sha256": "710c2ca4b4d46250cdce2bf8f5aa76ea1f0cba514ab368f2988f70e864cfaf51",
    },
    "rules_pkg": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_pkg",
        "ref": "0.7.0",
        "sha256": "e110311d898c1ff35f39829ae3ec56e39c0ef92eb44de74418982a114f51e132",
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
    "protoc_gen_buf_breaking_darwin_arm64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/{}/protoc-gen-buf-breaking-Darwin-arm64".format(BUF_VERSION)],
        "sha256": "4fb738f59809ac2b9c2b16588ad64758e3e8d76b126198b01c5b31acced8f5c2",
        "executable": True,
    },
    "protoc_gen_buf_breaking_darwin_x86_64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/{}/protoc-gen-buf-breaking-Darwin-x86_64".format(BUF_VERSION)],
        "sha256": "8b33bf3553a9e7b82816b3a2f9a598749c7c5107742b9cefeb303a7926a1ad52",
        "executable": True,
    },
    "protoc_gen_buf_breaking_linux_x86_64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/{}/protoc-gen-buf-breaking-Linux-x86_64".format(BUF_VERSION)],
        "sha256": "11c3ce3c919e372eb69df4012f7c2c59221c88fc1b6f3f62756d5521b22fc6a0",
        "executable": True,
    },
    "protoc_gen_buf_lint_darwin_arm64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/{}/protoc-gen-buf-lint-Darwin-arm64".format(BUF_VERSION)],
        "sha256": "c8edb0c818c16c4430a9ef227784b1eb695a343b4b5345817e707b57b3fc28f1",
        "executable": True,
    },
    "protoc_gen_buf_lint_darwin_x86_64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/{}/protoc-gen-buf-lint-Darwin-x86_64".format(BUF_VERSION)],
        "sha256": "2dc9f9ed5dbb98d10e469edec45cfb9c379f6943b7dc0272eacdeb93b62a4aa7",
        "executable": True,
    },
    "protoc_gen_buf_lint_linux_x86_64": {
        "type": "http_file",
        "urls": ["https://github.com/bufbuild/buf/releases/download/{}/protoc-gen-buf-lint-Linux-x86_64".format(BUF_VERSION)],
        "sha256": "88f741a66583bfb408ed5465cbb4500c77fa972b0850d9a7d7334c6046820b69",
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
        "ref": "0b7ae93fa81b7327a655118da0581db5ebbe0b8d",
        "sha256": "715b072dbf52491c0505ad9059b72fdfacfe78cdca754f455f5ec568b6209c16",
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
    "protoc_gen_doc_darwin_arm64": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.1/protoc-gen-doc_1.5.1_darwin_arm64.tar.gz"],
        "sha256": "6e8c737d9a67a6a873a3f1d37ed8bb2a0a9996f6dcf6701aa1048c7bd798aaf9",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },
    "protoc_gen_doc_darwin_x86_64": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.1/protoc-gen-doc_1.5.1_darwin_amd64.tar.gz"],
        "sha256": "f429e5a5ddd886bfb68265f2f92c1c6a509780b7adcaf7a8b3be943f28e144ba",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },
    "protoc_gen_doc_linux_x86_64": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.1/protoc-gen-doc_1.5.1_linux_amd64.tar.gz"],
        "sha256": "47cd72b07e6dab3408d686a65d37d3a6ab616da7d8b564b2bd2a2963a72b72fd",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },
    "protoc_gen_doc_windows_x86_64": {
        "type": "http",
        "urls": ["https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.1/protoc-gen-doc_1.5.1_windows_amd64.tar.gz"],
        "sha256": "8acf0bf64eda29183b4c6745c3c6a12562fd9a8ab08d61788cf56e6659c66b3b",
        "build_file_content": """exports_files(glob(["protoc-gen-doc*"]))""",
    },

    # Go
    # When updating, update go version for go_register_toolchains in WORKSPACE and go.go
    "io_bazel_rules_go": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_go",
        "ref": "v0.34.0",
        "sha256": "b1fb0e70834df1504f06fd0195260f45b296d25799684036b73425b8913ccfb0",
    },
    "bazel_gazelle": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "bazel-gazelle",
        "ref": "v0.24.0",  # 0.25.0+ has issues with "No dependencies were provided": https://github.com/bazelbuild/bazel-gazelle/issues/1217
        "sha256": "fc4c319b9e32ea44be8a5e1a46746d93e8b6a8b104baf7cb6a344a0a08386fed",
    },

    # grpc-gateway
    "grpc_ecosystem_grpc_gateway": {
        "type": "github",
        "org": "grpc-ecosystem",
        "repo": "grpc-gateway",
        "ref": "v2.11.3",
        "sha256": "6b180623ed23e545d66b05bd0e32d87623048c5d37dcda4f6aaab21b84170d46",
    },

    # Java
    "io_grpc_grpc_java": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-java",
        "ref": "v{}".format(GRPC_VERSION),
        "sha256": "f6ecacf924da06aa1c97b4339a74e8d4e345af083b5d197d0758c90881205108",
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
        "urls": ["https://github.com/bazelbuild/rules_nodejs/releases/download/5.5.2/rules_nodejs-5.5.2.tar.gz"],
        "sha256": "c78216f5be5d451a42275b0b7dc809fb9347e2b04a68f68bad620a2b01f5c774",
    },
    "com_google_protobuf_javascript": {
        "type": "github",
        "org": "protocolbuffers",
        "repo": "protobuf-javascript",
        "ref": "a428c58273abad07c66071d9753bc4d1289de426",  # TODO: 3.21.0 broken
        "sha256": "08e8aa6b4f434a5364bdef69cd129792677f8b241cdebfa7c10bb43d618e0e05",
    },
    "grpc_web_plugin_darwin": {
        "type": "http_file",  # When updating, also update in package.json and vice-versa
        "urls": ["https://github.com/grpc/grpc-web/releases/download/1.3.1/protoc-gen-grpc-web-1.3.1-darwin-x86_64"],
        "sha256": "466ffe6d2096a2e09823ad02170a90a3e9f79d24094ec8ddcaf6c6d4e673aa2c",
        "executable": True,
    },
    "grpc_web_plugin_linux": {
        "type": "http_file",  # When updating, also update in package.json and vice-versa
        "urls": ["https://github.com/grpc/grpc-web/releases/download/1.3.1/protoc-gen-grpc-web-1.3.1-linux-x86_64"],
        "sha256": "12d3cfefb22e077251e6d1fae2aeaafd7a66518898397c667ba69cdd1260e72a",
        "executable": True,
    },
    "grpc_web_plugin_windows": {
        "type": "http_file",  # When updating, also update in package.json and vice-versa
        "urls": ["https://github.com/grpc/grpc-web/releases/download/1.3.1/protoc-gen-grpc-web-1.3.1-windows-x86_64.exe"],
        "sha256": "f7f3d3b8ddcc7f0f8e432e744768682c070491fc1dcacb922343ec8f39c0d115",
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
        "ref": "0.9.0",
        "sha256": "ba6ef62c8db01a86512b8bc8bc464b344d1c18c6b83aefe9440bb89f0d4adc8d",
    },

    # Scala
    "io_bazel_rules_scala": {
        "type": "github",
        "org": "bazelbuild",
        "repo": "rules_scala",
        "ref": "e14f2528689efd04e54a332d2f27936eac45e2cb",
        "sha256": "e185041a629ba33ed89febd4703363c236073e7a236b23bdc1b4cfbdc518f701",
    },

    # Swift
    "com_github_grpc_grpc_swift": {
        "type": "github",
        "org": "grpc",
        "repo": "grpc-swift",
        "ref": "1.6.0",
        "sha256": "f08729b656dd1e7c1e273f2362a907d3ce6721348a4cd347574cd1ef28a95983",
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
    rules_pkg(**kwargs)

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

def rules_pkg(**kwargs):
    _generic_dependency("rules_pkg", **kwargs)

#
# Android
#
def build_bazel_rules_android(**kwargs):
    _generic_dependency("build_bazel_rules_android", **kwargs)

#
# Buf
#
def protoc_gen_buf_breaking_darwin_arm64(**kwargs):
    _generic_dependency("protoc_gen_buf_breaking_darwin_arm64", **kwargs)

def protoc_gen_buf_breaking_darwin_x86_64(**kwargs):
    _generic_dependency("protoc_gen_buf_breaking_darwin_x86_64", **kwargs)

def protoc_gen_buf_breaking_linux_x86_64(**kwargs):
    _generic_dependency("protoc_gen_buf_breaking_linux_x86_64", **kwargs)

def protoc_gen_buf_lint_darwin_arm64(**kwargs):
    _generic_dependency("protoc_gen_buf_lint_darwin_arm64", **kwargs)

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
def protoc_gen_doc_darwin_arm64(**kwargs):
    _generic_dependency("protoc_gen_doc_darwin_arm64", **kwargs)

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

def com_google_protobuf_javascript(**kwargs):
    _generic_dependency("com_google_protobuf_javascript", **kwargs)

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
