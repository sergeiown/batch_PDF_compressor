@echo off
color 08

REM Enable delayed variable expansion
REM This allows obtaining updated variable values inside loops and code blocks
setlocal enabledelayedexpansion

REM Check if Ghostscript is installed
where gswin64c.exe >nul 2>&1
if errorlevel 1 (
    cls
    color 0C

    echo Ghostscript is not installed.
    echo Please download and install Ghostscript from the following link:
    echo https://ghostscript.com/releases/gsdnld.html

    pause
    color

    exit /b
)

REM Display current Ghostscript version
echo Current Ghostscript version:
gswin64c.exe --version
echo All right, let's begin.
echo.

REM Pause for 3 seconds and prompt for path input
timeout /t 3 >nul

echo Enter the path to the directory with PDF files:
echo.
set /p directory=

echo.

REM Add compression level options
echo Select compression level:
echo 1 - Low quality (screen)
echo 2 - Medium quality (ebook)
echo 3 - High quality (printer)
echo 4 - Ultra quality (prepress)
echo.
set /p compresslevel=

REM Add logic to choose the corresponding compression level
if "%compresslevel%"=="1" set "pdfsettings=/screen"
if "%compresslevel%"=="2" set "pdfsettings=/ebook"
if "%compresslevel%"=="3" set "pdfsettings=/printer"
if "%compresslevel%"=="4" set "pdfsettings=/prepress"

echo.

for %%F in ("%directory%\*.pdf") do (
  set "input=%%F"
  set "output=!directory!\%%~nF_compressed.pdf"
  
  echo ---
  echo Compressing file: %%F
  
  REM Modified code to use Ghostscript with the selected compression level
  gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!"
  
  echo.

  REM Prompt for confirmation to delete the original file
  echo Do you want to delete the original file?
  set /p delete_confirmation=Enter Y for Yes or N for No: 

  REM Logic to delete the original file based on user confirmation
  if /i "!delete_confirmation!"=="Y" if not "!delete_confirmation!"=="n" (
    echo Deleting original file.
    del "!input!"

  echo.
  )
)

echo.

REM Set the color to green for the specified line
cls
color 0A

timeout /t 1 >nul

echo.
echo Compression complete. All files have been compressed successfully.

timeout /t 1 >nul

echo.
echo Total files compressed: !filecount!
echo.

timeout /t 1 >nul

pause
color