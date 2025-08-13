use std::env;
use std::fs;
use std::io;
use std::path::Path;
use std::process;


fn main() {
    // Parse args
    let args: Vec<String> = env::args().collect();
    if args.len() != 4 {
        eprintln!("Expected 3 arguments in order: <manifest file> <source dir> <target dir>");
        process::exit(1);
    }

    let manifest_path = Path::new(&args[1]);
    let source_dir = Path::new(&args[2]);
    let target_dir = Path::new(&args[3]);

    // Load manifest
    let manifest_content = fs::read_to_string(manifest_path)
        .unwrap_or_else(|err| panic!("Cannot read manifest file {:?}: {}", manifest_path, err));
    let manifest_lines: Vec<&str> = manifest_content.lines().collect();

    // Copy each directory or file into the target directory
    for type_and_path in manifest_lines {
        // Skip invalid lines
        if type_and_path.len() < 3 {
            continue;
        }

        // Determine type
        //   D for directory
        //   F for file
        let line_type = &type_and_path[0..1];
        let path = Path::new(&type_and_path[2..]);
        let source_path = source_dir.join(path);
        if line_type == "D" {
            copy_dir(&source_path, target_dir)
                .unwrap_or_else(|err| panic!("Failed to copy directory {:?} to {:?}: {}", source_path, target_dir, err));
        } else if line_type == "F" {
            let target_path = target_dir.join(path);
            target_path.parent().and_then(|parent| fs::create_dir_all(parent).ok())
                .unwrap_or_else(|| panic!("Failed to create directory {:?}", target_path));
            fs::copy(&source_path, &target_path)
                .unwrap_or_else(|err| panic!("Failed to copy file {:?} to {:?}: {}", source_path, target_path, err));
        } else {
            panic!("Unexpected line type: {}", type_and_path);
        }
    }
}

fn copy_dir(src: impl AsRef<Path>, dst: impl AsRef<Path>) -> io::Result<()> {
    fs::create_dir_all(&dst)?;
    for entry in fs::read_dir(src)? {
        let entry = entry?;
        let path = entry.path();
        if path.is_dir() {
            copy_dir(path, dst.as_ref().join(entry.file_name()))?;
        } else {
            fs::copy(path, dst.as_ref().join(entry.file_name()))?;
        }
    }
    Ok(())
}
