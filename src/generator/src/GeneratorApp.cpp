#include "GeneratorApp.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <cstdio>
#include <openssl/sha.h>
#include <sstream>

void GeneratorApp::init(int argc, char **argv) {
  _parser = std::make_unique<Parser>(argc, argv, std::vector<std::string>({"file", "numbilets", "parameter"}));
}

std::vector<unsigned char> hash(const std::string& str) {
  std::vector<unsigned char> hash(SHA256_DIGEST_LENGTH);
  SHA256_CTX sha256;
  SHA256_Init(&sha256);
  SHA256_Update(&sha256, str.c_str(), str.size());
  SHA256_Final(&hash[0], &sha256);
  return hash;
}

std::string hash2String(const std::vector<unsigned char>& hash) {
  std::stringstream ss;
  for(int i = 0; i < SHA256_DIGEST_LENGTH; i++) {
    ss << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(hash[i]);
  }
  return ss.str();
}

// хэш-строка (32 байта) -> число (8 байт)
uint64_t hash2Int(std::vector<unsigned char> hash) {
  // Уменьшение размера хэша
  size_t size = hash.size();
  while (size > 8) {
    size = hash.size() / 2;
    // XOR двух половин
    std::vector<unsigned char> newHash(size);
    for (int i = 0; i < size; ++i) {
      newHash[i] = hash[i] ^ hash[size + i];
    }
    hash = newHash;
  }
  
  // хэш-строка в число
  uint64_t result = hash[0];
  for (int i = 1; i < hash.size(); ++i) {
    result = result << 8;
    result += hash[i];
  }
  return result;
}

int GeneratorApp::run() {
  std::string seed = _parser->getString("parameter");
  int numbilets = _parser->getInt("numbilets");
  std::vector<std::string> fioVec = _getFIOVec();
  for (const auto& fio : fioVec) {
    std::cout << fio << ": " << hash2Int(hash(seed + fio)) % numbilets + 1 << std::endl;
  }
  return 0;
}

std::vector<std::string> GeneratorApp::_getFIOVec() const {
  std::ifstream fs(_parser->getString("file"));
  std::vector<std::string> strVec;
  std::string str;
  while(getline(fs, str)) {
    strVec.push_back(std::move(str));
  }
  return strVec;
}
