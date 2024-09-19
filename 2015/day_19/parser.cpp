#include "parser.h"

const std::string DELIM = " => ";

Parser::Parser(std::string file_name) {
    std::ifstream file(file_name);

    if (file.is_open()) {
        std::string line = "";
        while (std::getline(file, line)) {
            auto result = split(line, DELIM);
            if (std::holds_alternative<std::pair<std::string, std::string>>(result)) {
                auto pair = std::get<std::pair<std::string, std::string>>(result);
                p_Replacements.emplace_back(pair);
            } else {
                if (p_Input.empty() && !std::get<std::string>(result).empty()) {
                    p_Input = std::get<std::string>(result);
                }
            }
        }
        file.close();
    }
}

std::variant<std::pair<std::string, std::string>, std::string> Parser::split(std::string input, std::string delimiter) {
    size_t pos = input.find(delimiter);
    if (pos != std::string::npos) {
        std::string first = input.substr(0, pos);
        std::string second = input.substr(pos + delimiter.length());
        return std::make_pair(first, second);
    } else {
        return input;
    }
}

std::vector<std::pair<std::string, std::string>> Parser::getReplacements() {
    return p_Replacements;
}

std::string Parser::getInput() {
    return p_Input;
}
