@REM MIT License https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md

@echo off
title = Ghostscript installer

set "latestReleaseUrl=https://api.github.com/repos/ArtifexSoftware/ghostpdl-downloads/releases/latest"
set "jsonFile=%temp%\latest_release.json"
set "installerUrl="
set "downloadedInstaller="
set "exitScript=0"

set "is64Bit="
if defined ProgramFiles(x86) (
    set "is64Bit=1"
    echo Your system is 64-bit.
) else (
    echo Your system is 32-bit.
)

echo Downloading information about the latest release...
curl -s %latestReleaseUrl% -o "%jsonFile%"
if errorlevel 1 (
    echo Unable to get information about the latest release from GitHub.
    set "exitScript=1"
    exit /b
)

if not exist "%jsonFile%" (
    echo JSON file not found or not loaded.
    set "exitScript=1"
    exit /b
)

echo Information has been successfully uploaded: %jsonFile%.

set "installerFound=0"
if defined is64Bit (
    echo Finding an installer for the 64-bit version...
    for /f "delims=" %%i in ('findstr /C:"w64.exe" "%jsonFile%"') do (
        echo Found 64-bit installer line: %%i
        set "installerFound=1"
        for /f "tokens=2 delims= " %%j in ('echo %%i ^| findstr /C:browser_download_url') do (
            set "installerUrl=%%j"
            goto process_url
        )
    )
) else (
    echo Finding an installer for the 32-bit version...
    for /f "delims=" %%i in ('findstr /C:"w32.exe" "%jsonFile%"') do (
        echo Found 32-bit installer line: %%i
        set "installerFound=1"
        for /f "tokens=2 delims= " %%j in ('echo %%i ^| findstr /C:"browser_download_url"') do (
            set "installerUrl=%%j"
            goto process_url
        )
    )
)

:process_url
if "%installerUrl%"=="" (
    echo The installer for your system could not be found.
    set "exitScript=1"
    exit /b
)

set "installerUrl=%installerUrl:"=%"
set "installerUrl=%installerUrl: =%"

for /f "tokens=* delims=" %%k in ("%installerUrl%") do set "installerUrl=%%k"

echo Installer found: %installerUrl%.

set "downloadedInstaller=%temp%\GhostscriptInstaller.exe"
echo Downloading the installer from %installerUrl%...
curl -L %installerUrl% -o "%downloadedInstaller%"

if exist "%downloadedInstaller%" (
    echo Ghostscript installer has been downloaded successfully.
    start /wait "" "%downloadedInstaller%" 2>nul
    del /q "%downloadedInstaller%" 2>nul
    del /q "%jsonFile%" 2>nul
    echo Ghostscript installer has been launched successfully.
    set "exitScript=0"
    exit /b
) else (
    echo Downloading the installer failed.
    set "exitScript=1"
    exit /b
)
