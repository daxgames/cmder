@echo off

:run_profile_d
:::===============================================================================
:::run_profile_d - Run all scripts in the passed dir path
:::
:::include:
:::
:::  call "lib_profile.cmd"
:::
:::usage:
:::
:::  %lib_profile% "[dir_path]"
:::
:::required:
:::
:::  [dir_path] <in> Fully qualified directory path containing init *.cmd|*.bat.
:::                  Example: "c:\bin"
:::
:::  path       <out> Sets the path env variable if required.
:::-------------------------------------------------------------------------------

  if not exist "%~1" (
    mkdir "%~1"
  )

  pushd "%~1"
  for /f "usebackq" %%x in ( `dir /b *.bat *.cmd 2^>nul` ) do (
    %lib_console% verbose_output "Calling '%~1\%%x'..."
    call "%~1\%%x"
  )
  popd
  exit /b
