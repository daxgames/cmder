@echo off

:show_error
:::===============================================================================
:::show_error - Output an error message to the console.
:::.
:::include:
:::.
:::  call "$0"
:::.
:::usage:
:::.
:::  %lib_console% show_error "[message]"
:::.
:::required:
:::.
:::  [message] <in> Message text to display.
:::.
:::-------------------------------------------------------------------------------

    echo ERROR: %~1
    exit /b
