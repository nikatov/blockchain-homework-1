# Макрос создает исполнимый файл и связанную с ним библиотеку.
# Для успешной работы макроса, перед его использованием,
# необходимо проинициализировать следующие переменные:
#   ${PROJECT_NAME}   - имя проекта. project(proj_name)
#   ${INCLUDE_FILES}  - список заголовочных файлов
#   ${SRC_FILES}      - список файлов реализации
# Также, возможно, потребуется указать следующие переменные:
#   ${LINK_LIBS}      - список библиотек для линковки
# После чего достаточно вставить макрос

# Целью исполняемого файла будет являться ${PROJECT_NAME}
# Целью связанной с ним библиотеки будет ${PROJECT_NAME} + "_lib"
# Исполняемый файл будет называться ${PROJECT_NAME}
# Файл библиотеки будет называться "lib" + ${PROJECT_NAME}

macro(make_executable)
  # Подключаем модуль addprefix
  include(addprefix)

  # Добавляем необходимые префиксы к элементам списка
  addprefix(src/ SRC_FILES)
  addprefix(include/${PROJECT_NAME}/ INCLUDE_FILES)

  set(PROJECT_LIBRARY ${PROJECT_NAME}_lib)

  # Добавить в сборку статическую библиотеку:
  add_library(${PROJECT_LIBRARY} STATIC ${SRC_FILES} ${INCLUDE_FILES})
  set_target_properties(${PROJECT_LIBRARY} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})

  # Прилинковать модули из LINK_LIBS
  target_link_libraries(${PROJECT_LIBRARY} ${LINK_LIBS})

  # Внутри модуля подключение заголовочных файлов происходит через #include "header.h"
  # Из сторонних модулей подключение происходит через #include "${PROJECT_NAME}/header.h"
  target_include_directories(${PROJECT_LIBRARY} PUBLIC include/${PROJECT_NAME})

  # Включение в сборку бинарного файла
  add_executable(${PROJECT_NAME} src/main.cpp)
  target_link_libraries(${PROJECT_NAME} ${PROJECT_LIBRARY})
  
endmacro(make_executable)
