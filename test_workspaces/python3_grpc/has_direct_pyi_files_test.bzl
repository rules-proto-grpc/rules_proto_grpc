"""Test rule that verifies .pyi files are properly added to PyInfo.

This is a regression test for the fix that ensures python_proto_library with
generate_pyi=True properly populates PyInfo.direct_pyi_files, which is required
for type checkers and linters to resolve imports from generated protobuf modules.
"""

load('@bazel_skylib//lib:unittest.bzl', 'analysistest', 'asserts')

def _has_direct_pyi_files_test_impl(ctx):
    env = analysistest.begin(ctx)
    target = analysistest.target_under_test(env)

    # Ensure the target provides PyInfo
    asserts.true(env, PyInfo in target, 'target does not provide PyInfo')

    pyinfo = target[PyInfo]

    # Ensure the target PyInfo has direct_pyi_files attributes
    asserts.true(
        env,
        hasattr(pyinfo, 'direct_pyi_files'),
        'PyInfo does not have direct_pyi_files',
    )

    # Ensure the PyInfo.direct_pyi_files has at least one file
    asserts.true(
        env,
        len(pyinfo.direct_pyi_files.to_list()) > 0,
        'direct_pyi_files is empty',
    )

    return analysistest.end(env)

has_direct_pyi_files_test = analysistest.make(
    _has_direct_pyi_files_test_impl,
)
