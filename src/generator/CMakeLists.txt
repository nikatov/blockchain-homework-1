project(generator)

# Список файлов, состовляющих данный модуль
set(INCLUDE_FILES
  GeneratorApp.h
)

set(SRC_FILES
  GeneratorApp.cpp
)

find_package(OpenSSL REQUIRED)
message(STATUS "Using OpenSSL ${OPENSSL_VERSION}")
message(STATUS "OPENSSL_INCLUDE_DIRS: ${OPENSSL_INCLUDE_DIRS}")

set(LINK_LIBS
  parser
  OpenSSL::SSL
)


include(make_executable)
make_executable()
