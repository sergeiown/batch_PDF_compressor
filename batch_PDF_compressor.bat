@REM ========================================================================
@REM Batch PDF Compressor
@REM A Windows batch script for compressing PDF files using Ghostscript.
@REM [Ghostscript](https://www.ghostscript.com/)
@REM [Copyright (c) 2023 - 2024 Serhii I. Myshko](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md)
@REM ========================================================================

@echo off
title Batch PDF Compressor
color 1F

@REM ========================================================================
@REM Initialize log file and start time
@REM ========================================================================
set "outputFile=%USERPROFILE%\documents\batch_PDF_compressor.log"
call modules/date_time.bat

echo Start time: %day%.%month%.%year% %hour%:%minute%:%second% > %outputFile%
echo. >> %outputFile%
echo Log file path: %outputFile% >> %outputFile%
echo. >> %outputFile%

@REM ========================================================================
@REM Language Selection
@REM ========================================================================
call modules/language.bat

@REM Test script with manual language selection
@REM Uncomment the line below to enable manual language testing
@REM call tests/language_manual.bat

@REM ========================================================================
@REM Ghostscript Module - Check if Ghostscript is available | install
@REM ========================================================================
setlocal enabledelayedexpansion
call modules/ghostscript.bat
if "%exitScript%"=="1" (exit /b)

@REM ========================================================================
@REM Directory Setup
@REM ========================================================================
call modules/directory.bat
if "%exitScript%"=="1" (exit /b)

@REM ========================================================================
@REM Compression Options Setup
@REM ========================================================================
call modules/options.bat

@REM ========================================================================
@REM PDF Compression Execution
@REM ========================================================================
call modules/compression.bat

@REM ========================================================================
@REM Post-Processing Information Display
@REM ========================================================================
call modules/information.bat

@REM ========================================================================
@REM Log the finish time and copyright information
@REM ========================================================================
call modules/date_time.bat

echo. >> %outputFile%
echo Finish time: %day%.%month%.%year% %hour%:%minute%:%second% >> %outputFile%
echo. & echo. >> %outputFile%
echo Log file: %outputFile%
echo. & echo. >> %outputFile%
echo Copyright (c) 2024 Serhii I. Myshko
echo %copyright_link% >> %outputFile%
echo. & echo. >> %outputFile%

@REM ========================================================================
@REM End of script
@REM ========================================================================
pause
exit