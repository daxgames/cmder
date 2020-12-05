@echo off

:enhance_path
:::===============================================================================
:::enhance_path - Add a directory to the path env variable if required.
:::
:::usage:
:::
:::  call cmder_enhance_path "[dir_path]" [append]
:::
:::required:
:::
:::  [dir_path] <in> Fully qualified directory path. Ex: "c:\bin"
:::
:::options:
:::
:::  append     <in> Append to the path env variable rather than pre-pend.
::B
:::
:::output:
:::
:::  path       <out> Sets the path env variable if required.
:::-------------------------------------------------------------------------------

    if "%~1" neq "" (
        set "add_path=%~1"
    ) else (
        call "%CMDERR_BIN%\cmder_show_error.cmd" "You must specify a directory to add to the path!"
        exit 1
    )

    if "%~2" neq "" if /i "%~2" == "append" (
        set "position=%~2"
    ) else (
        set "position="
    )

    dir "%add_path%" | findstr -i "\.COM \.EXE \.BAT \.CMD \.PS1 \.VBS" >NUL
    if "%ERRORLEVEL%" == "0" (
        set "add_to_path=%add_path%"
    ) else (
        set "add_to_path="
    )

    if "%fast_init%" == "1" (
      if "%position%" == "append" (
        set "PATH=%PATH%;%add_to_path%"
      ) else (
        set "PATH=%add_to_path%;%PATH%"
      )
      goto :end_enhance_path
    ) else if "add_to_path" equ "" (
      goto :end_enhance_path
    )

    set found=0
    set "find_query=%add_to_path%"
    set "find_query=%find_query:\=\\%"
    set "find_query=%find_query: =\ %"
    set OLD_PATH=%PATH%

    setlocal enabledelayedexpansion
    if "%found%" == "0" (
      echo "%path%"|%WINDIR%\System32\findstr >nul /I /R /C:";%find_query%;"
      call :set_found
    )
    call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path "Env Var INSIDE PATH %find_query% - found=%found%"

    if /i "%position%" == "append" (
      if "!found!" == "0" (
        echo "%path%"|%WINDIR%\System32\findstr >nul /I /R /C:";%find_query%\"$"
        call :set_found
      )
      call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path "Env Var END PATH %find_query% - found=!found!"
    ) else (
      if "!found!" == "0" (
        echo "%path%"|%WINDIR%\System32\findstr >nul /I /R /C:"^\"%find_query%;"
        call :set_found
      )
      call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path "Env Var BEGIN PATH %find_query% - found=!found!"
    )
    endlocal & set found=%found%

    if "%found%" == "0" (
        if /i "%position%" == "append" (
            call "%CMDERR_BIN%\cmder_debug_output.cmd" :enhance_path "Appending '%add_to_path%'"
            set "PATH=%PATH%;%add_to_path%"
        ) else (
            call "%CMDERR_BIN%\cmder_debug_output.cmd" :enhance_path "Prepending '%add_to_path%'"
            set "PATH=%add_to_path%;%PATH%"
        )

        set found=1
    )

    :end_enhance_path
    set "PATH=%PATH:;;=;%"
    if NOT "%OLD_PATH%" == "%PATH%" (
      call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path "END Env Var - PATH=%path%"
      call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path "Env Var %find_query% - found=%found%"
    )
    set "position="
    exit /b

:set_found
    if "%ERRORLEVEL%" == "0" (
      set found=1
    )

    exit /b

