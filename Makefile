# Run the rulegen system
.PHONY: rulegen
rulegen:
	bazel query '//examples/routeguide/... - attr(tags, manual, //examples/routeguide/...)' > available_tests.txt; \
	bazel run --run_under="cd $$PWD && " //tools/rulegen; \
	rm available_tests.txt;


# Publish a release
.PHONY: release
release:
	./tools/make_release.py


# Build docs locally
.PHONY: docs
docs:
	python3 -m sphinx -c docs -a -E -T -W --keep-going docs docs/build


# Apply buildifier
.PHONY: buildifier
buildifier:
	bazel run //tools:buildifier


# Run pip-compile to upgrade python dependencies
.PHONY: pip_compile
pip_compile:
	cd modules/python && echo '' > requirements.txt && bazel run //:requirements.update


# Pull in auto-generated examples makefile
include examples/Makefile.mk

# Pull in auto-generated test workspaces makefile
include test_workspaces/Makefile.mk
