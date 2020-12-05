@echo off

:parse_version
:::===============================================================================
:::parse_version - Parse semantic version string 'x.x.x.x' and return the pieces
:::.
:::include:
:::.
:::  call "$0"
:::.
:::usage:
:::.
:::  call "%CMDERR_BIN%\cmder_git_parse_version.cmd" "[VERSION]"
:::.
:::required:
:::.
:::  [SCOPE]     <in> USER | VENDORED
:::  [VERSION]   <in> Semantic version String. Ex: 1.2.3.4
:::.
:::output:
:::.
:::  [SCOPE]_MAJOR <out> Scoped Major version.
:::  [SCOPE]_MINOR <out> Scoped Minor version.
:::  [SCOPE]_PATCH <out> Scoped Patch version.
:::  [SCOPE]_BUILD <out> Scoped Build version.
:::-------------------------------------------------------------------------------

    :: process a `x.x.x.xxxx.x` formatted string
    call "%CMDERR_BIN%\cmder_debug_output.cmd" :parse_version "ARGV[1]=%~1, ARGV[2]=%~2"

    setlocal enabledelayedexpansion
    for /F "tokens=1-3* delims=.,-" %%A in ("%2") do (
        set "%~1_MAJOR=%%A"
        set "%~1_MINOR=%%B"
        set "%~1_PATCH=%%C"
        set "%~1_BUILD=%%D"
    )

    REM endlocal & set "%~1_MAJOR=!%~1_MAJOR!" & set "%~1_MINOR=!%~1_MINOR!" & set "%~1_PATCH=!%~1_PATCH!" & set "%~1_BUILD=!%~1_BUILD!"
    if "%~1" == "VENDORED" (
      endlocal & set "%~1_MAJOR=%VENDORED_MAJOR%" & set "%~1_MINOR=%VENDORED_MINOR%" & set "%~1_PATCH=%VENDORED_PATCH%" & set "%~1_BUILD=%VENDORED_BUILD%"
    ) else (
      endlocal & set "%~1_MAJOR=%USER_MAJOR%" & set "%~1_MINOR=%USER_MINOR%" & set "%~1_PATCH=%USER_PATCH%" & set "%~1_BUILD=%USER_BUILD%"
    )

    exit /b
