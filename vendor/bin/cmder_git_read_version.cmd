@echo off

:cmder_read_version
:::===============================================================================
:::read_version - Get the git.exe verion
:::.
:::include:
:::.
:::  call "lib_git.cmd"
:::.
:::usage:
:::.
:::  %lib_git% read_version "[dir_path]"
:::.
:::required:
:::.
:::  [GIT SCOPE]   <in> USER | VENDORED
:::  [GIT PATH]    <in> Fully qualified path to the Git command root.
:::.
:::output:
:::.
:::  GIT_VERSION_[GIT SCOPE] <out> Env variable containing Git semantic version string
:::-------------------------------------------------------------------------------

    :: clear the variables
    set GIT_VERSION_%~1=

    :: set the executable path
    set "git_executable=%~2\git.exe"
    if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd" :read_version "Env Var - git_executable=%git_executable%"

    :: check if the executable actually exists
    if not exist "%git_executable%" (
        if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd" :read_version "%git_executable% does not exist."
        exit /b -255
    )

    :: get the git version in the provided directory

    "%git_executable%" --version > "%temp%\git_version.txt"
    setlocal enabledelayedexpansion
    for /F "tokens=1,2,3 usebackq" %%A in (`type "%temp%\git_version.txt" 2^>nul`) do (
        if /i "%%A %%B" == "git version" (
            set "GIT_VERSION=%%C"
        ) else (
            echo "'git --version' returned an inproper version string!"
            pause
            exit /b
        )
    )
    endlocal & set "GIT_VERSION_%~1=%GIT_VERSION%" & if %debug_output% gtr 0 call "%CMDERR_BIN%\cmder_debug_output.cmd" :read_version "Env Var - GIT_VERSION_%~1=%GIT_VERSION%"

    exit /b

