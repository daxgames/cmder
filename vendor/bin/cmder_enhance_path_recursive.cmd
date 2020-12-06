@echo off


:enhance_path_recursive
:::===============================================================================
:::enhance_path_recursive - Add a directory and subs to the path env variable if
:::                         required.
:::.
:::include:
:::.
:::  call "$0"
:::.
:::usage:
:::.
:::  call "%~DP0lib_path" enhance_path_recursive "[dir_path]" [max_depth] [append]
:::.
:::required:
:::.
:::  [dir_path] <in> Fully qualified directory path. Ex: "c:\bin"
:::.
:::options:
:::.
:::  [max_depth] <in> Max recuse depth.  Default: 1
:::.
:::  append      <in> Append instead to path env variable rather than pre-pend.
:::.
:::output:
:::.
:::  path       <out> Sets the path env variable if required.
:::-------------------------------------------------------------------------------
    if "%~1" neq "" (
        set "add_path=%~1"
    ) else (
        call "%CMDERR_BIN%\cmder_show_error.cmd" "You must specify a directory to add to the path!"
        exit 1
    )

    set "depth=%~2"
    set "max_depth=%~3"

    if "%~4" neq "" if /i "%~4" == "append" (
        set "position=%~4"
    ) else (
        set "position="
    )

    dir "%add_path%" 2>NUL | findstr -i "\.COM \.EXE \.BAT \.CMD \.PS1 \.VBS" >NUL

    if "%ERRORLEVEL%" == "0" (
        set "add_to_path=%add_path%"
    ) else (
        set "add_to_path="
    )

    if "%fast_init%" == "1" (
        if "%add_to_path%" neq "" (
            call cmder_enhance_path "%add_to_path%" %position%
        )
    )

    set "PATH=%PATH:;;=;%"
    if "%fast_init%" == "1" (
      exit /b
    )

    if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path_recursive "Env Var - add_path=%add_to_path%"
    if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path_recursive "Env Var - position=%position%"
    if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path_recursive "Env Var - depth=%depth%"
    if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path_recursive "Env Var - max_depth=%max_depth%"

    if %max_depth% gtr %depth% (
        if "%add_to_path%" neq "" (
            if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd" :enhance_path_recursive "Adding parent directory - '%add_to_path%'"
            call cmder_enhance_path "%add_to_path%" %position%
        )
        call :set_depth
        call :loop_depth
    )

    set "PATH=%PATH%"

    exit /b

: set_depth
    set /a "depth=%depth%+1"
    exit /b

:loop_depth
    if %depth% == %max_depth% (
        exit /b
    )

    for /d %%i in ("%add_path%\*") do (
        if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path_recursive "Env Var BEFORE - depth=%depth%"
        if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd" :enhance_path_recursive "Found Subdirectory - '%%~fi'"
        call cmder_enhance_path_recursive "%%~fi" %depth% %max_depth% %position%
        if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd"  :enhance_path_recursive "Env Var AFTER- depth=%depth%"
    )
    exit /b

:set_found
    if "%ERRORLEVEL%" == "0" (
      set found=1
    )

    exit /b
