@echo off

setlocal enabledelayedexpansion
set search=%~1
set replace=%~2


echo %search% | findstr -i "git" >nul
if "%errorlevel%" == "1" exit /b

set path=!path:%search%=%replace%!
(endlocal
 set "path=%path%")

exit /b
