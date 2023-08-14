@echo off

@REM Automatic language selection according to the system language with the subsequent use of the universal UTF-8 code

for /f "tokens=2 delims==" %%A in ('wmic os get oslanguage /value') do set "LANG=%%A"
if "%LANG%"=="1058" (
    chcp 65001 >nul
    echo Обрана мова: українська >> %outputFile%
    set "file_name=messages/messages_ukrainian.txt"
    echo.
    cls
) else if "%LANG%"=="1049" (
    chcp 65001 >nul
    echo Выбранный язык: русский >> %outputFile%
    set "file_name=messages/messages_russian.txt"
    echo.
    cls
) else (
    chcp 65001 >nul
    echo Selected language: English >> %outputFile%
    set "file_name=messages/messages_english.txt"
    echo.
    cls
)

@REM Use external txt files with messages
for /f "delims=" %%a in (%file_name%) do (set "%%a")