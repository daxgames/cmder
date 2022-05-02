@echo off

setlocal enabledelayedexpansion
set search=%~1
set replace=%~2

%print_debug% %~n0 "search: %search%"
%print_debug% %~n0 "replace: %replace%"

set path=!path:%search%=%replace%!
(endlocal
 set "path=%path%")

exit /b
