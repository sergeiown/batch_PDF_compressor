@echo off
color 08
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

echo.

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

REM Get the total count of PDF files in the directory and its subdirectories
set /A "filecount=0"
for /R "%directory%" %%F in (*.pdf) do (
  set /A "filecount+=1"
)

REM Reset the progress counter
set /A "progress=0"

REM Recursive loop to process PDF files in all subdirectories
for /R "%directory%" %%F in (*.pdf) do (
  set "input=%%F"
  set "output=%%~dpF%%~nF_compressed.pdf"
  
  echo ---
  echo Compressing file: %%F

  REM Increment the progress counter
  set /A "progress+=1"
  
  echo Progress: !progress! / !filecount!
  
  REM Modified code to use Ghostscript with the selected compression level
  gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!"
  
  echo Deleting original file.
  del "!input!"
)

echo.

REM Set the color to green for the specified line
cls
color 0A

echo.
echo Compression complete. All files have been compressed successfully.
echo.
echo Total files compressed: !filecount!
echo.

pause
color
