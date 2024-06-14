#include <stdio.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>

unsigned long long to_base10(char input[]) {
  unsigned long long value = 0;
  int exponent = 7;
  for (int i = 0; i < 8; i++) {
    value += (input[i] - 'a' + 1) * pow(26, exponent);
    exponent--;
  }
  return value;
}

char* to_base26(unsigned long long input) {
  static char value[9] = {};
  for (int i = 7; i >= 0; i--) {
    int digit = input % 26;
    value[i] = digit == 0 ? 'z' : (char)(digit + 'a' - 1);
    input = (input - 1) / 26;
  }
  value[8] = '\0';
  return value;
}

bool is_valid(char password[]) {
  bool consecutive = false;
  bool forbidden = false;
  int pairs = 0;
  int used[26] = {0};

  for (int i = 0; i < 8; i++) {
      // Forbidden characters
      if (password[i] == 'i' || password[i] == 'o' || password[i] == 'l') {
          forbidden = true;
          break;
      }

      // Consecutive characters
      if (i <= 5 && password[i+1] == password[i] + 1 && password[i+2] == password[i] + 2) {
          consecutive = true;
      }

      // Pairs
      if (i < 7 && password[i] == password[i+1] && (i == 6 || password[i+1] != password[i+2])) {
          pairs++;
      }
  }

  return consecutive && !forbidden && pairs >= 2;
}

char* next_password(char password[9]) {
  unsigned long long b10 = to_base10(password) + 1;

  while (true) {
    strncpy(password, to_base26(b10), 9);
    if (is_valid(password)) {
      break;
    }
    b10++;
  }
 
  return password;
}

int main() {
  char initial[] = "hepxcrrq";
  
  char* p1 = next_password(initial);
  printf("Part one: %s\n", p1);

  char* p2 = next_password(p1);
  printf("Part one: %s\n", p2);

  return 0;
}

