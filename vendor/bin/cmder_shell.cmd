@echo off

:cmder_shell
:::===============================================================================
:::show_subs - shows all sub routines in a .bat/.cmd file with documentation
:::.
:::include:
:::.
:::       call "lib_base.cmd"
:::.
:::usage:
:::.
:::       %lib_base% cmder_shell
:::.
:::options:
:::.
:::       file <in> full path to file containing lib_routines to display
:::.
:::-------------------------------------------------------------------------------
    echo %comspec% | %WINDIR%\System32\find /i "\cmd.exe" > nul && set "CMDER_SHELL=cmd"
    echo %comspec% | %WINDIR%\System32\find /i "\tcc.exe" > nul && set "CMDER_SHELL=tcc"
    echo %comspec% | %WINDIR%\System32\find /i "\tccle" > nul && set "CMDER_SHELL=tccle"

    if not defined CMDER_CLINK (
        set CMDER_CLINK=1
        if "%CMDER_SHELL%" equ "tcc" set CMDER_CLINK=0
        if "%CMDER_SHELL%" equ "tccle" set CMDER_CLINK=0
    )

    if not defined CMDER_ALIASES (
        set CMDER_ALIASES=1
        if "%CMDER_SHELL%" equ "tcc" set CMDER_ALIASES=0
        if "%CMDER_SHELL%" equ "tccle" set CMDER_ALIASES=0
    )

    exit /b
