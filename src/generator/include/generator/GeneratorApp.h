#ifndef BLOCKCHAIN_HOMEWORK_1_GENERATORAPP_H
#define BLOCKCHAIN_HOMEWORK_1_GENERATORAPP_H

#include <memory>
#include <vector>
#include <string>
#include "parser/Parser.h"

class GeneratorApp {
public:
  GeneratorApp() : _parser(nullptr) {}
  
  void init(int argc, char **argv);
  int run();
  
private:
  std::vector<std::string> _getFIOVec() const;
  
  std::unique_ptr<Parser> _parser;
};

#endif //BLOCKCHAIN_HOMEWORK_1_GENERATORAPP_H
