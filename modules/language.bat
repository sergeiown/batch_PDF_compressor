@REM [Copyright (c) 2023 - 2024 Serhii I. Myshko](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md)

@echo off

set "LOCALE="
for /f %%A in ('wmic os get locale ^| find "0"') do set "LOCALE=%%A"

if "%LOCALE%"=="" (
    for /f "tokens=3" %%A in ('reg query "HKCU\Control Panel\International" /v LocaleName 2^>nul') do set "LOCALE=%%A"
)

if "%LOCALE%"=="" (
    for /f %%A in ('powershell -Command "(Get-Culture).Name"') do set "LOCALE=%%A"
)

if "%LOCALE%"=="" (
    for /f "tokens=2 delims=:" %%A in ('systeminfo ^| find "System Locale"') do (
        for /f "tokens=1 delims=;" %%B in ("%%A") do (
            for /f "tokens=* delims= " %%C in ("%%B") do set "LOCALE=%%C"
        )
    )
)

chcp 65001 >nul
if "%LOCALE%"=="0422" (
    echo Мова інтерфейсу: українська >> %outputFile%
    set "file_name=messages/messages_ukrainian.txt"
    echo.
    cls
) else if "%LOCALE%"=="0419" (
    echo Язык интерфейса: русский >> %outputFile%
    set "file_name=messages/messages_russian.txt"
    echo.
    cls
) else if "%LOCALE%"=="uk-UA" (
    echo Мова інтерфейсу: українська >> %outputFile%
    set "file_name=messages/messages_ukrainian.txt"
    echo.
    cls
) else if "%LOCALE%"=="ru-RU" (
    echo Язык интерфейса: русский >> %outputFile%
    set "file_name=messages/messages_russian.txt"
    echo.
    cls
) else if "%LOCALE%"=="uk" (
    echo Мова інтерфейсу: українська >> %outputFile%
    set "file_name=messages/messages_ukrainian.txt"
    echo.
    cls
) else if "%LOCALE%"=="ru" (
    echo Язык интерфейса: русский >> %outputFile%
    set "file_name=messages/messages_russian.txt"
    echo.
    cls
) else (
    echo Interface language: English >> %outputFile%
    set "file_name=messages/messages_english.txt"
    echo.
    cls
)

for /f "delims=" %%a in (%file_name%) do (set "%%a")