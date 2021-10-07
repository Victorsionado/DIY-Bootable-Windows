@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:: End Get ADMIN Privs

robocopy C:\W10USB\es_windows_10_consumer_editions_version_21h1_x64_dvd_34c1473e\sources F:\SOURCES /E /Z /ZB /R:5 /W:5 /TBD /NP /V /XF boot.wim
robocopy C:\W10USB\es_windows_10_consumer_editions_version_21h1_x64_dvd_34c1473e E:\ /E /Z /ZB /R:5 /W:5 /TBD /NP /V /XD sources
robocopy C:\W10USB\es_windows_10_consumer_editions_version_21h1_x64_dvd_34c1473e\sources\ E:\sources boot.wim
pause