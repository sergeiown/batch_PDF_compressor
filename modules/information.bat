@REM [Copyright (c) 2023 - 2025 Serhii I. Myshko](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md)

@echo off

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

echo. & echo. >> %outputFile%
echo %msg_22% %initialSizeKB%.%initialSizeKB:~-2% KB & echo %msg_22% %initialSizeKB%.%initialSizeKB:~-2% KB >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_24% %compressionRatio% %% & echo %msg_24% %compressionRatio% %% >> %outputFile%
echo. & echo. >> %outputFile%
echo %msg_23% %compressedSizeKB%.%compressedSizeKB:~-2% KB & echo %msg_23% %compressedSizeKB%.%compressedSizeKB:~-2% KB >> %outputFile%
echo. & echo. >> %outputFile%
echo %double_separator% & echo %double_separator% >> %outputFile%
timeout /t 1 >nul