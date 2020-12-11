@echo off

:compare_versions
:::===============================================================================
:::compare_versions - Compare semantic versions return latest version.
:::.
:::usage:
:::.
:::  call "%CMDERR_BIN%\cmder_git_compare_versions.cmd" [SCOPE1] [SCOPE2]
:::.
:::required:
:::.
:::  [SCOPE1]    <in> Example: USER
:::  [SCOPE2]    <in> Example: VENDOR
:::-------------------------------------------------------------------------------

    :: checks all major, minor, patch and build variables for the given arguments.
    :: whichever binary that has the most recent version will be used based on the return code.

    %debug_print% Comparing:
    %debug_print% %~1: %USER_MAJOR%.%USER_MINOR%.%USER_PATCH%.%USER_BUILD%
    %debug_print% %~2: %VENDORED_MAJOR%.%VENDORED_MINOR%.%VENDORED_PATCH%.%VENDORED_BUILD%

    setlocal enabledelayedexpansion
    if !%~1_MAJOR! GTR !%~2_MAJOR! (endlocal & exit /b  1)
    if !%~1_MAJOR! LSS !%~2_MAJOR! (endlocal & exit /b -1)

    if !%~1_MINOR! GTR !%~2_MINOR! (endlocal & exit /b  1)
    if !%~1_MINOR! LSS !%~2_MINOR! (endlocal & exit /b -1)

    if !%~1_PATCH! GTR !%~2_PATCH! (endlocal & exit /b  1)
    if !%~1_PATCH! LSS !%~2_PATCH! (endlocal & exit /b -1)

    if !%~1_BUILD! GTR !%~2_BUILD! (endlocal & exit /b  1)
    if !%~1_BUILD! LSS !%~2_BUILD! (endlocal & exit /b -1)

    :: looks like we have the same versions.
    endlocal & exit /b 0
