@REM This script is a Windows batch process file written in the Batch command language. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) to compress PDF files using different compression levels and options
@REM MIT License https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md

@echo off
color 1F

@REM Determining the path to the log file
set "outputFile=%USERPROFILE%\documents\batch_PDF_compressor_log.txt"

@REM Get the current date and time
call modules/date_time.bat

@REM Log the current date time and path to the log file
echo Start time: %year%%month%%day% %hour%:%minute%:%second% > %outputFile%
echo. >> %outputFile%
echo Log file path: %outputFile% >> %outputFile%
echo. >> %outputFile%

@REM Automatic language selection
call modules/language.bat

@REM Test script with manual language selection
@REM call tests/language_manual.bat

@REM Enable delayed variable expansion. This allows obtaining updated variable values inside loops and code blocks
setlocal enabledelayedexpansion

@REM Check if Ghostscript is installed and display current Ghostscript version
call modules/ghostscript.bat
if "%exitScript%"=="1" (exit /b)

@REM Select a directory using the FolderBrowserDialog
call modules/directory.bat
if "%exitScript%"=="1" (exit /b)

@REM Select compression options
call modules/options.bat

@REM Compress all PDF files in the selected directory and subdirectories
call modules/compression.bat

@REM Display and log a message block with information about the compression process
call modules/information.bat

@REM Get the current date and time
call modules/date_time.bat

@REM Log a message about the completion of the work with the date and time
echo. >> %outputFile%
echo Finish time: %year%%month%%day% %hour%:%minute%:%second% >> %outputFile%
echo. & echo. >> %outputFile%
echo Copyright (c) 2023 Serhii I. Myshko
echo %copyright_link% >> %outputFile%
echo. & echo. >> %outputFile%
pause