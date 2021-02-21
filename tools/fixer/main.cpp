#include <fstream>
#include <iostream>
#include <regex>
#include <sstream>
#include <string>
#include <vector>


bool file_exists(const std::string& path) {
    return std::ifstream{path}.good();
}

int main(int argc, char **argv) {
    if (argc != 5) {
        std::cerr << "Expected 4 arguments in order: <path list file> <template file> <source dir> <target dir>\n";
        return 1;
    }

    // Load in expected path list
    std::ifstream path_list_file{argv[1]};
    if (!path_list_file.is_open()) {
        std::cerr << "Failed to open path list file\n";
        return 2;
    };
    std::stringstream path_list_stream;
    path_list_stream << path_list_file.rdbuf();
    path_list_file.close();
    std::vector<std::string> path_list;
    std::string path;
    while (std::getline(path_list_stream, path)) {
        path_list.push_back(path);
    }

    // Read template file
    std::ifstream template_file(argv[2]);
    if (!template_file.is_open()) {
        std::cerr << "Failed to open template file\n";
        return 3;
    };
    std::stringstream template_stream;
    template_stream << template_file.rdbuf();
    template_file.close();
    std::string template_str = template_stream.str();

    // Load source and target dirs
    std::string source_dir = argv[3];
    std::string target_dir = argv[4];

    // Copy or create each file in the target directory
    for (auto path : path_list) {
        // Skip blank lines
        if (path.length() == 0) continue;

        // Open target file
        std::string target_path = target_dir + "/" + path;
        std::ofstream target_file{target_path};
        if (!target_file.good()) {
            std::cerr << "Failed to open target file: " << target_path << "\n";
            return 4;
        };

        std::string source_path = source_dir + "/" + path;
        if (file_exists(source_path)) {
            // Source file exists, copy
            std::ifstream source_file{source_path};
            if (!source_file.is_open()) {
                std::cerr << "Failed to open source file\n";
                return 5;
            };

            target_file << source_file.rdbuf();
            source_file.close();
        } else {
            // Source file does not exist, write target file with template
            std::cout << "Fixing missing plugin output file: " << path << "\n";

            // Replace template variables
            std::string parent_path = target_path.substr(0, target_path.rfind("/"));
            std::string filled_template_str = std::regex_replace(
                template_str, std::regex("\\{parent_directory_name\\}"), parent_path.substr(parent_path.rfind("/") + 1)
            );

            // Write filled template
            target_file << filled_template_str;
        }

        target_file.close();
    }

    return 0;
}
