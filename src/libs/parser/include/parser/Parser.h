#ifndef PARSER_H
#define PARSER_H

#include <map>
#include <string>
#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdio>

// Парсер параметров командной строки

class Parser {
public:
  Parser(int argc, char **argv, const std::vector<std::string>& paramVec);

  std::string getString(const std::string& key) const;
  int getInt(const std::string& key) const;

private:
  std::map<std::string, std::string> _params;
};

#endif //PARSER_H
