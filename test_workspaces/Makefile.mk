test_workspace_exclusions:
	cd test_workspaces/exclusions; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_generated_proto:
	cd test_workspaces/generated_proto; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_go_importpath:
	cd test_workspaces/go_importpath; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_objc_capitalisation:
	cd test_workspaces/objc_capitalisation; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_python2_grpc:
	cd test_workspaces/python2_grpc; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_python3_grpc:
	cd test_workspaces/python3_grpc; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_python_dashes:
	cd test_workspaces/python_dashes; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_python_deps:
	cd test_workspaces/python_deps; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_readme_http_archive:
	cd test_workspaces/readme_http_archive; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_shared_proto:
	cd test_workspaces/shared_proto; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

test_workspace_strip_import_prefix:
	cd test_workspaces/strip_import_prefix; \
	bazel --batch test --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...

all_test_workspaces: test_workspace_exclusions test_workspace_generated_proto test_workspace_go_importpath test_workspace_objc_capitalisation test_workspace_python2_grpc test_workspace_python3_grpc test_workspace_python_dashes test_workspace_python_deps test_workspace_readme_http_archive test_workspace_shared_proto test_workspace_strip_import_prefix
