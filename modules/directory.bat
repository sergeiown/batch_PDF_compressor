@echo off

@REM Select a directory using the FolderBrowserDialog
set "maxAttempts=3"
set "attempt=1"
:input_path
echo. & echo. >> %outputFile%
echo %msg_5%
echo.
set "folderSelection="
for /f "delims=" %%d in ('powershell -Command "$culture = [System.Globalization.CultureInfo]::CreateSpecificCulture('%culture%'); Add-Type -AssemblyName System.Windows.Forms; $f = New-Object Windows.Forms.FolderBrowserDialog; $f.Description = '%msg_5%'; $f.Language = $culture; $f.ShowDialog(); $f.SelectedPath"') do set "folderSelection=%%d"
set "directory=%folderSelection%"
echo %directory% & echo %msg_26% %directory% >> %outputFile%
echo. >> %outputFile%
timeout /t 1 >nul

@REM Check if the directory exists for three times
if not exist "%directory%" (
    echo %msg_25% & echo %msg_25% >> %outputFile%
    if %attempt% lss %maxAttempts% (
        set /a "attempt+=1"
        cls
        goto input_path
    ) else (
        cls
        color 1C
        echo. & echo. >> %outputFile%
        echo %msg_27% & echo %msg_27% >> %outputFile%
        echo. & echo. >> %outputFile%
        pause
        color
        start notepad "%outputFile%"
        set "exitScript=1"
        timeout /t 1 >nul
        exit /b
    )
)