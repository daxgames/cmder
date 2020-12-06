@echo off

:debug_output
:::===============================================================================
:::debug_output - Output a debug message to the console.
:::.
:::include:
:::.
:::  call "lib_console.cmd"
:::.
:::usage:
:::.
:::  %lib_console% debug_output [caller] [message]
:::.
:::required:
:::.
:::  [caller]  <in> Script/sub routine name calling debug_output
:::.
:::  [message] <in> Message text to display.
:::.
:::-------------------------------------------------------------------------------

    REM if %debug_output% gtr 0 echo DEBUG(%~1): %~2 & echo.
    echo DEBUG(%~1): %~2 & echo.
    exit /b
