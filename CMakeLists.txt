cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(project)

# Установка версии сборки
set(VERSION_MAJOR "0")
set(VERSION_MINOR "1")

# Путь к модулям cmake
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

# Получение данных о версии
include(get_version)
get_version()

# Установка переменных CMake
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pthread")

if (CMAKE_COMPILER_IS_GNUCXX OR APPLE)
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Ofast")
  add_compile_options(-fPIC -Wall)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
endif ()

# Пути бинарников
set(bin ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${bin}/${CMAKE_BUILD_TYPE}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${bin}/${CMAKE_BUILD_TYPE}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${bin}/${CMAKE_BUILD_TYPE}/lib)

set_property(GLOBAL PROPERTY VERSION ${VERSION})

# Установка типа сборки
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug")
  message(STATUS "DEBUG BUILD")
elseif (CMAKE_BUILD_TYPE STREQUAL "Debug")
  message(STATUS "DEBUG BUILD")
  add_definitions(-DDEBUG)
  add_definitions(-D_DEBUG)
elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
  message(STATUS "RELEASE BUILD")
  if (CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s")
  endif (CMAKE_COMPILER_IS_GNUCXX)
endif ()

if(${CMAKE_BUILD_TYPE} STREQUAL Debug)
  option(DEBUG_MODE "Сборка осуществляется в режиме Debug" ON)
else()
  option(DEBUG_MODE "Сборка осуществляется в режиме Debug" OFF)
endif()

# Требовать обработку файла "src/CMakeFiles.txt"
add_subdirectory(src)

# Добавление цели сборки: создание/обновление проекта Xcode
if(APPLE)
add_custom_target(xcode COMMAND cmake -B xcode -G Xcode
                        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
endif(APPLE)
