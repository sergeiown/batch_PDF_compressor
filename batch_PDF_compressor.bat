@REM This script is a Windows batch process file written in the Batch command language. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) to compress PDF files using different compression levels and options
@REM MIT License https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md

@echo off
color 1F

@REM Determining the path to the log file
set "outputFile=%USERPROFILE%\documents\log.txt"

@REM Get the current date and time
for /f "tokens=1-4 delims= " %%a in ('date /t') do (
    set "month=%%a"
    set "day=%%b"
    set "year=%%c"
)
for /f "tokens=1-3 delims=:.," %%a in ("%time%") do (
    set "hour=%%a"
    set "minute=%%b"
    set "second=%%c"
)

@REM Log the current date time and path to the log file
echo Start time: %year%%month%%day% %hour%:%minute%:%second% > %outputFile%
echo. >> %outputFile%
echo Log file path: %outputFile% >> %outputFile%
echo. >> %outputFile%

@REM Language selection with universal UTF-8 code page for Ukrainian and English
choice /c 12 /n /m "Choose your language (1 - English, 2 - Ukrainian): "
set "lang=%errorlevel%"

if "%lang%"=="2" (
    chcp 65001 >nul
    echo Обрана мова: українська >> %outputFile%
    set "file_name=messages_ukrainian.txt"
    echo.
    cls
) else (
    chcp 65001 >nul
    echo Selected language: English >> %outputFile%
    set "file_name=messages_english.txt"
    echo.
    cls
)

@REM Enable delayed variable expansion. This allows obtaining updated variable values inside loops and code blocks
setlocal enabledelayedexpansion

@REM Using external txt files with messages
for /f "delims=" %%a in (%file_name%) do (
    set "%%a"
)

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

@REM Check if the directory exists for three times
if not exist "%directory%" (
    echo %msg_25% & echo %msg_25% >> %outputFile%
    if %attempt% lss %maxAttempts% (
        set /a "attempt+=1"
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
        exit /b
    )
)

@REM Add compression level options
echo.
echo %short_separator%
echo.
echo 1 - %msg_6%
echo 2 - %msg_7%
echo 3 - %msg_8%
echo 4 - %msg_9%
echo.

@REM Add logic to choose the corresponding compression level
choice /c 1234 /n /m "%msg_10%"
set "compresslevel=%errorlevel%"
if "%compresslevel%"=="1" set "pdfsettings=/screen" & echo %msg_6% >> %outputFile%
if "%compresslevel%"=="2" set "pdfsettings=/ebook" & echo %msg_7% >> %outputFile%
if "%compresslevel%"=="3" set "pdfsettings=/printer" & echo %msg_8% >> %outputFile%
if "%compresslevel%"=="4" set "pdfsettings=/prepress" & echo %msg_9% >> %outputFile%
echo. & echo. >> %outputFile%

@REM Add logic to choose whether to delete originals or not
choice /c 12 /n /m "%msg_30%"
set "delete_originals=%errorlevel%"
if "%delete_originals%"=="1" echo %msg_31% >> %outputFile%
if "%delete_originals%"=="2" echo %msg_32% >> %outputFile%
timeout /t 2 >nul
cls

@REM Get the total count of PDF files in the directory and its subdirectories
set /A "filecount=0"
set /A "initialSize=0"
for /R "%directory%" %%F in (*.pdf) do (
  set /A "filecount+=1"
  for %%A in ("%%F") do set /A "initialSize+=%%~zA"
)

@REM Reset the progress counter
set /A "progress=0"
set /A "progress_compression=0"
set /A "progress_already_compressed=0"
set /A "progress_error=0"

@REM Process PDF files in all subdirectories and check if the file has already been compressed by checking the filename suffix
for /R "%directory%" %%F in (*.pdf) do (
  set "input=%%F"
  set "output=%%~dpF%%~nF_compressed.pdf"
  echo. & echo. >> %outputFile%
  echo %%~nF | find /i "_compressed" >nul
  
  if not errorlevel 1 (
    @REM File has already been compressed, skip compression and deletion
    cls
    set /A "progress+=1"
    set /A "progress_already_compressed+=1"

    @REM Calculate and display current progress percentage
    set /A "progress_percentage=(progress * 100 / filecount)"
    echo %msg_13% !progress_percentage!%% & echo %msg_13% !progress_percentage!%% >> %outputFile%
    echo %msg_11% %%F & echo %msg_11% %%F >> %outputFile%
    echo %msg_12% & echo %msg_12% >> %outputFile%
    ) else (
    
    @REM File needs to be compressed
    cls
    set /A "progress+=1"
    @REM Calculate and display current progress percentage
    set /A "progress_percentage=(progress * 100 / filecount)"
    echo %msg_13% !progress_percentage!%% & echo %msg_13% !progress_percentage!%% >> %outputFile%
    echo %msg_14% %%F & echo %msg_14% %%F >> %outputFile%
    @REM Use Ghostscript with the selected compression level
    gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!" >> %outputFile%

    if %errorlevel% neq 0 (
      @REM Error during comression
      echo %msg_17% & echo %msg_17% >> %outputFile%
      set /A "progress_error+=1"
    ) else (
      @REM Output file successfully created
      if exist "!output!" (
      @REM Check if the compressed file size is less than 5 kilobytes
      for %%A in ("!output!") do set /A "compressedSize=%%~zA"
      if !compressedSize! LSS 5120 (
      echo %msg_15% & echo %msg_15% >> %outputFile%
      set /A "progress_error+=1"
      del "!output!"
      ) else (
          @REM Successfull compression
          if "%delete_originals%"=="1" (
          echo %msg_16% & echo %msg_16% >> %outputFile%
          set /A "progress_compression+=1"
          del "!input!"
          ) else (
            echo %msg_33% & echo %msg_33% >> %outputFile%
            set /A "progress_compression+=1"
          )
        )
      ) else (
        @REM Output file has not been created
        echo %msg_17% & echo %msg_17% >> %outputFile%
        set /A "progress_error+=1"
      )
    )
  )
)
echo. & echo. >> %outputFile%

@REM Check if the last 10 characters of the file contain "_compressed". If so, then the size of this file will be included in the calculation, regardless of the existence of a file pair. If not, check if there is a file pair named "filename_compressed.extension". If there is no file pair, the size of this file is also taken into account in the calculation.
set /A "compressedSize=0"

for /R "%directory%" %%F in (*.pdf) do (
  set "filename=%%~nF"
  set "extension=%%~xF"
  set "compressedPair=!filename!_compressed!extension!"
  
  if "!filename:~-10!"=="_compressed" (
    for %%A in ("%%F") do set /A "compressedSize+=%%~zA"
  ) else (
    if not exist "!directory!\!compressedPair!" (
      for %%A in ("%%F") do set /A "compressedSize+=%%~zA"
    )
  )
)

@REM Get the size in kilobytes
set /A "initialSizeKB=(initialSize + 512 ) / 1024"
set /A "compressedSizeKB=(compressedSize + 512) / 1024"

@REM Compression percentage calculation
if %initialSizeKB% gtr 0 (
    set /A "compressionRatio=((initialSizeKB-compressedSizeKB)*(-100))/initialSizeKB"
    ) else (
    set "compressionRatio=%msg_29%"
)

@REM Display and log a message block with information about the compression process
cls
color 1E
echo %double_separator% & echo %double_separator% >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_18% & echo %msg_18% >> %outputFile%
echo. & echo. >> %outputFile%
echo %double_separator% & echo %double_separator% >> %outputFile%
timeout /t 1 >nul

echo. & echo. >> %outputFile%
echo %msg_19% !progress! & echo %msg_19% !progress! >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_20% !progress_compression! & echo %msg_20% !progress_compression! >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_21% !progress_already_compressed! & echo %msg_21% !progress_already_compressed! >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_28% !progress_error! & echo %msg_28% !progress_error! >> %outputFile%
echo. & echo. >> %outputFile%
echo %long_separator% & echo %long_separator% >> %outputFile%
timeout /t 1 >nul

echo. & echo. >> %outputFile%
echo %msg_22% %initialSizeKB%.%initialSizeKB:~-2% KB & echo %msg_22% %initialSizeKB%.%initialSizeKB:~-2% KB >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_24% %compressionRatio% %% & echo %msg_24% %compressionRatio% %% >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_23% %compressedSizeKB%.%compressedSizeKB:~-2% KB & echo %msg_23% %compressedSizeKB%.%compressedSizeKB:~-2% KB >> %outputFile%
echo. & echo. >> %outputFile%
echo %double_separator% & echo %double_separator% >> %outputFile%
timeout /t 1 >nul

@REM Get the current date and time
for /f "tokens=1-4 delims= " %%a in ('date /t') do (
    set "month=%%a"
    set "day=%%b"
    set "year=%%c"
)
for /f "tokens=1-3 delims=:.," %%a in ("%time%") do (
    set "hour=%%a"
    set "minute=%%b"
    set "second=%%c"
)

@REM Log a message about the completion of the work with the date and time
echo. >> %outputFile%
echo Finish time: %year%%month%%day% %hour%:%minute%:%second% >> %outputFile%
echo. & echo. >> %outputFile%
echo Copyright (c) 2023 Serhii I. Myshko
echo %copyright_link% >> %outputFile%
echo. & echo. >> %outputFile%
pause
color
start notepad "%outputFile%"