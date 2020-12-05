@echo off

:validate_version
:::===============================================================================
:::validate_version - Validate semantic version string 'x.x.x.x'.
:::.
:::include:
:::.
:::  call "$0"
:::.
:::usage:
:::.
:::  call "%CMDERR_BIN%\cmder_git_validate_version.cmd" [SCOPE] [VERSION]
:::.
:::required:
:::.
:::  [SCOPE]     <in> Example:  USER | VENDORED
:::  [VERSION]   <in> Semantic version String. Ex: 1.2.3.4
:::-------------------------------------------------------------------------------

    :: now parse the version information into the corresponding variables
    call "%CMDERR_BIN%\cmder_debug_output.cmd" :validate_version "ARGV[1]=%~1, ARGV[2]=%~2"

    call "%CMDERR_BIN%\cmder_git_parse_version.cmd" %~1 %~2

    :: ... and maybe display it, for debugging purposes.
    REM call "%CMDERR_BIN%\cmder_debug_output.cmd" :validate_version "Found Git Version for %~1: !%~1_MAJOR!.!%~1_MINOR!.!%~1_PATCH!.!%~1_BUILD!"
    if "%~1" == "VENDORED" (
      call "%CMDERR_BIN%\cmder_debug_output.cmd" :validate_version "Found Git Version for %~1: %VENDORED_MAJOR%.%VENDORED_MINOR%.%VENDORED_PATCH%.%VENDORED_BUILD%"
    ) else (
      call "%CMDERR_BIN%\cmder_debug_output.cmd" :validate_version "Found Git Version for %~1: %USER_MAJOR%.%USER_MINOR%.%USER_PATCH%.%USER_BUILD%"
    )
    exit /b
