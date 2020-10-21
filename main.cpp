#include <iostream>
#include "Parser.h"

int main(int argc, char **argv) {
  Parser parser(argc, argv, {"key"});
  std::cout << parser.getInt("key") << std::endl;
  std::cout << "hello, world!" << std::endl;
}