@echo off

:update_legacy_aliases
    type "%user_aliases%" | %WINDIR%\System32\findstr /i ";= Add aliases below here" >nul
    if "%errorlevel%" == "1" (
        echo Creating initial user_aliases store in "%user_aliases%"...
        if defined CMDER_USER_CONFIG (
            copy "%user_aliases%" "%user_aliases%.old_format"
            copy "%CMDER_ROOT%\vendor\user_aliases.cmd.default" "%user_aliases%"
        ) else (
            copy "%user_aliases%" "%user_aliases%.old_format"
            copy "%CMDER_ROOT%\vendor\user_aliases.cmd.default" "%user_aliases%"
        )
    )
    exit /b
