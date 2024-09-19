#include "parser.h"

#include <set>
#include <regex>
#include <sstream>

std::size_t part_one(Parser &p) {
    std::set<std::string> molecules = {};
    
    std::string input = p.getInput();
    const auto replacements = p.getReplacements();

    for (const auto [from, to] : replacements) {
        
        // Create regex
        std::stringstream ss;
        ss << "(" << from << ")";
        std::regex reg(ss.str());
        
        // Find all matches
        std::vector<std::pair<std::size_t, std::string>> matches = {};
        for (std::sregex_iterator it(input.begin(), input.end(), reg), end_it; it != end_it; it++) {
            matches.emplace_back(it->position(), it->str());
        }

        // Generate molecules
        for (std::size_t i = 0; i < matches.size(); i++) {
            std::string result = input;
            const auto& match = matches[i];
            result.replace(match.first, match.second.length(), to);
            molecules.emplace(result);
        }

    }
    return molecules.size();
}

std::vector<std::pair<std::string, std::string>> reversePairs(std::vector<std::pair<std::string, std::string>> p) {
    std::vector<std::pair<std::string, std::string>> n = {};
    for (const auto& [from, to] : p) {
        n.emplace_back(std::make_pair(to, from));
    }
    return n;
}

int part_two(Parser &p) {
    int count = 0;

    std::string molecule = p.getInput();
    std::vector<std::pair<std::string, std::string>> replacements = reversePairs(p.getReplacements());

    while (true)
    {
        for (const auto [from, to] : replacements) {
            auto pos = molecule.find(from);
            if (pos != std::string::npos) {
                molecule.replace(pos, from.length(), to);
                count++;
            }
            if (molecule == "e") {
                return count;
            }
        }
    }
    
    // return count;
}

int main() {
    Parser p = Parser("input.txt");
    std::cout << "Part One: " << part_one(p) << "\n";
    std::cout << "Part Two: " << part_two(p) << "\n";
    return 0;
}
