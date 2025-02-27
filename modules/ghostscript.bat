@REM [Copyright (c) 2023 - 2025 Serhii I. Myshko](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md)

@echo off

:check_again
set "gsRootPath64=%ProgramFiles%\gs"
set "gsRootPath32=%ProgramFiles(x86)%\gs"
set "gsExecutable="

for /d %%D in ("%gsRootPath64%\gs*") do (
    if exist "%%D\bin\gswin64c.exe" (
        set "gsExecutable=%%D\bin\gswin64c.exe"
        goto found_gs
    )
)

for /d %%D in ("%gsRootPath32%\gs*") do (
    if exist "%%D\bin\gswin32c.exe" (
        set "gsExecutable=%%D\bin\gswin32c.exe"
        goto found_gs
    )
)

where gswin64c.exe >nul 2>&1
if errorlevel 0 (
    for /f "delims=" %%I in ('where gswin64c.exe') do (
        set "gsExecutable=%%I"
        goto found_gs
    )
)

where gswin32c.exe >nul 2>&1
if errorlevel 0 (
    for /f "delims=" %%I in ('where gswin32c.exe') do (
        set "gsExecutable=%%I"
        goto found_gs
    )
)

cls
echo %error_separator% & echo %error_separator% >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_35% & echo %msg_35% >> %outputFile%
echo %msg_36% & echo %msg_36% >> %outputFile%
timeout /t 2 >nul

call modules/installer.bat

echo %msg_52% & echo %msg_52% >> %outputFile%
echo %error_separator% & echo %error_separator% >> %outputFile%

if "%exitScript%"=="0" (
    timeout /t 5 >nul
    cls
    goto check_again
) else (
    cls & title = Batch PDF compressor
    color 1C
    echo %error_separator% & echo %error_separator% >> %outputFile%
    echo. & echo. >> %outputFile%
    echo %msg_1% & echo %msg_1% >> %outputFile%
    echo.
    echo %msg_2% & echo %msg_2% >> %outputFile%
    echo.
    echo %ghostscript_link% & echo %ghostscript_link% >> %outputFile%
    echo.
    echo %ghostscript_altlink% & echo %ghostscript_altlink% >> %outputFile%
    echo.
    echo %error_separator% & echo %error_separator% >> %outputFile%
    timeout /t 2 >nul
    echo.
    pause
    color
    start notepad "%outputFile%"
    set "exitScript=1"
    exit /b
)

:found_gs
title Batch PDF compressor
color 1A
echo %short_separator%
echo. & echo. >> %outputFile%
for /f "delims=" %%v in ('"%gsExecutable%" --version 2^>^&1') do set "ghostscript_version=%%v"
echo %msg_3% %ghostscript_version% & echo %msg_3% %ghostscript_version% >> %outputFile%
echo.
echo %interface_lang%
echo.
echo %msg_4%
echo.
echo %short_separator%
timeout /t 2 >nul
color 1F
