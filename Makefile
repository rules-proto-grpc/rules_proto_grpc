# Run the rulegen system
rulegen:
	bazel query '//example/routeguide/... - attr(tags, manual, //example/routeguide/...)' > available_tests.txt; \
	bazel run --run_under="cd $$PWD && " //tools/rulegen -- --ref=$$(git describe --abbrev=0 --tags); \
	rm available_tests.txt; \


# Run cargo raze on the rust dependencies
rust_raze:
	cd rust/raze; \
	rm Cargo.lock; \
	rm -r remote; \
	cargo raze; \
	mv BUILD.bazel BUILD.bazel.suffix; \
	cat BUILD.bazel.prefix BUILD.bazel.suffix > BUILD.bazel; \
	rm BUILD.bazel.suffix; \
	sed -i 's#":protobuf_build_script",#":protobuf_build_script","@rules_proto_grpc//rust/raze:rustc",#' remote/protobuf-*.BUILD.bazel; \


# Run yarn to upgrade the nodejs dependencies
yarn_upgrade:
	cd nodejs/requirements; \
	yarn install; \


# Run bundle to upgrade the Ruby dependencies
ruby_bundle_upgrade:
	cd ruby; \
	bundle install --path /tmp/ruby-bundle; \


# Run pip-compile to upgrade python dependencies
pip_compile:
	pip-compile python/requirements.in --output-file python/requirements.txt


# Run all language specific updates
all_updates: rust_raze yarn_upgrade ruby_bundle_upgrade pip_compile


# A collection of targets that build routeguide clients
clients:
	bazel build \
		//cpp/example/routeguide:client \
		//go/example/routeguide/client \
		//java/example/routeguide:client \
		//python/example/routeguide:client \
		//scala/example/routeguide:client \

# A collection of targets that build routeguide servers
servers:
	bazel build \
		//cpp/example/routeguide:server \
		//go/example/routeguide/server \
		//java/example/routeguide:server \
		//python/example/routeguide:server \
		//scala/example/routeguide:server \


# A collection of test targets
tests:
	bazel test \
		//closure/example/routeguide/... \
		//cpp/example/routeguide/... \
		//java/example/routeguide/... \
		//go/example/routeguide/... \

pending_clients:
	bazel build \
		//android/example/routeguide:client \
		//closure/example/routeguide/client \
		//nodejs/example/routeguide:client \
		//ruby/example/routeguide:client \
		//github.com/grpc/grpc-web/example/routeguide/closure:bundle \
		//rust/example/routeguide:client

pending_servers:
	bazel build \
		//nodejs/example/routeguide:server \
		//ruby/example/routeguide:server \
		//rust/example/routeguide:server

all: clients servers tests


# Pull in auto-generated examples makefile
include example/Makefile.mk

# Pull in auto-generated test workspaces makefile
include test_workspaces/Makefile.mk
