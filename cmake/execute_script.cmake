function(execute_script script_name)
  # К названию скрипта добавляем директорию и расширение
  if (WIN32)
    set(command "${SCRIPTS_DIR}/${script_name}.bat")
  else (WIN32)
    set(command "${SCRIPTS_DIR}/${script_name}.sh")
  endif (WIN32)

  # Выполняем скрипт
  execute_process(COMMAND ${command}
                  WORKING_DIRECTORY "${SCRIPTS_DIR}")
endfunction(execute_script)
