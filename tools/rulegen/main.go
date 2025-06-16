package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path"
	"path/filepath"
	"sort"
	"strings"

	"github.com/urfave/cli"
)

var ciPlatforms = []string{
	"ubuntu2204",
	// "ubuntu2004_arm64",  // Absl fails to build due to processor selection
	// "windows",  // Blocked by https://github.com/bazelbuild/bazel/issues/18683
	// "windows_arm64",  // Blocked by https://github.com/bazelbuild/bazel/issues/18683
	"macos",
	"macos_arm64",
}
var ciPlatformsMap = map[string][]string{
	"linux":   []string{"ubuntu2204", "ubuntu2004_arm64"},
	"windows": []string{"windows", "windows_arm64"},
	"macos":   []string{"macos", "macos_arm64"},
}

var extraPlatformFlags = map[string][]string{
	"ubuntu2204": []string{},
	"windows": []string{
		"--define=protobuf_allow_msvc=true",  // https://github.com/protocolbuffers/protobuf/issues/20085
	},
	"windows_arm64": []string{
		"--define=protobuf_allow_msvc=true",  // https://github.com/protocolbuffers/protobuf/issues/20085
	},
	"macos": []string{
		// Fix clash between OpenSSL and BoringSSL on recent MacOS versions, by marking
		// /usr/local/include as a system include search dir. This prevents redefinition errors when
		// BoringSSL files end up including OpenSSL headers due to matching include prefix. This arg
		// moves the OpenSSL headers (and anything in that search dir) lower in priority vs local
		// files coming from -iquote etc. This only appears to be a problem on the Bazel MacOS CI
		// machines on BuildKite, as a local MacOS build does not require this workaround. Perhaps
		// the CI machines have Homebrew installed etc.
		// FIXED since BuildKite machines were reinstalled as VMs ~June 2024
		//"--copt=-isystem/usr/local/include",
	},
}

func main() {
	app := cli.NewApp()
	app.Name = "rulegen"
	app.Flags = []cli.Flag{
		&cli.StringFlag{
			Name:  "dir",
			Usage: "Directory to scan",
			Value: ".",
		},
		&cli.StringFlag{
			Name:  "module_template",
			Usage: "Template for the main MODULE.bazel",
			Value: "tools/rulegen/MODULE.bazel.template",
		},
		&cli.StringFlag{
			Name:  "readme_header_template",
			Usage: "Template for the main readme header",
			Value: "tools/rulegen/README.header.md",
		},
		&cli.StringFlag{
			Name:  "readme_footer_template",
			Usage: "Template for the main readme footer",
			Value: "tools/rulegen/README.footer.md",
		},
		&cli.StringFlag{
			Name:  "available_tests",
			Usage: "File containing the list of available routeguide tests",
			Value: "available_tests.txt",
		},
	}
	app.Action = func(c *cli.Context) error {
		err := action(c)
		if err != nil {
			return cli.NewExitError("%v", 1)
		}
		return nil
	}

	app.Run(os.Args)
}

func action(c *cli.Context) error {
	dir := c.String("dir")
	if dir == "" {
		return fmt.Errorf("--dir required")
	}

	languages := []*Language{
		makeBuf(),
		makeCpp(),
		makeDoc(),
		makeGo(),
		makeGrpcGateway(),
		makeJava(),
		makeObjc(),
		makePython(),
		makeScala(),
		makeSwift(),
	}

	for _, lang := range languages {
		mustWriteLanguageReadme(dir, lang)
		mustWriteLanguageDefs(dir, lang)
		mustWriteLanguageRules(dir, lang)
		mustWriteLanguageExamples(dir, lang)
	}

	mustWriteModuleBazel(dir, c.String("module_template"), languages)
	mustWriteBazelignore(dir, languages)

	mustWriteReadme(dir, c.String("readme_header_template"), c.String("readme_footer_template"), languages)

	mustWriteBazelCIPresubmitYml(dir, languages, c.String("available_tests"))

	mustWriteExamplesMakefile(dir, languages)
	mustWriteTestWorkspacesMakefile(dir)

	return nil
}

func mustWriteLanguageRules(dir string, lang *Language) {
	for _, rule := range lang.Rules {
		mustWriteLanguageRule(dir, lang, rule)
	}
}

func mustWriteLanguageRule(dir string, lang *Language, rule *Rule) {
	out := &LineWriter{}
	out.t(mustTemplate(`"""Generated definition of {{ .Rule.Name }}."""`), &RuleTemplatingData{lang, rule, commonTemplatingFields}, "")
	out.ln()
	out.t(rule.Implementation, &RuleTemplatingData{lang, rule, commonTemplatingFields}, "")
	out.ln()
	out.MustWrite(filepath.Join(dir, "modules", lang.Name, rule.Name + ".bzl"))
}

func mustWriteLanguageExamples(dir string, lang *Language) {
	for _, rule := range lang.Rules {
		exampleDir := filepath.Join(dir, "examples", lang.Name, rule.Name)
		err := os.MkdirAll(exampleDir, os.ModePerm)
		if err != nil {
			log.Fatalf("FAILED to create %s: %v", exampleDir, err)
		}
		mustWriteLanguageExampleStaticFiles(exampleDir, lang, rule)
		mustWriteLanguageExampleModuleBazelFile(exampleDir, lang, rule)
		mustWriteLanguageExampleBuildFile(exampleDir, lang, rule)
	}
}

func mustWriteLanguageExampleStaticFiles(dir string, lang *Language, rule *Rule) {
	// Write empty WORKSPACE file to indicate Bazel workspace root
	out := &LineWriter{}
	out.MustWrite(filepath.Join(dir, "WORKSPACE"))
}

func mustWriteLanguageExampleModuleBazelFile(dir string, lang *Language, rule *Rule) {
	out := &LineWriter{}
	depth := strings.Split(lang.Name, "/")
	// +2 as we are in the examples/{rule} subdirectory
	rootPath := strings.Repeat("../", len(depth) + 2)

	if (len(lang.ModulePrefixLines) > 0) {
		out.w(lang.ModulePrefixLines)
	}

	extraDeps := ""
	extraLocalOverrides := ""
	for _, dep := range lang.DependsOn {
		extraDeps += fmt.Sprintf("\nbazel_dep(name = \"rules_proto_grpc_%s\", version = \"0.0.0.rpg.version.placeholder\")", dep)
		extraLocalOverrides += fmt.Sprintf(`

local_path_override(
    module_name = "rules_proto_grpc_%s",
    path = "%smodules/%s",
)`, dep, rootPath, dep)
	}

	out.w(`bazel_dep(name = "rules_proto_grpc", version = "0.0.0.rpg.version.placeholder")
bazel_dep(name = "rules_proto_grpc_example_protos", version = "0.0.0.rpg.version.placeholder")
bazel_dep(name = "rules_proto_grpc_%s", version = "0.0.0.rpg.version.placeholder")%s

local_path_override(
    module_name = "rules_proto_grpc",
    path = "%smodules/core",
)

local_path_override(
    module_name = "rules_proto_grpc_example_protos",
    path = "%smodules/example_protos",
)

local_path_override(
    module_name = "rules_proto_grpc_%s",
    path = "%smodules/%s",
)%s`, lang.Name, extraDeps, rootPath, rootPath, lang.Name, rootPath, lang.Name, extraLocalOverrides)

	if (len(lang.ModuleSuffixLines) > 0) {
		out.ln()
		out.w(lang.ModuleSuffixLines)
	}

	out.ln()
	out.MustWrite(filepath.Join(dir, "MODULE.bazel"))
}

func mustWriteLanguageExampleBuildFile(dir string, lang *Language, rule *Rule) {
	out := &LineWriter{}
	out.t(rule.BuildExample, &RuleTemplatingData{lang, rule, commonTemplatingFields}, "")
	out.ln()
	out.MustWrite(filepath.Join(dir, "BUILD.bazel"))
}

func mustWriteLanguageDefs(dir string, lang *Language) {
	out := &LineWriter{}
	out.w("\"\"\"%s protobuf and grpc rules.\"\"\"", lang.Name)
	out.ln()

	extraDefs := make([]string, 0, len(lang.ExtraDefs))
	for def := range lang.ExtraDefs {
		extraDefs = append(extraDefs, def)
	}
	sort.Strings(extraDefs)

	ruleNames := make([]string, 0, len(lang.Rules))
	for _, rule := range lang.Rules {
		ruleNames = append(ruleNames, rule.Name)
	}
	sort.Strings(ruleNames)
	for _, ruleName := range ruleNames {
		out.w(`load(":%s.bzl", _%s = "%s")`, ruleName, ruleName, ruleName)
	}
	for _, def := range extraDefs {
		out.w(`load("%s", _%s = "%s")  # buildifier: disable=same-origin-load # buildifier: disable=out-of-order-load`, lang.ExtraDefs[def], def, def)
	}
	out.ln()

	out.w("# Export %s rules", lang.Name)
	for _, rule := range lang.Rules {
		out.w(`%s = _%s`, rule.Name, rule.Name)
	}
	out.ln()

	if len(lang.Aliases) > 0 {
		out.w(`# Aliases`)

		aliases := make([]string, 0, len(lang.Aliases))
		for alias := range lang.Aliases {
			aliases = append(aliases, alias)
		}
		sort.Strings(aliases)

		for _, alias := range aliases {
			out.w(`%s = _%s`, alias, lang.Aliases[alias])
		}

		out.ln()
	}

	if len(lang.ExtraDefs) > 0 {
		out.w(`# Extra defs`)

		for _, def := range extraDefs {
			out.w(`%s = _%s`, def, def)
		}

		out.ln()
	}
	out.MustWrite(filepath.Join(dir, "modules", lang.Name, "defs.bzl"))
}

func mustWriteLanguageReadme(dir string, lang *Language) {
	out := &LineWriter{}

	out.w(":author: rules_proto_grpc")
	out.w(":description: rules_proto_grpc Bazel rules for %s", lang.DisplayName)
	out.w(":keywords: Bazel, Protobuf, gRPC, Protocol Buffers, Rules, Build, Starlark, %s", lang.DisplayName)
	out.ln()
	out.ln()

	out.w("%s", lang.DisplayName)
	out.w("%s", strings.Repeat("=", len(lang.DisplayName)))
	out.ln()

	if lang.Notes != nil {
		out.t(lang.Notes, lang, "")
		out.ln()
	}

	out.w(".. list-table:: Rules")
	out.w("   :widths: 1 2")
	out.w("   :header-rows: 1")
	out.ln()
	out.w("   * - Rule")
	out.w("     - Description")
	for _, rule := range lang.Rules {
		out.w("   * - `%s`_", rule.Name)
		out.w("     - %s", rule.Doc)
	}
	out.ln()

	out.w("Installation")
	out.w("%s", strings.Repeat("-", len("Installation")))
	out.ln()
	out.w("The %s module can be installed by adding the following lines to your MODULE.bazel file, replacing the version number placeholder with the desired version:", lang.DisplayName)
	out.ln()

	out.w(".. code-block:: python")
	out.ln()
	out.w(`   bazel_dep(name = "rules_proto_grpc_%s", version = "<version number here>")`, lang.Name)
	if (len(lang.ModuleSuffixLines) > 0) {
		for _, line := range strings.Split(lang.ModuleSuffixLines, "\n") {
			out.w("   %s", line)
		}
	}
	out.ln()

	for _, rule := range lang.Rules {
		out.w(".. _%s:", rule.Name)
		out.ln()
		out.w("%s", rule.Name)
		out.w("%s", strings.Repeat("-", len(rule.Name)))
		out.ln()

		if rule.Experimental {
			out.w(".. warning:: This rule is experimental. It may not work correctly or may change in future releases!")
			out.ln()
		}
		out.w(rule.Doc)
		out.ln()

		out.w("Example")
		out.w("*******")
		out.ln()

		out.w("Full example project can be found `here <https://github.com/rules-proto-grpc/rules_proto_grpc/tree/master/examples/%s/%s>`__", lang.Name, rule.Name)
		out.ln()

		out.w("``BUILD.bazel``")
		out.w("^^^^^^^^^^^^^^^")
		out.ln()

		out.w(".. code-block:: python")
		out.ln()
		out.t(rule.BuildExample, &RuleTemplatingData{lang, rule, commonTemplatingFields}, "   ")
		out.ln()

		out.w("Attributes")
		out.w("**********")
		out.ln()
		out.w(".. list-table:: Attributes for %s", rule.Name)
		out.w("   :widths: 1 1 1 1 4")
		out.w("   :header-rows: 1")
		out.ln()
		out.w("   * - Name")
		out.w("     - Type")
		out.w("     - Mandatory")
		out.w("     - Default")
		out.w("     - Description")
		for _, attr := range rule.Attrs {
			out.w("   * - ``%s``", attr.Name)
			out.w("     - ``%s``", attr.Type)
			out.w("     - %t", attr.Mandatory)
			if len(attr.Default) > 0 {
				out.w("     - ``%s``", attr.Default)
			} else {
				out.w("     - ")
			}
			out.w("     - %s", attr.Doc)
		}
		out.ln()

		if len(rule.Plugins) > 0 {
			out.w("Plugins")
			out.w("*******")
			out.ln()
			for _, plugin := range rule.Plugins {
				out.w("- `@rules_proto_grpc_%s%s <https://github.com/rules-proto-grpc/rules_proto_grpc/blob/master/modules/%s/BUILD.bazel>`__", lang.Name, plugin, lang.Name)
			}
			out.ln()
		}
	}

	out.MustWrite(filepath.Join(dir, "docs", "lang", lang.Name + ".rst"))
}

func mustWriteModuleBazel(dir, template string, languages []*Language) {
	out := &LineWriter{}
	out.tpl(template, struct{}{})

	for _, lang := range languages {
		out.w("# %s", lang.DisplayName)
		// if (len(lang.ModulePrefixLines) > 0) {
		// 	out.w(lang.ModulePrefixLines)
		// 	out.ln()
		// }

		out.w(`bazel_dep(name = "rules_proto_grpc_%s", version = "0.0.0.rpg.version.placeholder")
local_path_override(
    module_name = "rules_proto_grpc_%s",
    path = "modules/%s",
)`, lang.Name, lang.Name, lang.Name)
		out.ln()

		if (len(lang.ModuleSuffixLines) > 0) {
			out.w(lang.ModuleSuffixLines)
			out.ln()
		}
	}

	out.MustWrite(filepath.Join(dir, "MODULE.bazel"))
}

func mustWriteBazelignore(dir string, languages []*Language) {
	// Write constant header
	out := &LineWriter{}
	out.w("modules")
	out.w("test_workspaces")
	out.ln()

	//
	// Write example ignores
	//
	for _, lang := range languages {
		for _, rule := range lang.Rules {
			out.w("examples/%s/%s", lang.Name, rule.Name)
		}
		out.ln()
	}

	out.MustWrite(filepath.Join(dir, ".bazelignore"))
}

func mustWriteReadme(dir, header, footer string, languages []*Language) {
	out := &LineWriter{}

	out.tpl(header, struct{}{})
	out.ln()

	out.w("## Rules")
	out.ln()

	out.w("| Language | Rule | Description")
	out.w("| ---: | :--- | :--- |")
	for _, lang := range languages {
		for _, rule := range lang.Rules {
			dirLink := fmt.Sprintf("[%s](https://rules-proto-grpc.com/en/latest/lang/%s.html)", lang.DisplayName, lang.Name)
			ruleLink := fmt.Sprintf("[%s](https://rules-proto-grpc.com/en/latest/lang/%s.html#%s)", rule.Name, lang.Name, strings.ReplaceAll(rule.Name, "_", "-"))
			exampleLink := fmt.Sprintf("[example](/examples/%s/%s)", lang.Name, rule.Name)
			out.w("| %s | %s | %s (%s) |", dirLink, ruleLink, rule.Doc, exampleLink)
		}
	}
	out.ln()

	out.tpl(footer, struct{}{})

	out.MustWrite(filepath.Join(dir, "README.md"))
}

func mustWriteBazelCIPresubmitYml(dir string, languages []*Language, availableTestsPath string) {
	// Read available tests
	content, err := ioutil.ReadFile(availableTestsPath)
	if err != nil {
		log.Fatal(err)
	}
	availableTestLabels := strings.Split(string(content), "\n")

	// Write header
	out := &LineWriter{}
	out.w("---")
	out.w("tasks:")

	//
	// Write tasks for main code
	//
	for _, ciPlatform := range ciPlatforms {
		out.w("  main_%s:", ciPlatform)
		out.w("    name: Build & Test All")
		out.w("    platform: %s", ciPlatform)
		// out.w("    environment:")
		// out.w(`      CC: clang`)
		out.w("    test_flags:")
		out.w(`      - "--test_output=errors"`)
		out.w(`      - "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1"`)  // Don't create 'local' cpp toolchain
		if strings.HasPrefix(ciPlatform, "windows") {
			out.w(`      - "--enable_runfiles"`)  // Needed for sh_test to work correctly
			out.w(`      - "--cxxopt=/std:c++17"`)
			out.w(`      - "--host_cxxopt=/std:c++17"`)
		} else {
			out.w(`      - "--cxxopt=-std=c++17"`)
			out.w(`      - "--host_cxxopt=-std=c++17"`)
		}
		for _, flag := range extraPlatformFlags[ciPlatform] {
			out.w(`      - "%s"`, flag)
		}
		out.w("    test_targets:")
		for _, clientLang := range languages {
			for _, serverLang := range languages {
				if doTestOnPlatform(clientLang, nil, ciPlatform) && doTestOnPlatform(serverLang, nil, ciPlatform) && stringInSlice(fmt.Sprintf("//examples/routeguide:%s_%s", clientLang.Name, serverLang.Name), availableTestLabels) {
					out.w(`      - "//examples/routeguide:%s_%s"`, clientLang.Name, serverLang.Name)
				}
			}
		}
		out.ln()
	}

	//
	// Write tasks for examples
	//
	for _, lang := range languages {
		for _, ciPlatform := range ciPlatforms {
			// Check platform has at least one example to run
			platformHasCommand := false
			for _, rule := range lang.Rules {
				if doTestOnPlatform(lang, rule, ciPlatform) {
					platformHasCommand = true
					break
				}
			}
			if !platformHasCommand {
				continue
			}

			// Write task
			out.w("  %s_%s_examples:", lang.Name, ciPlatform)
			out.w("    name: %s", lang.DisplayName)
			out.w("    platform: %s", ciPlatform)
			out.w("    environment:")
			if strings.HasPrefix(ciPlatform, "windows") {
				if len(extraPlatformFlags[ciPlatform]) > 0 {
					out.w(`      BAZEL_EXTRA_FLAGS: "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 --cxxopt=/std:c++17 --host_cxxopt=/std:c++17 %s"`, strings.Join(extraPlatformFlags[ciPlatform], " "))
				} else {
					out.w(`      BAZEL_EXTRA_FLAGS: "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 --cxxopt=/std:c++17 --host_cxxopt=/std:c++17`)
				}
			} else {
				if len(extraPlatformFlags[ciPlatform]) > 0 {
					out.w(`      BAZEL_EXTRA_FLAGS: "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 --cxxopt=-std=c++17 --host_cxxopt=-std=c++17 %s"`, strings.Join(extraPlatformFlags[ciPlatform], " "))
				} else {
					out.w(`      BAZEL_EXTRA_FLAGS: "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 --cxxopt=-std=c++17 --host_cxxopt=-std=c++17"`)
				}
			}
			for k, v := range lang.PresubmitEnvVars {
				out.w("      %s: %s", k, v)
			}

			if strings.HasPrefix(ciPlatform, "windows") {
				out.w("    batch_commands:")
			} else {
				out.w("    shell_commands:")
				out.w("      - set -x")
			}

			for _, rule := range lang.Rules {
				if !doTestOnPlatform(lang, rule, ciPlatform) {
					continue
				}

				if strings.HasPrefix(ciPlatform, "windows") {
					// Windows has no make, so execute commands manually
					out.w("      - echo %s", rule.Name)
					out.w("      - cd %s", path.Join(dir, "examples", lang.Name, rule.Name))
					if rule.IsTest {
						out.w("      - bazel --batch test %%BAZEL_EXTRA_FLAGS%% --enable_runfiles --verbose_failures --test_output=errors --disk_cache=../../bazel-disk-cache //... || exit 1")
					} else {
						out.w("      - bazel --batch build %%BAZEL_EXTRA_FLAGS%% --enable_runfiles --verbose_failures --disk_cache=../../bazel-disk-cache //... || exit 1")
					}
					out.w("      - cd ../../..")
				} else {
					out.w("      - make %s_%s_example", lang.Name, rule.Name)
				}
			}

			out.ln()
		}
	}

	//
	// Write tasks for test workspaces
	//
	for _, ciPlatform := range ciPlatforms {
		out.w("  %s_test_workspaces:", ciPlatform)
		out.w("    name: Test Workspaces")
		out.w("    platform: %s", ciPlatform)
		out.w("    environment:")
		if strings.HasPrefix(ciPlatform, "windows") {
			if len(extraPlatformFlags[ciPlatform]) > 0 {
				out.w(`      BAZEL_EXTRA_FLAGS: "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 --cxxopt=/std:c++17 --host_cxxopt=/std:c++17 %s"`, strings.Join(extraPlatformFlags[ciPlatform], " "))
			} else {
				out.w(`      BAZEL_EXTRA_FLAGS: "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 --cxxopt=/std:c++17 --host_cxxopt=/std:c++17`)
			}
		} else {
			if len(extraPlatformFlags[ciPlatform]) > 0 {
				out.w(`      BAZEL_EXTRA_FLAGS: "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 --cxxopt=-std=c++17 --host_cxxopt=-std=c++17 %s"`, strings.Join(extraPlatformFlags[ciPlatform], " "))
			} else {
				out.w(`      BAZEL_EXTRA_FLAGS: "--repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 --cxxopt=-std=c++17 --host_cxxopt=-std=c++17"`)
			}
		}
		if strings.HasPrefix(ciPlatform, "windows") {
			out.w("    batch_commands:")
		} else {
			out.w("    shell_commands:")
			out.w("      - set -x")
		}

		for _, testWorkspace := range findTestWorkspaceNames(dir) {
			if strings.HasPrefix(ciPlatform, "windows") {
				// Windows has no make, so execute commands manually
				out.w("      - echo %s", testWorkspace)
				out.w("      - cd %s", path.Join(dir, "test_workspaces", testWorkspace))
				out.w("      - bazel --batch test %%BAZEL_EXTRA_FLAGS%% --enable_runfiles --verbose_failures --test_output=errors --disk_cache=../bazel-disk-cache //... || exit 1")
				out.w("      - cd ../..")
			} else {
				out.w("      - make test_workspace_%s", testWorkspace)
			}
		}

		out.ln()
	}

	out.MustWrite(filepath.Join(dir, ".bazelci", "presubmit.yml"))
}

func mustWriteExamplesMakefile(dir string, languages []*Language) {
	out := &LineWriter{}

	var allNames []string
	for _, lang := range languages {
		var langNames []string

		// Create rules for each example
		for _, rule := range lang.Rules {
			exampleDir := path.Join(dir, "examples", lang.Name, rule.Name)

			var name = fmt.Sprintf("%s_%s_example", lang.Name, rule.Name)
			allNames = append(allNames, name)
			langNames = append(langNames, name)
			out.w(".PHONY: %s", name)
			out.w("%s:", name)
			out.w("	cd %s; \\", exampleDir)

			if rule.IsTest {
				out.w("	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --test_output=errors --disk_cache=../../bazel-disk-cache //...")
			} else {
				out.w("	bazel --batch build ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../../bazel-disk-cache //...")
			}
			out.ln()
		}

		// Create grouped rules for each language
		targetName := fmt.Sprintf("%s_examples", lang.Name)
		out.w(".PHONY: %s", targetName)
		out.w("%s: %s", targetName, strings.Join(langNames, " "))
		out.ln()
	}

	// Write all examples rule
	out.w(".PHONY: all_examples")
	out.w("all_examples: %s", strings.Join(allNames, " "))

	out.ln()
	out.MustWrite(filepath.Join(dir, "examples", "Makefile.mk"))
}

func mustWriteTestWorkspacesMakefile(dir string) {
	out := &LineWriter{}

	// For each test workspace, add makefile rule
	var allNames []string
	for _, testWorkspace := range findTestWorkspaceNames(dir) {
		var name = fmt.Sprintf("test_workspace_%s", testWorkspace)
		allNames = append(allNames, name)
		out.w(".PHONY: %s", name)
		out.w("%s:", name)
		out.w("	cd %s; \\", path.Join(dir, "test_workspaces", testWorkspace))
		out.w("	bazel --batch test ${BAZEL_EXTRA_FLAGS} --verbose_failures --disk_cache=../bazel-disk-cache --test_output=errors //...")
		out.ln()
	}

	// Write all test workspaces rule
	out.w(".PHONY: all_test_workspaces")
	out.w("all_test_workspaces: %s", strings.Join(allNames, " "))

	out.ln()
	out.MustWrite(filepath.Join(dir, "test_workspaces", "Makefile.mk"))
}

func findTestWorkspaceNames(dir string) []string {
	files, err := ioutil.ReadDir(filepath.Join(dir, "test_workspaces"))
	if err != nil {
		log.Fatal(err)
	}

	var testWorkspaces []string
	for _, file := range files {
		if file.IsDir() && !strings.HasPrefix(file.Name(), ".") && !strings.HasPrefix(file.Name(), "bazel-") {
			testWorkspaces = append(testWorkspaces, file.Name())
		}
	}

	return testWorkspaces
}
