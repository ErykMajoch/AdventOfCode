#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <sstream>
#include <unordered_map>

struct position {
  int x;
  int y;
};

std::string load_file() {
  std::ifstream i("input.txt", std::ios::in | std::ios::binary | std::ios::ate);
  std::ifstream::pos_type size = i.tellg();
  i.seekg(0, std::ios::beg);
  std::vector<char> bytes(size);
  i.read(bytes.data(), size);
  return std::string(bytes.data(), size);
}

std::string encode(position pos) {
  std::stringstream ss;
  ss << pos.x << "-" << pos.y;
  return ss.str();
}

int part_one() {
  std::unordered_map<std::string, int> map;
  
  position pos {.x = 0, .y = 0};
  map[encode(pos)] += 1;

  for (const char& c : load_file()) {
    switch (c) {
      case '^':
        pos.y += 1;
        break;
      case '>':
        pos.x += 1;
        break;
      case 'v':
        pos.y -= 1;
        break;
      case '<':
        pos.x -= 1;
        break;
    }
    map[encode(pos)] += 1;
  }

  return map.size();
}

int part_two() {
  std::unordered_map<std::string, int> map;
  
  position pos1 {.x = 0, .y = 0};
  position pos2 {.x = 0, .y = 0};
  std::vector<position> pos = {pos1, pos2};
  
  bool robot_santa = false;
  for (const char& c : load_file()) {
    position *current = &pos[robot_santa];
    switch (c) {
      case '^':
        current->y += 1;
        break;
      case '>':
        current->x += 1;
        break;
      case 'v':
        current->y -= 1;
        break;
      case '<':
        current->x -= 1;
        break;
    }
    map[encode(*current)];
    robot_santa = !robot_santa;
  }   

  return map.size();
}

int main() {
  std::cout << "Part one: " << part_one() << "\n";
  std::cout << "Part two: " << part_two() << "\n";
}
