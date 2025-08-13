use std::collections::HashMap;
use std::env;
use std::fs;
use std::path::{Path, PathBuf};
use std::process;

fn main() {
    // Parse args
    let args: Vec<String> = env::args().collect();
    if args.len() != 5 {
        eprintln!("Expected 4 arguments in order: <manifest file> <template file> <source dir> <target dir>");
        process::exit(1);
    }

    let manifest_path = Path::new(&args[1]);
    let template_path = Path::new(&args[2]);
    let source_dir = Path::new(&args[3]);
    let target_dir = Path::new(&args[4]);

    // Load manifest
    let manifest_content = fs::read_to_string(manifest_path)
        .unwrap_or_else(|err| panic!("Cannot read manifest file {:?}: {}", manifest_path, err));
    let path_list: Vec<PathBuf> = manifest_content
        .lines()
        .map(|path| PathBuf::from(path))
        .collect();

    // Load template file
    let template_str = fs::read_to_string(template_path)
        .unwrap_or_else(|err| panic!("Cannot read template file {:?}: {}", template_path, err));

    // Build template vars
    let mut common_template_vars: HashMap<&str, String> = HashMap::new();
    common_template_vars.insert("go_package", "".into());

    // Attempt to find Go package
    // When the fixer is applied to Go generated sources, it needs to generate files that have a package that match the
    // existing files. This assumes that at least one file has been generated, which is typically safe
    let mut found_go_files = false;
    for path in &path_list {
        // Skip blank paths
        if path.as_os_str().is_empty() {
            continue;
        };

        // Check file is a go file
        if !path.extension().is_some_and(|ext| ext == "go") {
            continue;
        };
        found_go_files = true;

        // Check file exists
        let full_path = source_dir.join(path);
        if !full_path.exists() {
            continue;
        };

        // Attempt to grab package
        let file_content = fs::read_to_string(&full_path)
            .unwrap_or_else(|err| panic!("Cannot read Go file {:?}: {}", full_path, err));
        let file_lines: Vec<&str> = file_content.lines().collect();

        for line in file_lines {
            if line.starts_with("package ") {
                common_template_vars.insert(
                    "go_package",
                    line.strip_prefix("package").unwrap().trim().to_string(),
                );
            }
        }
    }

    if found_go_files && common_template_vars["go_package"] == "" {
        eprintln!("Warning: failed to find go package for templating go files, falling back to parent dir name");
    }

    // Copy or create each file in the target directory
    for path in &path_list {
        // Skip blank paths
        if path.as_os_str().is_empty() {
            continue;
        };

        // Build paths
        let source_path = source_dir.join(path);
        let target_path = target_dir.join(path);

        // If source file exists, just copy
        if source_path.exists() {
            target_path
                .parent()
                .and_then(|parent| fs::create_dir_all(parent).ok())
                .unwrap_or_else(|| panic!("Failed to create directory {:?}", target_path));
            fs::copy(&source_path, &target_path).unwrap_or_else(|err| {
                panic!(
                    "Failed to copy file {:?} to {:?}: {}",
                    source_path, target_path, err
                )
            });
            continue;
        }

        // Build file specific template vars
        let mut file_template_vars = common_template_vars.clone();
        let parent_path = target_path.parent().unwrap_or_else(|| Path::new(""));
        match parent_path.file_name() {
            Some(parent_name) => file_template_vars.insert(
                "parent_directory_name",
                parent_name.to_str().unwrap().into(),
            ),
            None => file_template_vars.insert("parent_directory_name", "".into()),
        };

        // Replace template variables
        let mut file_template_str = template_str.clone();
        for (key, value) in file_template_vars.into_iter() {
            file_template_str = file_template_str.replace(&format!("{{{}}}", &key), &value);
        }

        // Write filled template
        fs::write(&target_path, file_template_str).unwrap_or_else(|err| {
            panic!("Failed to write templated file {:?}: {}", target_path, err)
        });
    }
}
