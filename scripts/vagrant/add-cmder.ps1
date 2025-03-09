choco install -y --force 7zip 7zip.install
choco install -y --force cmder

$env:path = "$env:path;c:\tools\cmder\vendor\git-for-windows\cmd;c:\tools\cmder\vendor\git-for-windows\usr\bin;c:\tools\cmder\vendor\git-for-windows\mingw64\bin"
c:
cd $env:userprofile
git clone https://github.com/cmderdev/cmder cmderdev 2>&1

if ("$env:USERNAME" -eq "vagrant" -and -not (test-path "$env:userprofile\cmderdev\vendor\git-for-windows")) {
  invoke-expression -command "TAKEOWN /F `"$env:userprofile\cmderdev`" /R /D y /s localhost /u vagrant /p vagrant"
}

cd  $env:userprofile/cmderdev
git remote add upstream  https://github.com/cmderdev/cmder

Install-PackageProvider -Name NuGet -Force
install-module posh-git -force

cmd.exe /c "call `"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat`" && set > %temp%\vcvars.txt"
Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    Set-Content "env:\$($matches[1])" $matches[2]
  }
}

copy-item -erroraction silentlycontinue "C:\Tools\Cmder\Cmder.exe" "$env:userprofile\cmderdev"
remove-item -erroraction silentlycontinue "$env:userprofile\cmderdev\launcher\x64\release\cmder.exe" -force

start-process -erroraction silentlycontinue -nonewwindow -workingdirectory "$env:userprofile\cmderdev\scripts" -filepath "powershell.exe" -argumentlist ".\build.ps1 -verbose -compile"

copy-item -erroraction silentlycontinue "$env:userprofile\cmderdev\launcher\x64\release\cmder.exe" "$env:userprofile\cmderdev" -force

# tabby
setx cmder_root "${env:userprofile}\cmderdev"

# C:\Users\vagrant\AppData\Roaming\Hyper
#         // shell: '',
#         shell: 'cmd.exe',
#         // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
#         // by default `['--login']` will be used
#         // shellArgs: ['--login'],
#         shellArgs: ['/k', 'C:\\users\\vagrant\\cmderdev\\vendor\\init.bat'],


