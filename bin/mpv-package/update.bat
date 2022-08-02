@echo OFF
pushd %~dp0
if exist "%~dp0\installer\xupdate.ps1" (
    set updater_script="%~dp0\installer\xupdate.ps1"
) else (
    set updater_script="%~dp0\installer\update.ps1"
)
powershell -noprofile -nologo -executionpolicy bypass -File %updater_script%

timeout 20
