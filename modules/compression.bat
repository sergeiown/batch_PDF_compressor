@REM MIT License https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md

@echo off

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
    set /A "progress_percentage=(progress * 100 / filecount)"
    echo %msg_13% !progress_percentage!%% & echo %msg_13% !progress_percentage!%% >> %outputFile%
    echo %msg_11% %%F & echo %msg_11% %%F >> %outputFile%
    echo %msg_12% & echo %msg_12% >> %outputFile%
    ) else (
    
    @REM File needs to be compressed
    cls
    set /A "progress+=1"
    set /A "progress_percentage=(progress * 100 / filecount)"
    echo %msg_13% !progress_percentage!%% & echo %msg_13% !progress_percentage!%% >> %outputFile%
    echo %msg_14% %%F & echo %msg_14% %%F >> %outputFile%
    

    @REM Use Ghostscript with the selected compression level
    "%gsExecutable%" -sDEVICE=pdfwrite -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!" >> %outputFile% 2>&1

    if %errorlevel% neq 0 (
      @REM Error during comression
      echo %msg_17% & echo %msg_17% >> %outputFile%
      set /A "progress_error+=1"
    ) else (
      @REM Output file successfully created
      if exist "!output!" (
      @REM Check if the size of the compressed file does not exceed 5 kilobytes, so can track a password-protected file that cannot be compressed and this is not a typical error, but only a special case
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
            echo %msg_34% & echo %msg_34% >> %outputFile%
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