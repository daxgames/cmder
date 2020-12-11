@echo off

:::===============================================================================
:::get_user_git_version - get the version information for the user provided git binary
:::.
:::usage:
:::.
:::  call "%CMDERR_BIN%\cmder_git_get_user_git_version.cmd"
:::-------------------------------------------------------------------------------

:get_user_git_version
    :: get the version information for the user provided git binary
    call "%CMDERR_BIN%\cmder_git_read_version.cmd" USER "%test_dir%"
    call "%CMDERR_BIN%\cmder_git_validate_version.cmd" USER %GIT_VERSION_USER%
    exit  /b