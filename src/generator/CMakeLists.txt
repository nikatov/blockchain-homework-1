project(generator)

# Список файлов, состовляющих данный модуль
set(INCLUDE_FILES
  GeneratorApp.h
)

set(SRC_FILES
  GeneratorApp.cpp
)

set(LINK_LIBS parser
)

include(make_executable)
make_executable()
