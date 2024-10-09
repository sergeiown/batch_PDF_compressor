@REM This script is a Windows batch process file written in the Batch command language. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) to compress PDF files using different compression levels and options
@REM MIT License https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md

@echo off
title Batch PDF compressor
color 1F

set "outputFile=%USERPROFILE%\documents\batch_PDF_compressor_log.txt"

call modules/date_time.bat

echo Start time: %day%.%month%.%year% %hour%:%minute%:%second% > %outputFile%
echo. >> %outputFile%
echo Log file path: %outputFile% >> %outputFile%
echo. >> %outputFile%

call modules/language.bat

@REM Test script with manual language selection
@REM call tests/language_manual.bat

setlocal enabledelayedexpansion

call modules/ghostscript.bat
if "%exitScript%"=="1" (exit /b)

call modules/directory.bat
if "%exitScript%"=="1" (exit /b)

call modules/options.bat

call modules/compression.bat

call modules/information.bat

call modules/date_time.bat

echo. >> %outputFile%
echo Finish time: %day%.%month%.%year% %hour%:%minute%:%second% >> %outputFile%
echo. & echo. >> %outputFile%
echo Copyright (c) 2024 Serhii I. Myshko
echo %copyright_link% >> %outputFile%
echo. & echo. >> %outputFile%
pause