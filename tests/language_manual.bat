@echo off

@REM Manual language selection with universal UTF-8 code page
cls
choice /c 123 /n /m "Choose your language (1 - English, 2 - Ukrainian, 3 - Russian): "
set "lang=%errorlevel%"

if "%lang%"=="2" (
    chcp 65001 >nul
    echo Обрана мова: українська >> %outputFile%
    set "file_name=messages/messages_ukrainian.txt"
    echo.
    cls
)
if "%lang%"=="3" (
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