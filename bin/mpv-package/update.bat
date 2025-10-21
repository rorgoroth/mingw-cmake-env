@echo OFF
pushd %~dp0

if exist "%~dp0\installer\update.ps1" (
    echo Error: Installation/Registration method has changed.
    echo Error: It is recommended you run the uninstaller
    echo Error: and then delete the 'installer' directory.
    echo Error: You can then run 'mpv-register.bat'
    TIMEOUT /T 30
)

if exist "%~dp0\xupdate.ps1" (
    set updater_script="%~dp0\xupdate.ps1"
) else (
    set updater_script="%~dp0\update.ps1"
)
powershell -noprofile -nologo -executionpolicy bypass -File %updater_script%