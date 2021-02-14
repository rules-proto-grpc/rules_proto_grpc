load("@rules_proto//proto:defs.bzl", "ProtoInfo")
load("//:plugin.bzl", "ProtoPluginInfo")
load(
    "//internal:common.bzl",
    "ProtoCompileInfo",
    "copy_file",
    "descriptor_proto_path",
    "get_int_attr",
    "get_output_filename",
    "get_package_root",
    "strip_path_prefix",
)

def common_compile(ctx, proto_infos):
    """Common implementation of invoking protoc"""
    ###
    ### Setup common state
    ###

    # Load attrs
    verbose = get_int_attr(ctx.attr, "verbose_string")  # Integer verbosity level
    plugins = [plugin[ProtoPluginInfo] for plugin in ctx.attr._plugins]

    # Load toolchain
    protoc_toolchain_info = ctx.toolchains[str(Label("//protobuf:toolchain_type"))]
    protoc = protoc_toolchain_info.protoc_executable
    fixer = protoc_toolchain_info.fixer_executable

    # The directory where the outputs will be generated, relative to the package. This contains the aspect _prefix attr
    # to disambiguate different aspects that may share the same plugins and would otherwise try to touch the same file.
    # The same is true for the verbose_string attr.
    rel_output_root = "{}/{}_verb{}".format(ctx.label.name, ctx.attr._prefix, verbose)

    # The full path to the output root, relative to the workspace
    output_root = get_package_root(ctx) + "/" + rel_output_root

    # The lists of generated files and directories that we expect to be produced.
    output_files = []
    output_dirs = []

    ###
    ### Setup plugins
    ###

    # Each plugin is isolated to its own execution of protoc, as plugins may have differing exclusions that cannot be
    # expressed in a single protoc execution for all plugins.

    for plugin in plugins:
        ###
        ### Fetch plugin tool and runfiles
        ###

        # Files required for running the plugin
        plugin_runfiles = []

        # Plugin input manifests
        plugin_input_manifests = None

        # Get plugin name
        plugin_name = plugin.name
        if plugin.protoc_plugin_name:
            plugin_name = plugin.protoc_plugin_name

        # Add plugin executable if not a built-in plugin
        plugin_tool = None
        if plugin.tool_executable:
            plugin_tool = plugin.tool_executable

        # Add plugin runfiles if plugin has a tool
        if plugin.tool:
            plugin_runfiles, plugin_input_manifests = ctx.resolve_tools(tools = [plugin.tool])
            plugin_runfiles = plugin_runfiles.to_list()

        # Add extra plugin data files to runfiles
        plugin_runfiles += plugin.data

        # Check plugin outputs
        if plugin.output_directory and (plugin.out or plugin.outputs or plugin.empty_template):
            fail("Proto plugin {} cannot use output_directory in conjunction with outputs, out or empty_template".format(plugin.name))

        ###
        ### Gather proto files and filter by exclusions
        ###

        protos = []  # The filtered set of .proto files to compile
        plugin_outputs = []
        proto_paths = []  # The paths passed to protoc
        for proto_info in proto_infos:
            for proto in proto_info.direct_sources:
                # Check for exclusion
                if any([
                    proto.dirname.endswith(exclusion) or proto.path.endswith(exclusion)
                    for exclusion in plugin.exclusions
                ]) or proto in protos:
                    # When using import_prefix, the ProtoInfo.direct_sources list appears to contain duplicate records,
                    # the final check 'proto in protos' removes these. See https://github.com/bazelbuild/bazel/issues/9127
                    continue

                # Proto not excluded
                protos.append(proto)

                # Add per-proto outputs
                for pattern in plugin.outputs:
                    plugin_outputs.append(ctx.actions.declare_file("{}/{}".format(
                        rel_output_root,
                        get_output_filename(proto, pattern, proto_info),
                    )))

                # Get proto path for protoc
                proto_paths.append(descriptor_proto_path(proto, proto_info))

        # Skip plugin if all proto files have now been excluded
        if len(protos) == 0:
            if verbose > 2:
                print(
                    'Skipping plugin "{}" for "{}" as all proto files have been excluded'.format(plugin.name, ctx.label),
                )
            continue

        # Append current plugin outputs to global outputs before looking at per-plugin outputs; these are manually added
        # globally as there may be srcjar outputs.
        output_files.extend(plugin_outputs)

        ###
        ### Declare per-plugin outputs
        ###

        # Some protoc plugins generate a set of output files (like python) while others generate a single 'archive' file
        # that contains the individual outputs (like java). Jar outputs are gathered as a special case as we need to
        # post-process them to have a 'srcjar' extension (java_library rules don't accept source jars with a 'jar'
        # extension).

        out_file = None
        if plugin.out:
            # Define out file
            out_file = ctx.actions.declare_file("{}/{}".format(
                rel_output_root,
                plugin.out.replace("{name}", ctx.label.name),
            ))
            plugin_outputs.append(out_file)

            if not out_file.path.endswith(".jar"):
                # Add output direct to global outputs
                output_files.append(out_file)
            else:
                # Create .srcjar from .jar for global outputs
                output_files.append(copy_file(
                    ctx,
                    out_file,
                    "{}.srcjar".format(out_file.basename.rpartition(".")[0]),
                    sibling = out_file,
                ))

        ###
        ### Declare plugin output directory if required
        ###

        # Some plugins outputs a structure that cannot be predicted from the input file paths alone. For these plugins,
        # we simply declare the directory.

        if plugin.output_directory:
            out_file = ctx.actions.declare_directory(rel_output_root + "/" + "_plugin_" + plugin.name)
            plugin_outputs.append(out_file)
            output_dirs.append(out_file)

        ###
        ### Build command
        ###

        # Determine the outputs expected by protoc.
        # When plugin.empty_template is not set, protoc will output directly to the final targets. When set, we will
        # direct the plugin outputs to a temporary folder, then use the fixer executable to write to the final targets.
        if plugin.empty_template:
            # Create path list for fixer
            fixer_paths_file = ctx.actions.declare_file(rel_output_root + "/" + "_plugin_ef_" + plugin.name + ".txt")
            ctx.actions.write(fixer_paths_file, "\n".join([
                file.path.partition(output_root + "/")[2]
                for file in plugin_outputs
            ]))

            # Create output directory for protoc to write into
            fixer_dir = ctx.actions.declare_directory(rel_output_root + "/" + "_plugin_ef_" + plugin.name)
            out_arg = fixer_dir.path
            plugin_protoc_outputs = [fixer_dir]

            # Apply fixer
            ctx.actions.run(
                inputs = [fixer_paths_file, fixer_dir, plugin.empty_template],
                outputs = plugin_outputs,
                arguments = [
                    fixer_paths_file.path,
                    plugin.empty_template.path,
                    fixer_dir.path,
                    output_root,
                ],
                progress_message = "Applying fixer for {} plugin on target {}".format(plugin.name, ctx.label),
                executable = fixer,
            )

        else:
            # No fixer, protoc writes files directly
            out_arg = out_file.path if out_file else output_root
            plugin_protoc_outputs = plugin_outputs

        # Argument list for protoc execution
        args = ctx.actions.args()

        # Add transitive descriptors
        pathsep = ctx.configuration.host_path_separator
        args.add("--descriptor_set_in={}".format(pathsep.join(
            [f.path for f in proto_info.transitive_descriptor_sets.to_list() for proto_info in proto_infos],
        )))

        # Add --plugin if not a built-in plugin
        if plugin_tool:
            # If Windows, mangle the path. It's done a bit awkwardly with
            # `host_path_seprator` as there is no simple way to figure out what's
            # the current OS.
            plugin_tool_path = None
            if ctx.configuration.host_path_separator == ";":
                plugin_tool_path = plugin_tool.path.replace("/", "\\")
            else:
                plugin_tool_path = plugin_tool.path

            args.add("--plugin=protoc-gen-{}={}".format(plugin_name, plugin_tool_path))

        # Add plugin --*_out/--*_opt args
        if plugin.options:
            opts_str = ",".join(
                [option.replace("{name}", ctx.label.name) for option in plugin.options],
            )
            if plugin.separate_options_flag:
                args.add("--{}_opt={}".format(plugin_name, opts_str))
            else:
                out_arg = "{}:{}".format(opts_str, out_arg)
        args.add("--{}_out={}".format(plugin_name, out_arg))

        # Add any extra protoc args that the plugin has
        if plugin.extra_protoc_args:
            args.add_all(plugin.extra_protoc_args)

        # Add source proto files as descriptor paths
        for proto_path in proto_paths:
            args.add(proto_path)

        ###
        ### Specify protoc action
        ###

        mnemonic = "ProtoCompile"
        command = ("mkdir -p '{}' && ".format(output_root)) + protoc.path + " $@"  # $@ is replaced with args list
        inputs = [
            descriptor
            for descriptor in proto_info.transitive_descriptor_sets.to_list()
            for proto_info in proto_infos
        ] + plugin_runfiles  # Proto files are not inputs, as they come via the descriptor sets
        tools = [protoc] + ([plugin_tool] if plugin_tool else [])

        # Amend command with debug options
        if verbose > 0:
            print("{}:".format(mnemonic), protoc.path, args)

        if verbose > 1:
            command += " && echo '\n##### SANDBOX AFTER RUNNING PROTOC' && find . -type f "

        if verbose > 2:
            command = "echo '\n##### SANDBOX BEFORE RUNNING PROTOC' && find . -type l && " + command

        if verbose > 3:
            command = "env && " + command
            for f in inputs:
                print("INPUT:", f.path)
            for f in protos:
                print("TARGET PROTO:", f.path)
            for f in tools:
                print("TOOL:", f.path)
            for f in plugin_outputs:
                print("EXPECTED OUTPUT:", f.path)

        # Run protoc
        ctx.actions.run_shell(
            mnemonic = mnemonic,
            command = command,
            arguments = [args],
            inputs = inputs,
            tools = tools,
            outputs = plugin_protoc_outputs,
            use_default_shell_env = plugin.use_built_in_shell_environment,
            input_manifests = plugin_input_manifests if plugin_input_manifests else [],
            progress_message = "Compiling protoc outputs for {} plugin on target {}".format(plugin.name, ctx.label),
        )

    # Bundle output
    return struct(
        output_root = output_root,
        output_files = output_files,
        output_dirs = output_dirs,
    )
