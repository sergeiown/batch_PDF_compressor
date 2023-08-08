@echo off

REM Вибір мови
set /p lang=Choose your language (1 - English, 2 - Ukrainian): 

if "%lang%"=="2" (
    REM Встановлюємо кодову сторінку для української
    chcp 65001 >nul
    cls
) else (
    REM Встановлюємо кодову сторінку для англійської
    chcp 1252 >nul
    cls
)

@REM This script is a Windows batch process file written in the Batch command language. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) to compress PDF files using different compression levels

@echo off

@REM Enable delayed variable expansion. This allows obtaining updated variable values inside loops and code blocks
setlocal enabledelayedexpansion

REM Перевірка наявності Ghostscript
where gswin64c.exe >nul 2>&1
if errorlevel 1 (
    cls
    color 0C

    echo ----------------------------------------------------------------
    echo.
    if "%lang%"=="2" (
        echo Ghostscript не встановлено.
        echo Будь ласка, завантажте та встановіть Ghostscript з наступного посилання:
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

REM Виведення поточної версії Ghostscript
color 0A

echo -----------------------------
echo.
echo Поточна версія Ghostscript:
gswin64c.exe --version
if "%lang%"=="2" (
    echo Все гаразд, давайте почнемо.
) else (
    echo It's okay, let's get started.
)
echo.
echo -----------------------------

REM Пауза на 2 секунди і запит на ввід шляху
timeout /t 2 >nul

color 08

echo.
if "%lang%"=="2" (
    echo Введіть шлях до теки з файлами PDF:
) else (
    echo Enter the path to the directory with PDF files:
)
echo.
set /p directory=

echo.

REM Додавання опцій рівня стиснення
if "%lang%"=="2" (
    echo Оберіть рівень стиснення:
    echo 1 - Низька якість (екран)
    echo 2 - Середня якість (книга)
    echo 3 - Висока якість (принтер)
    echo 4 - Вельми висока якість (підготовка до друку)
) else (
    echo Select compression level:
    echo 1 - Low quality (screen)
    echo 2 - Medium quality (ebook)
    echo 3 - High quality (printer)
    echo 4 - Ultra quality (prepress)
)
echo.
set /p compresslevel=

REM Додавання логіки вибору відповідного рівня стиснення
if "%compresslevel%"=="1" set "pdfsettings=/screen"
if "%compresslevel%"=="2" set "pdfsettings=/ebook"
if "%compresslevel%"=="3" set "pdfsettings=/printer"
if "%compresslevel%"=="4" set "pdfsettings=/prepress"

echo.

REM Отримання загальної кількості файлів PDF в теці та її підтеках
set /A "filecount=0"
set /A "initialSize=0"
for /R "%directory%" %%F in (*.pdf) do (
  set /A "filecount+=1"
  for %%A in ("%%F") do set /A "initialSize+=%%~zA"
)

REM Скидання лічильника прогресу
set /A "progress=0"
set /A "progress_compression=0"
set /A "progress_already_compressed=0"

REM Рекурсивний цикл для обробки файлів PDF у всіх підтеках
for /R "%directory%" %%F in (*.pdf) do (
  set "input=%%F"
  set "output=%%~dpF%%~nF_compressed.pdf"
  
  REM Перевірка, чи файл вже був стиснутий, перевіривши суфікс імені файлу
  echo %%~nF | find /i "_compressed" >nul

  if not errorlevel 1 (
    REM Файл вже стиснутий, пропустити стиснення та видалення
    echo ---
    if "%lang%"=="2" (
        echo Пропускаю файл: %%F
        echo Стиснення не потрібне. Файл вже був стиснутий.
    ) else (
        echo Skipping file: %%F
        echo Compression not required. File has already been compressed.
    )

    REM Інкремент лічильника прогресу
    set /A "progress+=1"
    set /A "progress_already_compressed+=1"

    echo Progress: !progress! / !filecount!
  ) else (
    REM Файл потребує стиснення
    echo ---
    if "%lang%"=="2" (
        echo Стискаю файл: %%F
    ) else (
        echo Compressing file: %%F
    )

    REM Інкремент лічильника прогресу
    set /A "progress+=1"
    set /A "progress_compression+=1"
  
    echo Progress: !progress! / !filecount!
  
    REM Змінений код для використання Ghostscript з вибраним рівнем стиснення
    gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!"
  
    REM Перевірка, чи стиснений файл створено успішно
    if exist "!output!" (
      REM Перевірка розміру стисненого файлу
      for %%A in ("!output!") do set /A "compressedSize=%%~zA"

      REM Перевірка, чи розмір стисненого файлу менший за 5 кілобайт
      if !compressedSize! LSS 5120 (
        if "%lang%"=="2" (
            echo Стиснення не вдалося. Розмір стисненого файлу менший за 5 кілобайт. Оригінальний файл не буде видалено.
        ) else (
            echo Compression failed. Compressed file size is less than 5 kilobytes. Original file will not be deleted.
        )
        del "!output!"
      ) else (
        if "%lang%"=="2" (
            echo Стиснення вдалося. Видаляю оригінальний файл.
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

REM Отримання загального розміру стиснених файлів
set /A "compressedSize=0"
for /R "%directory%" %%F in (*_compressed.pdf) do (
  for %%A in ("%%F") do set /A "compressedSize+=%%~zA"
)

REM Отримання розміру у мегабайтах
set /A "initialSizeMB=initialSize/10485"
set /A "compressedSizeMB=compressedSize/10485"

REM Округлення значення до другого десяткового розряду
set /A "initialSizeMB=((initialSizeMB*10) + 5) / 1000"
set /A "compressedSizeMB=((compressedSizeMB*10) + 5) / 1000"

REM Розмір файлу після стиснення та відсоток стиснення
set /A "sizeDifference=initialSizeMB-compressedSizeMB"
set /A "compressionRatio=((initialSizeMB-compressedSizeMB)*100)/initialSizeMB"

REM Встановлення зеленого кольору для вказаного рядка
cls
color 0A

echo ==================================================================
echo.
if "%lang%"=="2" (
    echo Стиснення завершено. Всі файли успішно стиснуті.
) else (
    echo Compression complete. All files have been compressed successfully.
)
echo.
echo ==================================================================

timeout /t 1 >nul

echo.
if "%lang%"=="2" (
    echo Загальна кількість стиснутих файлів       : !progress!
) else (
    echo Total files compressed               : !progress!
)
echo.
if "%lang%"=="2" (
    echo Файли, стиснуті під час сесії          : !progress_compression!
) else (
    echo Files compressed during the session  : !progress_compression!
)
echo.
if "%lang%"=="2" (
    echo Файли, які не вимагають стиснення     : !progress_already_compressed!
) else (
    echo Files that don't require compression : !progress_already_compressed!
)
echo.
echo ------------------------------------------------------------------

timeout /t 1 >nul

echo.
if "%lang%"=="2" (
    echo Початковий загальний розмір перед       : %initialSizeMB%.%initialSize:~-2% МБ
) else (
    echo Initial total size before            : %initialSizeMB%.%initialSize:~-2% MB
)
echo.
if "%lang%"=="2" (
    echo Загальний розмір після стиснення       : %compressedSizeMB%.%compressedSize:~-2% МБ
) else (
    echo Compressed total size after          : %compressedSizeMB%.%compressedSize:~-2% MB
)
echo.
if "%lang%"=="2" (
    echo Відсоток стиснення                    : %compressionRatio%%%
) else (
    echo Compression ratio                    : %compressionRatio%%%
)
echo.
echo ==================================================================

timeout /t 1 >nul

echo.
pause
color
