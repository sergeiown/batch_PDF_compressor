@REM [Copyright (c) 2023 - 2024 Serhii I. Myshko](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md)

@echo off

@REM Automatic language selection according to the system language with the subsequent use of the universal UTF-8 code

for /f %%A in ('wmic os get locale ^| find "0"') do set "LOCALE=%%A"
if "%LOCALE%"=="0422" (
    chcp 65001 >nul
    echo Мова інтерфейсу: українська >> %outputFile%
    set "file_name=messages/messages_ukrainian.txt"
    echo.
    cls
) else if "%LOCALE%"=="0419" (
    chcp 65001 >nul
    echo Язык интерфейса: русский >> %outputFile%
    set "file_name=messages/messages_russian.txt"
    echo.
    cls
) else (
    chcp 65001 >nul
    echo Interface language: English >> %outputFile%
    set "file_name=messages/messages_english.txt"
    echo.
    cls
)

@REM Use external txt files with messages
for /f "delims=" %%a in (%file_name%) do (set "%%a")