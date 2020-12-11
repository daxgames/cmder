@ECHO OFF

:verbose_output
:::===============================================================================
:::verbose_output - Output a debug message to the console.
:::.
:::include:
:::.
:::  call "$0"
:::.
:::usage:
:::.
:::  %lib_console% verbose_output "[message]"
:::.
:::required:
:::.
:::  [message] <in> Message text to display.
:::.
:::-------------------------------------------------------------------------------

    if %verbose_output% gtr 0 echo %~1
    exit /b

