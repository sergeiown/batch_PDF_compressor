@REM [Copyright (c) 2023 - 2025 Serhii I. Myshko](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md)

@echo off

set /A "filecount=0"
set /A "initialSize=0"
if not defined directory set "directory=%CD%"

for /R "%directory%" %%F in (*.pdf) do (
    set /A "filecount+=1"
    for %%A in ("%%F") do set /A "initialSize+=%%~zA"
)

set /A "progress=0"
set /A "progress_compression=0"
set /A "progress_already_compressed=0"
set /A "progress_error=0"

for /R "%directory%" %%F in (*.pdf) do (
    set "input=%%F"
    set "output=%%~dpF%%~nF_compressed.pdf"
    echo. & echo. >> %outputFile%
    echo %%~nF | find /i "_compressed" >nul
    
    if not errorlevel 1 (
        cls
        set /A "progress+=1"
        set /A "progress_already_compressed+=1"
        if defined filecount (
            set /A "progress_percentage=(progress * 100) / filecount"
        ) else (
            set "progress_percentage=0"
        )
        echo %msg_13% !progress_percentage!%% & echo %msg_13% !progress_percentage!%% >> %outputFile%
        echo %msg_11% %%F & echo %msg_11% %%F >> %outputFile%
        echo %msg_12% & echo %msg_12% >> %outputFile%
    ) else (
        cls
        set /A "progress+=1"
        if defined filecount (
            set /A "progress_percentage=(progress * 100) / filecount"
        ) else (
            set "progress_percentage=0"
        )
        echo %msg_13% !progress_percentage!%% & echo %msg_13% !progress_percentage!%% >> %outputFile%
        echo %msg_14% %%F & echo %msg_14% %%F >> %outputFile%

        if not defined gsExecutable (
            echo Error: Ghostscript executable not found & echo Error: Ghostscript executable not found >> %outputFile%
            set /A "progress_error+=1"
        ) else (
            "%gsExecutable%" -sDEVICE=pdfwrite -dPDFSETTINGS=!pdfsettings! -dNOPAUSE -dQUIET -dBATCH -sOutputFile="!output!" "!input!" >> %outputFile% 2>&1

            if %errorlevel% neq 0 (
                echo %msg_17% & echo %msg_17% >> %outputFile%
                set /A "progress_error+=1"
            ) else (
                if exist "!output!" (
                    for %%A in ("!output!") do set /A "compressedSize=%%~zA"
                    if defined compressedSize (
                        if !compressedSize! LSS 5120 (
                            echo %msg_15% & echo %msg_15% >> %outputFile%
                            set /A "progress_error+=1"
                            del "!output!"
                        ) else (
                            if "%delete_originals%"=="1" (
                                echo %msg_16% & echo %msg_16% >> %outputFile%
                                set /A "progress_compression+=1"
                                del "!input!"
                            ) else (
                                echo %msg_34% & echo %msg_34% >> %outputFile%
                                set /A "progress_compression+=1"
                            )
                        )
                    )
                ) else (
                    echo %msg_17% & echo %msg_17% >> %outputFile%
                    set /A "progress_error+=1"
                )
            )
        )
    )
)
echo. & echo. >> %outputFile%

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

if not defined initialSize set "initialSize=0"
if not defined compressedSize set "compressedSize=0"

set /A "initialSizeKB=(initialSize + 512) / 1024"
set /A "compressedSizeKB=(compressedSize + 512) / 1024"

if %initialSizeKB% gtr 0 (
    set /A "compressionRatio=((initialSizeKB-compressedSizeKB)*(-100))/initialSizeKB"
) else (
    set "compressionRatio=%msg_29%"
)
