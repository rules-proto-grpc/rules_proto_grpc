#!/usr/bin/env bash
set -euo pipefail

readonly repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

export USE_BAZEL_VERSION="${USE_BAZEL_VERSION:-9.1.1}"

readonly compatibility_flags=(
  "--cxxopt=-std=c++17"
  "--host_cxxopt=-std=c++17"
  "--features=-layering_check"
  "--java_runtime_version=remotejdk_21"
  "--tool_java_runtime_version=remotejdk_21"
)

if [[ -n "${BAZEL_EXTRA_FLAGS:-}" ]]; then
  export BAZEL_EXTRA_FLAGS="${BAZEL_EXTRA_FLAGS} ${compatibility_flags[*]}"
else
  export BAZEL_EXTRA_FLAGS="${compatibility_flags[*]}"
fi

bazel version | grep -E "^Build label: 9\\."

if git grep -n -E "34\\.0\\.bcr\\.1|4\\.34\\.0|8\\.15\\.2|v31\\.1|1\\.78\\.0|1\\.76\\.0" -- \
  "*.bzl" "*.bazel" "*.template" >/tmp/rules_proto_grpc_stale_pins.txt; then
  cat /tmp/rules_proto_grpc_stale_pins.txt
  echo "Found stale Bazel/protobuf compatibility pins" >&2
  exit 1
fi

targets=("$@")
if [[ ${#targets[@]} -eq 0 ]]; then
  targets=(
    buf_examples
    cpp_examples
    csharp_examples
    doc_examples
    go_examples
    grpc_gateway_examples
    java_examples
    js_examples
    python_examples
    rust_examples
    scala_examples
    all_test_workspaces
  )

  if [[ "$(uname -s)" == "Darwin" ]]; then
    targets+=(
      objc_examples
      swift_examples
    )
  fi
fi

for target in "${targets[@]}"; do
  make "${target}"
done
