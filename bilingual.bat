@echo off

REM Language selection
choice /c 12 /n /m "Choose your language (1 - English, 2 - Ukrainian): "
set "lang=%errorlevel%"

if "%lang%"=="2" (
    REM Set code page for Ukrainian
    chcp 65001 >nul
    cls
) else (
    REM Keep default code page for English
    chcp 437 >nul
    cls
)

@REM This script is a Windows batch process file written in the Batch command language. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) to compress PDF files using different compression levels

@echo off

@REM Enable delayed variable expansion. This allows obtaining updated variable values inside loops and code blocks
setlocal enabledelayedexpansion

REM Check for Ghostscript availability
where gswin64c.exe >nul 2>&1
if errorlevel 1 (
    cls
    color 0C

    echo ----------------------------------------------------------------
    echo.
    if "%lang%"=="2" (
        echo Ghostscript не встановлено.
        echo Будь ласка, завантажте та встановіть Ghostscript за посиланням:
    ) else (
        echo Ghostscript is not installed.
        echo Please download and install Ghostscript from the following link:
    )
    echo https://ghostscript.com/releases/gsdnld.html
    echo.
    echo ----------------------------------------------------------------

    timeout /t 2 >nul

    echo.
    pause
    color

    exit /b
)

REM Display current Ghostscript version
color 0A

echo -----------------------------
echo.
echo|set /p=Ghostscript: & gswin64c.exe --version
echo.
if "%lang%"=="2" (
    echo Все гаразд, давайте почнемо.
) else (
    echo It's okay, let's get started.
)
echo.
echo -----------------------------

REM Pause for 2 seconds and request input path
timeout /t 2 >nul

color 08

echo.
if "%lang%"=="2" (
    echo Введіть шлях до каталогу з файлами PDF:
) else (
    echo Enter the path to the directory with PDF files:
)
echo.
set /p directory=

echo.
echo -----------------------------
echo.

REM Adding compression level options

if "%lang%"=="2" (
    echo "1 - Низька якість (вивід на екран)"
    echo "2 - Середня якість (електронна книга)"
    echo "3 - Висока якість (принтер)"
    echo "4 - Надвисока якість (для друку)"
    echo.
) else (
    echo "1 - Low quality (screen)"
    echo "2 - Medium quality (ebook)"
    echo "3 - High quality (printer)"
    echo "4 - Ultra quality (prepress)"
    echo.
)

if "%lang%"=="2" (
    echo|set /p=Виберіть рівень стиснення: & choice /c 1234 /n /m " " & set "compresslevel=%errorlevel%"
) else (
    echo|set /p=Choose a compression level: & choice /c 1234 /n /m " " & set "compresslevel=%errorlevel%"
)

REM Get total count and size of PDF files in the directory and its subdirectories
set /A "filecount=0"
set /A "initialSize=0"
for /R "%directory%" %%F in (*.pdf) do (
  set /A "filecount+=1"
  for %%A in ("%%F") do set /A "initialSize+=%%~zA"
)

REM Reset progress counters
set /A "progress=0"
set /A "progress_compression=0"
set /A "progress_already_compressed=0"

REM Recursive loop to process PDF files in all subdirectories
for /R "%directory%" %%F in (*.pdf) do (
  set "input=%%F"
  set "output=%%~dpF%%~nF_compressed.pdf"
  
  REM Check if file has already been compressed based on the filename suffix
  echo %%~nF | find /i "_compressed" >nul

  if not errorlevel 1 (
    REM File is already compressed, skip compression and deletion
    echo ---
    if "%lang%"=="2" (
        echo Пропускаємо файл: %%F
        echo Стиснення не потрібне. Файл вже було стиснуто.
    ) else (
        echo Skipping file: %%F
        echo Compression not required. File has already been compressed.
    )

    REM Increment progress counter
    set /A "progress+=1"
    set /A "progress_already_compressed+=1"

    REM Calculate and display current progress percentage
    set /A "progress_percentage=(progress * 100) / filecount"
    if "%lang%"=="2" (
        echo Прогрес: !progress_percentage!%% / !filecount!
    ) else (
        echo Progress: !progress_percentage!%% / !filecount!
    )
  ) else (
    REM File requires compression
    echo ---
    if "%lang%"=="2" (
        echo Стискаємо файл: %%F
    ) else (
        echo Compressing file: %%F
    )

    REM Increment progress counter
    set /A "progress+=1"
    set /A "progress_compression+=1"
  
    REM Calculate and display current progress percentage
    set /A "progress_percentage=(progress * 100) / filecount"
    if "%lang%"=="2" (
        echo Прогрес: !progress_percentage!%% / !filecount!
    ) else (
        echo Progress: !progress_percentage!%% / !filecount!
    )
  
    REM Modified code to use Ghostscript with the selected compression level
    gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!"
  
    REM Check if compressed file was created successfully
    if exist "!output!" (
      REM Check compressed file size
      for %%A in ("!output!") do set /A "compressedSize=%%~zA"

      REM Check if compressed file size is less than 5 kilobytes
      if !compressedSize! LSS 5120 (
        if "%lang%"=="2" (
            echo Стиснення завершилося невдало. Розмір стиснутого файлу менше 5 кілобайт. Оригінальний файл не буде видалено.
        ) else (
            echo Compression failed. Compressed file size is less than 5 kilobytes. Original file will not be deleted.
        )
        del "!output!"
      ) else (
        if "%lang%"=="2" (
            echo Стиснення успішно завершено. Видалення оригінального файлу.
        ) else (
            echo Compression successful. Deleting original file.
        )
        del "!input!"
      )
    ) else (
      if "%lang%"=="2" (
          echo Стиснення не вдалося. Оригінальний файл не буде видалено.
      ) else (
          echo Compression failed. Original file will not be deleted.
      )
    )
  )
)

echo.

REM Get total size of compressed files
set /A "compressedSize=0"
for /R "%directory%" %%F in (*_compressed.pdf) do (
  for %%A in ("%%F") do set /A "compressedSize+=%%~zA"
)

REM Get size in megabytes
set /A "initialSizeMB=initialSize/1048576"
set /A "compressedSizeMB=compressedSize/1048576"

REM Round the values to two decimal places
set /A "initialSizeMB=((initialSizeMB*10) + 5) / 1000"
set /A "compressedSizeMB=((compressedSizeMB*10) + 5) / 1000"

REM Calculate size difference and compression ratio
set /A "sizeDifference=initialSizeMB-compressedSizeMB"
set /A "compressionRatio=((initialSizeMB-compressedSizeMB)*100)/initialSizeMB"

REM Set green color for specified row
cls
color 0A

echo ==================================================================
echo.
if "%lang%"=="2" (
    echo Стиснення завершено. Усі файли було успішно стиснуто.
) else (
    echo Compression complete. All files have been compressed successfully.
)
echo.
echo ==================================================================

timeout /t 1 >nul

echo.
if "%lang%"=="2" (
    echo Всього стиснуто файлів               : !progress!
) else (
    echo Total files compressed               : !progress!
)
echo.
if "%lang%"=="2" (
    echo Файли, стиснуті під час сеансу  : !progress_compression!
) else (
    echo Files compressed during the session  : !progress_compression!
)
echo.
if "%lang%"=="2" (
    echo Файли, які не потребують стиснення : !progress_already_compressed!
) else (
    echo Files that don't require compression : !progress_already_compressed!
)
echo.
echo ------------------------------------------------------------------

timeout /t 1 >nul

echo.
if "%lang%"=="2" (
    echo Початковий загальний розмір до            : %initialSizeMB%.%initialSize:~-2% MB
) else (
    echo Initial total size before            : %initialSizeMB%.%initialSize:~-2% MB
)
echo.
if "%lang%"=="2" (
    echo Стислий загальний розмір після          : %compressedSizeMB%.%compressedSize:~-2% MB
) else (
    echo Compressed total size after          : %compressedSizeMB%.%compressedSize:~-2% MB
)
echo.
if "%lang%"=="2" (
    echo Ступінь стиснення                    : %compressionRatio%%%
) else (
    echo Compression ratio                    : %compressionRatio%%%
)
echo.
echo ==================================================================

timeout /t 1 >nul

echo.
pause
color

