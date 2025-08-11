#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <regex>
#include <sstream>
#include <string>
#include <vector>


std::string read_file(const std::string& path) {
    std::ifstream file(path);
    if (!file.is_open()) {
        std::cerr << "Failed to open file: " << path << "\n";
        std::exit(3);
    };

    std::stringstream file_stream;
    file_stream << file.rdbuf();
    file.close();

    return std::string(file_stream.str());
}

std::vector<std::string> read_file_lines(const std::string& path) {
    std::ifstream file{path};
    if (!file.is_open()) {
        std::cerr << "Failed to open file: " << path << "\n";
        std::exit(2);
    };

    std::stringstream file_stream;
    file_stream << file.rdbuf();
    file.close();
    std::vector<std::string> line_list;
    std::string line;

    while (std::getline(file_stream, line)) {
        line_list.push_back(line);
    }

    return line_list;
}

int main(int argc, char **argv, char **envp) {
    if (argc != 5) {
        std::cerr << "Expected 4 arguments in order: <manifest file> <template file> <source dir> <target dir>\n";
        std::exit(1);
    }

    // Load in expected manifest and template file
    const auto path_list = read_file_lines(argv[1]);
    const std::string template_str = read_file(argv[2]);

    // Load source and target dirs
    const std::filesystem::path source_dir = argv[3];
    const std::filesystem::path target_dir = argv[4];

    // Build template vars
    std::map<std::string, std::string> common_template_vars;
    common_template_vars["go_package"] = "";

    // Attempt to find Go package
    // When the fixer is applied to Go generated sources, it needs to generate files that have a package that match the
    // existing files. This assumes that at least one file has been generated, which is typically safe
    bool found_go_files = false;
    for (const std::filesystem::path path : path_list) {
        // Skip blank lines
        if (path.empty()) continue;

        // Check file is a go file
        if (path.extension() != ".go") continue;
        found_go_files = true;

        // Check file exists
        const auto full_path = source_dir / path;
        if (!std::filesystem::exists(full_path)) continue;

        // Attempt to grab package
        std::smatch package_match;
        const auto file_lines = read_file(full_path);
        if (std::regex_search(
            file_lines, package_match, std::regex("^package ([a-zA-Z0-9_-]+)$", std::regex::ECMAScript | std::regex::multiline))
        ) {
            common_template_vars["go_package"] = package_match[1];
            break;
        }
    }

    if (found_go_files && common_template_vars["go_package"] == "") {
        std::cerr << "Warning: failed to find go package for templating go files, falling back to parent dir name";
    }

    // Copy or create each file in the target directory
    for (const std::filesystem::path path : path_list) {
        // Skip blank lines
        if (path.empty()) continue;

        // Build paths
        const auto source_path = source_dir / path;
        const auto target_path = target_dir / path;

        // If source file exists, just copy
        if (std::filesystem::exists(source_path)) {
            std::filesystem::create_directories(target_path.parent_path());
            std::filesystem::copy(source_dir / path, target_path);
            continue;
        } 

        // Source file does not exist, write target file with template
        //std::cout << "Fixing missing plugin output file: " << path << "\n";

        // Open target file
        std::ofstream target_file{target_path};
        if (!target_file.good()) {
            std::cerr << "Failed to open target file: " << target_path << "\n";
            std::exit(4);
        };

        // Build file specific template vars
        std::map<std::string, std::string> file_template_vars{common_template_vars};

        const auto parent_path = target_path.parent_path();
        file_template_vars["parent_directory_name"] = parent_path.filename();
        if (file_template_vars["go_package"] == "") {
            file_template_vars["go_package"] = file_template_vars["parent_directory_name"];
        }

        // Replace template variables
        std::string file_template_str = std::string(template_str);
        for (const auto& tup : file_template_vars) {
            file_template_str = std::regex_replace(
                file_template_str, std::regex("\\{" + tup.first + "\\}"), tup.second
            );
        }

        // Write filled template
        target_file << file_template_str;
        target_file.close();
    }

    return 0;
}
