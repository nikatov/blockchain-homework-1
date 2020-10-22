# Макрос создает библиотеку.
# Для успешной работы макроса, перед его использованием,
# необходимо проинициализировать следующие переменные:
#   ${PROJECT_NAME}   - имя проекта. project(proj_name)
#   ${INCLUDE_FILES}  - список заголовочных файлов
#   ${SRC_FILES}      - список файлов реализации
# Также, возможно, потребуется указать следующие переменные:
#   ${LINK_LIBS}      - список библиотек для линковки
# После чего достаточно вставить макрос

macro(make_library)
  # Подключаем модуль addprefix
  include(addprefix)

  # Добавляем необходимые префиксы к элементам списка
  addprefix(src/ SRC_FILES)
  addprefix(include/${PROJECT_NAME}/ INCLUDE_FILES)

  # Добавить в сборку статическую библиотеку:
  add_library(${PROJECT_NAME} STATIC ${SRC_FILES} ${INCLUDE_FILES})
  target_link_libraries(${PROJECT_NAME} ${LINK_LIBS})

  # Внутри модуля подключение заголовочных файлов происходит через #include "header.h"
  # Из сторонних модулей подключение происходит через #include "${PROJECT_NAME}/header.h"
  target_include_directories(${PROJECT_NAME} PRIVATE include/${PROJECT_NAME})
  target_include_directories(${PROJECT_NAME} INTERFACE include)

endmacro(make_library)
