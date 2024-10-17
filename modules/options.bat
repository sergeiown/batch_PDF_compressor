@REM [Copyright (c) 2023 - 2024 Serhii I. Myshko](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md)

@echo off

echo.
echo %short_separator%
echo.
echo 1 - %msg_6%
echo 2 - %msg_7%
echo 3 - %msg_8%
echo 4 - %msg_9%
echo.

choice /c 1234 /n /m "%msg_10%"
set "compresslevel=%errorlevel%"
if "%compresslevel%"=="1" set "pdfsettings=/screen" & echo %msg_6% >> %outputFile%
if "%compresslevel%"=="2" set "pdfsettings=/ebook" & echo %msg_7% >> %outputFile%
if "%compresslevel%"=="3" set "pdfsettings=/printer" & echo %msg_8% >> %outputFile%
if "%compresslevel%"=="4" set "pdfsettings=/prepress" & echo %msg_9% >> %outputFile%
echo. & echo. >> %outputFile%
timeout /t 1 >nul

echo %short_separator%
echo.
echo %msg_31%
echo.
choice /c 12 /n /m "(%msg_32%, %msg_33%) %msg_30%"
set "delete_originals=%errorlevel%"
if "%delete_originals%"=="1" echo %msg_31%: %msg_32% >> %outputFile%
if "%delete_originals%"=="2" echo %msg_31%: %msg_33% >> %outputFile%
timeout /t 1 >nul
echo.
echo %short_separator%
timeout /t 1 >nul
cls