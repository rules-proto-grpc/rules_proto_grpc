#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>


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
    if (argc != 4) {
        std::cerr << "Expected 3 arguments in order: <manifest file> <source dir> <target dir>\n";
        std::exit(1);
    }

    // Load in path list
    const auto path_list = read_file_lines(argv[1]);

    // Load source and target dirs
    const std::filesystem::path source_dir = argv[2];
    const std::filesystem::path target_dir = argv[3];

    // Copy each directory or file into the target directory
    for (const auto& type_and_path : path_list) {
        // Skip blank lines
        if (type_and_path.length() == 0) continue;

        // Determine type
        //   D for directory
        //   F for file
        const auto type = type_and_path.substr(0, 2);
        const std::filesystem::path path = type_and_path.substr(2);
        if (type == "D ") {
            std::cout << "Dir: " << path << "\n";
            std::filesystem::copy(
                source_dir / path, target_dir,
                // If two plugins make same output in their directories, skip later copies
                std::filesystem::copy_options::skip_existing
                | std::filesystem::copy_options::recursive
            );
        } else if (type == "F ") {
            std::cout << "File: " << path << "\n";
            const auto target_path = target_dir / path;
            std::filesystem::create_directories(target_path.parent_path());
            std::filesystem::copy(source_dir / path, target_path);
        } else {
            std::cerr << "Unexpected line type: " << type_and_path << "\n";
            std::exit(2);
        }
    }

    return 0;
}
