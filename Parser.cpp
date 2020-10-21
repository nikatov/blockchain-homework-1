#include "Parser.h"

Parser::Parser(int argc,
       char **argv,
       const std::vector<std::string>& paramVec) {
  for(int i = 1; i < argc; ++i) {
    std::string param(argv[i]);
    if (param.length() < 5) {
      std::cout << "Внимание! Параметр '" << param << "' пропущен, тк он имеет слишком маленькую длину" << std::endl;
      std::cout << "Введите параметр в формате '--[key_name]=[value]'" << std::endl;
      continue;
    }
    if (param[0] != '-' || param[1] != '-') {
      std::cout << "Внимание! Параметр '" << param << "' пропущен, тк он должен начинаться с '--'" << std::endl;
      std::cout << "Введите параметр в формате '--[key_name]=[value]'" << std::endl;
      continue;
    }
    size_t ind = param.find('=');
    if (ind == param.npos) {
      std::cout << "Внимание! Параметр '" << param << "' пропущен, тк не найден символ '='" << std::endl;
      std::cout << "Введите параметр в формате '--[key_name]=[value]'" << std::endl;
      continue;
    }
    std::string key = param.substr(2, ind - 2);
    if (std::find(paramVec.begin(), paramVec.end(), key) == paramVec.end()) {
      std::cout << "Внимание! Параметр '" << param << "' пропущен, тк он отсутствует среди возможных:" << std::endl;
      for (const auto& param : paramVec) {
        std::cout << param << " / ";
      }
      continue;
    }
    std::string value = param.substr(param.find('=') + 1, param.length());
    _params.insert(std::make_pair(key, value));
  }
}

std::string Parser::getString(const std::string& key) const {
  try {
    return _params.at(key);
  } catch (std::exception &e) {
    std::cout << "Ошибка в получении строки из параметра ";
    std::cout << e.what() << std::endl;
    return "";
  }
}

int Parser::getInt(const std::string& key) const {
  try {
    return std::stoi(_params.at(key));
  } catch (std::exception &e) {
    std::cout << "Ошибка в получении числа из параметра: ";
    std::cout << e.what() << std::endl;
    return -1;
  }
}