@echo off

:cmder_gitset_user_git_path
  setlocal enabledelayedexpansion
  set x=%~1
  if not defined CMDER_USER_GIT_PATH set "CMDER_USER_GIT_PATH=%x:~0,-4%" && goto set_user_path_end
  if defined CMDER_USER_GIT_PATH echo %x% | findstr "!CMDER_USER_GIT_PATH!" >nul
  if defined CMDER_USER_GIT_PATH if ERRORLEVEL 1 (
    set "CMDER_USER_GIT_PATH=%x:~0,-4%"
  )

  :set_user_path_end
  (endlocal
   set "CMDER_USER_GIT_PATH=%CMDER_USER_GIT_PATH%")

  exit /b
