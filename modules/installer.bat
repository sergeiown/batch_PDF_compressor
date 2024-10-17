@REM [Copyright (c) 2023 - 2024 Serhii I. Myshko](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md)

@echo off
title = Ghostscript installer

set "latestReleaseUrl=%ghostscript_release_link%"
set "jsonFile=%temp%\latest_release.json"
set "installerUrl="
set "downloadedInstaller="
set "exitScript=0"
set "is64Bit=0"

if defined ProgramFiles(x86) (
    set "is64Bit=1"
    echo %msg_37% & echo %msg_37% >> %outputFile%
) else (
    echo %msg_38% & echo %msg_38% >> %outputFile%
)

echo %msg_39% & echo %msg_39% >> %outputFile%
curl -s %latestReleaseUrl% -o "%jsonFile%"
if errorlevel 1 (
    echo %msg_40% & echo %msg_40% >> %outputFile%
    set "exitScript=1"
    exit /b
)

if not exist "%jsonFile%" (
    echo %msg_41% & echo %msg_41% >> %outputFile%
    set "exitScript=1"
    exit /b
)

echo %msg_42% & echo %msg_42% >> %outputFile%

set "installerFound=0"
if "%is64Bit%"=="1" (
    echo %msg_43% & echo %msg_43% >> %outputFile%
    for /f "delims=" %%i in ('findstr /C:"w64.exe" "%jsonFile%"') do (
        echo %msg_45% %%i & echo %msg_45% %%i >> %outputFile%
        set "installerFound=1"
        for /f "tokens=2 delims= " %%j in ('echo %%i ^| findstr /C:browser_download_url') do (
            set "installerUrl=%%j"
            goto process_url
        )
    )
) else (
    echo %msg_44% & echo %msg_44% >> %outputFile%
    for /f "delims=" %%i in ('findstr /C:"w32.exe" "%jsonFile%"') do (
        echo %msg_45% %%i & echo %msg_45% %%i >> %outputFile%
        set "installerFound=1"
        for /f "tokens=2 delims= " %%j in ('echo %%i ^| findstr /C:"browser_download_url"') do (
            set "installerUrl=%%j"
            goto process_url
        )
    )
)

:process_url
if "%installerUrl%"=="" (
    echo %msg_46% & echo %msg_46% >> %outputFile%
    set "exitScript=1"
    exit /b
)

set "installerUrl=%installerUrl:"=%"
set "installerUrl=%installerUrl: =%"

for /f "tokens=* delims=" %%k in ("%installerUrl%") do set "installerUrl=%%k"

echo %msg_47% %installerUrl% & echo %msg_47% %installerUrl% >> %outputFile%

set "downloadedInstaller=%temp%\GhostscriptInstaller.exe"
echo %msg_48% & echo %msg_48% >> %outputFile%

echo.
curl -L %installerUrl% -o "%downloadedInstaller%"
echo.

if exist "%downloadedInstaller%" (
    echo %msg_49% & echo %msg_49% >> %outputFile%
    start /wait "" "%downloadedInstaller%" 2>nul
    del /q "%downloadedInstaller%" 2>nul
    del /q "%jsonFile%" 2>nul
    echo %msg_50% & echo %msg_50% >> %outputFile%
    set "exitScript=0"
    exit /b
) else (
    echo %msg_51% & echo %msg_51% >> %outputFile%
    set "exitScript=1"
    exit /b
)
