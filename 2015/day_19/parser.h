#pragma once

#include <unordered_map>
#include <string>
#include <fstream>
#include <vector>
#include <iostream>
#include <variant>

class Parser
{
public:
    Parser(std::string file_name);
    std::variant<std::pair<std::string, std::string>, std::string> split(std::string input, std::string delimiter);
    std::vector<std::pair<std::string, std::string>> getReplacements();
    std::string getInput();
private:
    std::vector<std::pair<std::string, std::string>> p_Replacements = {};
    std::string p_Input = "";
};
