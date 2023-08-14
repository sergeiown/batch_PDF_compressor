@echo off

@REM Check if Ghostscript is installed and show a notification if not
where gswin64c.exe >nul 2>&1
if errorlevel 1 (
    cls
    color 1C
    echo %error_separator% & echo %error_separator% >> %outputFile%
    echo. & echo. >> %outputFile%
    echo %msg_1% & echo %msg_1% >> %outputFile%
    echo %msg_2% & echo %msg_2% >> %outputFile%
    echo %ghostscript_link% & echo %ghostscript_link% >> %outputFile%
    echo. & echo. >> %outputFile%
    echo %error_separator% & echo %error_separator% >> %outputFile%
    timeout /t 2 >nul
    echo.
    pause
    color
    start notepad "%outputFile%"
    set "exitScript=1"
    exit /b
)

@REM Display current Ghostscript version
color 1A
echo %short_separator%
echo. & echo. >> %outputFile%
for /f "delims=" %%v in ('gswin64c.exe --version 2^>^&1') do set "ghostscript_version=%%v"
echo %msg_3% %ghostscript_version% & echo %msg_3% %ghostscript_version% >> %outputFile%
echo.
echo %msg_4%
echo.
echo %short_separator%
timeout /t 2 >nul
color 1F