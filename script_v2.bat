@echo off

REM Enable delayed variable expansion to allow obtaining updated variable values inside loops and code blocks
setlocal enabledelayedexpansion

REM Check if Ghostscript is installed
where gswin64c.exe >nul 2>&1
if errorlevel 1 (
    cls
    REM Set the color to red
    color 0C

    echo --------------------------------------------------------------------
    echo |                                                                  |
    echo | Ghostscript is not installed.                                    |
    echo | Please download and install Ghostscript from the following link: |
    echo | https://ghostscript.com/releases/gsdnld.html                     |
    echo |                                                                  |
    echo --------------------------------------------------------------------

    timeout /t 2 >nul

    echo.
    pause
    color

    exit /b
)

REM Set the color to green and display current Ghostscript version
color 0A

echo -----------------------------
echo 
echo Current Ghostscript version:
gswin64c.exe --version
echo It's okay, let's get started.
echo.
echo -----------------------------

timeout /t 2 >nul

REM Set the color to grey
color 08

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
set /A "initialSize=0"
for /R "%directory%" %%F in (*.pdf) do (
  set /A "filecount+=1"
  for %%A in ("%%F") do set /A "initialSize+=%%~zA"
)

REM Reset the progress counters
set /A "progress=0"
set /A "progress_compression=0"
set /A "progress_already_compressed=0"

REM Recursive loop to process PDF files in all subdirectories
for /R "%directory%" %%F in (*.pdf) do (
  set "input=%%F"
  set "output=%%~dpF%%~nF_compressed.pdf"
  
  REM Check if the file has already been compressed by checking the filename suffix
  echo %%~nF | find /i "_compressed" >nul

  if not errorlevel 1 (
    REM File has already been compressed, skip compression and deletion
    echo ---
    echo Skipping file: %%F
    echo Compression not required. File has already been compressed.

    REM Increment the progress counter
    set /A "progress+=1"
    set /A "progress_already_compressed+=1"

    echo Progress: !progress! / !filecount!
  ) else (
    REM File needs to be compressed
    echo ---
    echo Compressing file: %%F

    REM Increment the progress counter
    set /A "progress+=1"
    set /A "progress_compression+=1"
  
    echo Progress: !progress! / !filecount!
  
    REM Modified code to use Ghostscript with the selected compression level
    gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!"
  
    REM Check if the compressed file was created successfully
    if exist "!output!" (
      REM Check the size of the compressed file
      for %%A in ("!output!") do set /A "compressedSize=%%~zA"

      REM Check if the compressed file size is less than 5 kilobytes
      if !compressedSize! LSS 5120 (
        echo Compression failed. Compressed file size is less than 5 kilobytes. Original file will not be deleted.
        del "!output!"
      ) else (
        echo Compression successful. Deleting original file.
        del "!input!"
      )
    ) else (
      echo Compression failed. Original file will not be deleted.
    )
  )
)

echo.

REM Get the total size of the compressed files
set /A "compressedSize=0"
for /R "%directory%" %%F in (*_compressed.pdf) do (
  for %%A in ("%%F") do set /A "compressedSize+=%%~zA"
)

REM Get the size in megabytes
set /A "initialSizeMB=initialSize/10485"
set /A "compressedSizeMB=compressedSize/10485"

REM Round the value to the second decimal place
set /A "initialSizeMB=((initialSizeMB*10) + 5) / 1000"
set /A "compressedSizeMB=((compressedSizeMB*10) + 5) / 1000"

REM Get file size after compression and percentage compression
set /A "sizeDifference=initialSizeMB-compressedSizeMB"
set /A "compressionRatio=((initialSizeMB-compressedSizeMB)*100)/initialSizeMB"

cls
REM Set the color to green
color 0A

echo ==================================================================
echo.
echo Compression complete. All files have been compressed successfully.
echo.
echo ==================================================================

timeout /t 1 >nul

echo.
echo Total files compressed               : !progress!
echo.
echo Files compressed during the session  : !progress_compression!
echo.
echo Files that don't require compression : !progress_already_compressed!
echo.
echo ------------------------------------------------------------------

timeout /t 1 >nul

echo.
echo Initial total size before            : %initialSizeMB%.%initialSize:~-2% MB
echo.
echo Compressed total size after          : %compressedSizeMB%.%compressedSize:~-2% MB
echo.
echo Compression ratio                    : %compressionRatio%%%
echo.
echo ==================================================================

timeout /t 1 >nul

echo.
pause
color