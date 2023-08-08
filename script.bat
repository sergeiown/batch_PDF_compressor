@REM This script is a Windows batch process file written in the Batch command language. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) to compress PDF files using different compression levels

@echo off
color 1F

@REM Determining the path to the log file
set "outputFile=%USERPROFILE%\documents\compression_log.txt"

REM Get the current date and time
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

REM Log the current date time and path to the log file before starting work
echo Start time: %year%%month%%day% %hour%:%minute%:%second% > %outputFile%
echo. >> %outputFile%
echo Log file path: %outputFile% >> %outputFile%
echo. >> %outputFile%

REM Language selection
choice /c 12 /n /m "Choose your language (1 - English, 2 - Ukrainian): "
set "lang=%errorlevel%"

if "%lang%"=="2" (
    REM Set universal UTF-8 code page for Ukrainian and English
    chcp 65001 >nul
    echo Обрана мова: українська >> %outputFile%
    echo. >> %outputFile%
    cls
) else (
    chcp 65001 >nul
    echo Selected language: English >> %outputFile%
    echo. >> %outputFile%
    cls
)

REM Define English and Ukrainian messages
if "%lang%"=="2" (
    set "msg_1=Ghostscript не встановлено."
    set "msg_2=Будь ласка, завантажте та встановіть Ghostscript за наступним посиланням:"
    set "msg_3=Поточна версія Ghostscript:"
    set "msg_4=Гаразд, давайте почнемо."
    set "msg_5=Введіть шлях до каталогу з файлами PDF:"
    set "msg_6=Низька якість (екран)"
    set "msg_7=Середня якість (електронна книга)"
    set "msg_8=Висока якість (принтер)"
    set "msg_9=Надвисока якість (до друку)"
    set "msg_10=Виберіть рівень стиснення:"
    set "msg_11=Пропуск файлу:"
    set "msg_12=Стиснення не потрібно. Файл вже було стиснуто."
    set "msg_13=Загальний прогрес:"
    set "msg_14=Триває стиснення файлу:"
    set "msg_15=Стиснення не вдалося. Розмір стисненого файлу менше 5 кілобайт. Оригінальний файл не буде видалено."
    set "msg_16=Успішне стиснення. Видалення оригінального файлу."
    set "msg_17=Стиснення не вдалося. Оригінальний файл не буде видалено."
    set "msg_18=Стиснення завершено. Всі файли було успішно стиснуто."
    set "msg_19=Усього стиснуто файлів             :"
    set "msg_20=Файли, стиснуті під час сеансу     :"
    set "msg_21=Файли, які не потребують стиснення :"
    set "msg_22=Початковий загальний розмір до     :"
    set "msg_23=Стиснений загальний розмір після   :"
    set "msg_24=Ступінь стиснення                  :"
    set "msg_25=Вказаний шлях не існує."
    set "error_separator=-------------------------------------------------------------------------"
    set "short_separator=---------------------------------------"
    set "long_separator=-----------------------------------------------------"
    set "double_separator======================================================"
) else (
    set "msg_1=Ghostscript is not installed."
    set "msg_2=Please download and install Ghostscript from the following link:"
    set "msg_3=Current Ghostscript version:"
    set "msg_4=It's okay, let's get started."
    set "msg_5=Enter the path to the directory with PDF files:"
    set "msg_6=Low quality (screen)"
    set "msg_7=Medium quality (ebook)"
    set "msg_8=High quality (printer)"
    set "msg_9=Ultra quality (prepress)"
    set "msg_10=Select compression level:"
    set "msg_11=Skipping file:"
    set "msg_12=Compression not required. File has already been compressed."
    set "msg_13=Total progress:"
    set "msg_14=Compressing file is in progress:"
    set "msg_15=Compression failed. Compressed file size is less than 5 kilobytes. Original file will not be deleted."
    set "msg_16=Compression successful. Deleting original file."
    set "msg_17=Compression failed. Original file will not be deleted."
    set "msg_18=Compression complete. All files have been compressed successfully."
    set "msg_19=Total files compressed               :"
    set "msg_20=Files compressed during the session  :"
    set "msg_21=Files that don't require compression :"
    set "msg_22=Initial total size before            :"
    set "msg_23=Compressed total size after          :"
    set "msg_24=Compression ratio                    :"
    set "msg_25=The provided path does not exist."
    set "error_separator=----------------------------------------------------------------"
    set "short_separator=-----------------------------------------------"
    set "long_separator=------------------------------------------------------------------"
    set "double_separator==================================================================="
)

@REM Enable delayed variable expansion. This allows obtaining updated variable values inside loops and code blocks
setlocal enabledelayedexpansion

REM Check if Ghostscript is installed
where gswin64c.exe >nul 2>&1
if errorlevel 1 (
    cls
    color 1C

    echo %error_separator% & echo %error_separator% >> %outputFile%
    echo. & echo. >> %outputFile%
    echo %msg_1% & echo %msg_1% >> %outputFile%
    echo %msg_2% & echo %msg_2% >> %outputFile%
    echo https://ghostscript.com/releases/gsdnld.html & echo https://ghostscript.com/releases/gsdnld.html >> %outputFile%
    echo. & echo. >> %outputFile%
    echo %error_separator% & echo %error_separator% >> %outputFile%

    timeout /t 2 >nul

    echo.
    pause
    color

    start notepad "%outputFile%"
    exit /b
)

REM Display current Ghostscript version
color 1A

echo %short_separator% & echo %short_separator% >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_3% & echo %msg_3% >> %outputFile%
gswin64c.exe --version & gswin64c.exe --version >> %outputFile%
echo %msg_4% & echo %msg_4% >> %outputFile%
echo. & echo. >> %outputFile%
echo %short_separator% & echo %short_separator% >> %outputFile%


REM Pause for 2 seconds and prompt for path input
timeout /t 2 >nul

color 1F


:input_path
echo. & echo. >> %outputFile%
echo %msg_5% & echo %msg_5% >> %outputFile%
echo. & echo. >> %outputFile%
set /p directory=
echo %directory% >> %outputFile%

REM Check if the directory exists
if not exist "%directory%" (
    echo %msg_25% & echo %msg_25% >> %outputFile%
    goto input_path
)

echo. & echo. >> %outputFile%
echo %short_separator% & echo %short_separator% >> %outputFile%
echo. & echo. >> %outputFile%

REM Add compression level options
echo 1 - %msg_6%
echo 2 - %msg_7%
echo 3 - %msg_8%
echo 4 - %msg_9%
echo. & echo. >> %outputFile%

choice /c 1234 /n /m "%msg_10%"
set "compresslevel=%errorlevel%"

REM Add logic to choose the corresponding compression level
if "%compresslevel%"=="1" set "pdfsettings=/screen" & echo Compression level: %msg_6% >> %outputFile%
if "%compresslevel%"=="2" set "pdfsettings=/ebook" & echo Compression level: %msg_7% >> %outputFile%
if "%compresslevel%"=="3" set "pdfsettings=/printer" & echo Compression level: %msg_8% >> %outputFile%
if "%compresslevel%"=="4" set "pdfsettings=/prepress" & echo Compression level: %msg_9% >> %outputFile%
echo. >> %outputFile%

timeout /t 2 >nul
cls

REM Get the total count of PDF files in the directory and its subdirectories
set /A "filecount=0"
set /A "initialSize=0"
for /R "%directory%" %%F in (*.pdf) do (
  set /A "filecount+=1"
  for %%A in ("%%F") do set /A "initialSize+=%%~zA"
)

REM Reset the progress counter
set /A "progress=0"
set /A "progress_compression=0"
set /A "progress_already_compressed=0"

REM Recursive loop to process PDF files in all subdirectories
for /R "%directory%" %%F in (*.pdf) do (
  set "input=%%F"
  set "output=%%~dpF%%~nF_compressed.pdf"
  
  REM Check if the file has already been compressed by checking the filename suffix
  echo. & echo. >> %outputFile%
  echo %%~nF | find /i "_compressed" >nul & echo %%~nF | find /i "_compressed" >nul >> %outputFile%

  if not errorlevel 1 (
    REM File has already been compressed, skip compression and deletion
    cls
    echo %msg_11% %%F & echo %msg_11% %%F >> %outputFile%
    echo %msg_12% & echo %msg_12% >> %outputFile%

    REM Increment the progress counter
    set /A "progress+=1"
    set /A "progress_already_compressed+=1"

    REM Calculate and display current progress percentage
    set /A "progress_percentage=(progress * 100 / filecount)"
    echo %msg_13% !progress_percentage!%% & echo %msg_13% !progress_percentage!%% >> %outputFile%
    ) else (
    REM File needs to be compressed
    cls
    echo %msg_14% %%F & echo %msg_14% %%F >> %outputFile%

    REM Increment the progress counter
    set /A "progress+=1"
    set /A "progress_compression+=1"
  
    REM Calculate and display current progress percentage
    set /A "progress_percentage=(progress * 100 / filecount)"
    echo %msg_13% !progress_percentage!%% & echo %msg_13% !progress_percentage!%% >> %outputFile%
      
    REM Modified code to use Ghostscript with the selected compression level
    gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!"
  
    REM Check if the compressed file was created successfully
    if exist "!output!" (
      REM Check the size of the compressed file
      for %%A in ("!output!") do set /A "compressedSize=%%~zA"

      REM Check if the compressed file size is less than 5 kilobytes
      if !compressedSize! LSS 5120 (
        echo %msg_15% & echo %msg_15% >> %outputFile%
        del "!output!"
      ) else (
        echo %msg_16% & echo %msg_16% >> %outputFile%
        del "!input!"
      )
    ) else (
      echo %msg_17% & echo %msg_17% >> %outputFile%
    )
  )
)

echo. & echo. >> %outputFile%

REM Get the total size of the compressed files
set /A "compressedSize=0"
for /R "%directory%" %%F in (*_compressed.pdf) do (
  for %%A in ("%%F") do set /A "compressedSize+=%%~zA"
)

REM get the size in megabytes
set /A "initialSizeMB=initialSize/10485"
set /A "compressedSizeMB=compressedSize/10485"

REM round the value to the second decimal place
set /A "initialSizeMB=((initialSizeMB*10) + 5) / 1000"
set /A "compressedSizeMB=((compressedSizeMB*10) + 5) / 1000"

REM file size after compression and percentage compression
set /A "sizeDifference=initialSizeMB-compressedSizeMB"
set /A "compressionRatio=((initialSizeMB-compressedSizeMB)*100)/initialSizeMB"

REM Set the color to green for the specified line
cls
color 1A

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
echo %long_separator% & echo %long_separator% >> %outputFile%

timeout /t 1 >nul

echo. & echo. >> %outputFile%
echo %msg_22% %initialSizeMB%.%initialSize:~-2% MB & echo %msg_22% %initialSizeMB%.%initialSize:~-2% MB >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_23% %compressedSizeMB%.%compressedSize:~-2% MB & echo %msg_23% %compressedSizeMB%.%compressedSize:~-2% MB >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_24% %compressionRatio%%% & echo %msg_24% %compressionRatio%%% >> %outputFile%
echo. & echo. >> %outputFile%
echo %double_separator% & echo %double_separator% >> %outputFile%

timeout /t 1 >nul

REM Get the current date and time
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

REM Log a message about the completion of the work along with the date and time of completion
echo. >> %outputFile%
echo Finish time: %year%%month%%day% %hour%:%minute%:%second% >> %outputFile%
echo. & echo. >> %outputFile%
pause
color
start notepad "%outputFile%"