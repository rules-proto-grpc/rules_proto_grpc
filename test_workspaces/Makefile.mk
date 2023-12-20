.PHONY: test_workspace_absolute_strip_import_prefix
test_workspace_absolute_strip_import_prefix:
	cd test_workspaces/absolute_strip_import_prefix; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_combined_strip_and_add_prefix
test_workspace_combined_strip_and_add_prefix:
	cd test_workspaces/combined_strip_and_add_prefix; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_common_cpp_library
test_workspace_common_cpp_library:
	cd test_workspaces/common_cpp_library; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_exclusions
test_workspace_exclusions:
	cd test_workspaces/exclusions; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_generated_proto
test_workspace_generated_proto:
	cd test_workspaces/generated_proto; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_go_fixer
test_workspace_go_fixer:
	cd test_workspaces/go_fixer; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_go_importpath
test_workspace_go_importpath:
	cd test_workspaces/go_importpath; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_import_prefix
test_workspace_import_prefix:
	cd test_workspaces/import_prefix; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_nested_output_directory
test_workspace_nested_output_directory:
	cd test_workspaces/nested_output_directory; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_objc_capitalisation
test_workspace_objc_capitalisation:
	cd test_workspaces/objc_capitalisation; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_python3_grpc
test_workspace_python3_grpc:
	cd test_workspaces/python3_grpc; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_python_dashes
test_workspace_python_dashes:
	cd test_workspaces/python_dashes; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_python_deps
test_workspace_python_deps:
	cd test_workspaces/python_deps; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_python_dots
test_workspace_python_dots:
	cd test_workspaces/python_dots; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_relative_strip_import_prefix
test_workspace_relative_strip_import_prefix:
	cd test_workspaces/relative_strip_import_prefix; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_shared_proto
test_workspace_shared_proto:
	cd test_workspaces/shared_proto; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: test_workspace_special_characters
test_workspace_special_characters:
	cd test_workspaces/special_characters; \
	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

.PHONY: all_test_workspaces
all_test_workspaces: test_workspace_absolute_strip_import_prefix test_workspace_combined_strip_and_add_prefix test_workspace_common_cpp_library test_workspace_exclusions test_workspace_generated_proto test_workspace_go_fixer test_workspace_go_importpath test_workspace_import_prefix test_workspace_nested_output_directory test_workspace_objc_capitalisation test_workspace_python3_grpc test_workspace_python_dashes test_workspace_python_deps test_workspace_python_dots test_workspace_relative_strip_import_prefix test_workspace_shared_proto test_workspace_special_characters
