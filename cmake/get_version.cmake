# Макрос создает все перечисленные ниже переменные,
# получая информации из git'a через терминал
# Информация о версии:
#   VERSION_MAJOR       - старшая версия приложения
#   VERSION_MINOR       - младшая версия приложения
#   VERSION_REVISION    - мелкие изменения
# Информация о последнем коммите:
#   COMMITTER_NAME      - имя автора
#   COMMITTER_EMAIL     - почта автора
#   COMMITTER_FULLSHA   - полный хэш
#   COMMITTER_SHORTSHA  - короткий хэш
#   COMMITTER_DATE      - дата
#   COMMITTER_NOTE      - комментарий

macro(get_version)

  execute_process(COMMAND git rev-list --count HEAD master
                  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                  OUTPUT_STRIP_TRAILING_WHITESPACE
                  OUTPUT_VARIABLE VERSION_REVISION
  )
  execute_process(COMMAND git log -n 1 --pretty=format:%cn
                  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                  OUTPUT_VARIABLE COMMITTER_NAME
  )
  execute_process(COMMAND git log -n 1 --pretty=format:%ce
                  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                  OUTPUT_VARIABLE COMMITTER_EMAIL
  )
  execute_process(COMMAND git log -n 1 --pretty=format:%H
                  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                  OUTPUT_VARIABLE COMMITTER_FULLSHA
  )
  execute_process(COMMAND git log -n 1 --pretty=format:%h
                  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                  OUTPUT_VARIABLE COMMITTER_SHORTSHA
  )
  execute_process(COMMAND git log -n 1 --pretty=format:%ci
                  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                  OUTPUT_VARIABLE COMMITTER_DATE
  )
  execute_process(COMMAND git log -n 1 --pretty=format:%s
                  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                  OUTPUT_VARIABLE COMMITTER_NOTE
  )

  # Вывод полученных данных на экран
  message(STATUS "VERSION: " ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_REVISION})
  message(STATUS "COMMITTER_NAME: " ${COMMITTER_NAME})
  message(STATUS "COMMITTER_EMAIL: " ${COMMITTER_EMAIL})
  message(STATUS "COMMITTER_FULLSHA: " ${COMMITTER_FULLSHA})
  message(STATUS "COMMITTER_SHORTSHA: " ${COMMITTER_SHORTSHA})
  message(STATUS "COMMITTER_DATE: " ${COMMITTER_DATE})
  message(STATUS "COMMITTER_NOTE: " ${COMMITTER_NOTE})

endmacro(get_version)
