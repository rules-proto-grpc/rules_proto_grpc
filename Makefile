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


# Update C# paket lock and paket2bazel extension
.PHONY: csharp_regenerate_packages
csharp_regenerate_packages:
	cd modules/csharp/paket && dotnet new tool-manifest || true
	cd modules/csharp/paket && dotnet tool install paket
	cd modules/csharp/paket && dotnet paket install
	bazel run @rules_dotnet//tools/paket2bazel -- --dependencies-file $$(pwd)/modules/csharp/paket/paket.dependencies --output-folder $$(pwd)/modules/csharp/paket
	rm -r modules/csharp/paket/.config modules/csharp/paket/paket-files


# Run Go mod tudy
.PHONY: go_mod_tidy
go_mod_tidy:
	cd modules/go && bazel run @rules_go//go -- mod tidy


# Run pnpm to upgrade JS dependencies
.PHONY: js_resolve
js_resolve:
	cd modules/js && bazel run -- @pnpm --dir $$PWD install --lockfile-only


# Run pip-compile to upgrade python dependencies
.PHONY: pip_compile
pip_compile:
	cd modules/python && echo '' > requirements.txt && bazel run //:requirements.update


# Run swift resolve to update Package.resolved from Package.swift
.PHONY: swift_resolve
swift_resolve:
	cd modules/swift && swift package resolve


# Pull in auto-generated examples makefile
include examples/Makefile.mk

# Pull in auto-generated test workspaces makefile
include test_workspaces/Makefile.mk
