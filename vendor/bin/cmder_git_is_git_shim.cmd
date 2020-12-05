@echo off

:::===============================================================================
:::is_git_shim
:::.
:::include:
:::.
:::  call "$0"
:::.
:::usage:
:::.
:::  call "%CMDERR_BIN%\cmder_git_is_git_shim.cmd" [filepath]
:::.
:::required:
:::.
:::  [filepath]    <in>
:::-------------------------------------------------------------------------------

:is_git_shim
    pushd "%~1"
    :: check if there's shim - and if yes follow the path
    setlocal enabledelayedexpansion
    if exist git.shim (
        for /F "tokens=2 delims== " %%I in (git.shim) do (
            pushd %%~dpI
            set "test_dir=!CD!"
            popd
        )
    ) else (
        set "test_dir=!CD!"
    )
    endlocal & set "test_dir=%test_dir%"

    popd
    exit /b