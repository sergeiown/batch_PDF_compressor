## Batch PDF compressor

This Windows batch processing script provides an efficient way to compress PDF files using different compression levels and options. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) for performing the compression.

### Requirements

1. Installed [Ghostscript](https://www.ghostscript.com/).
2. Windows operating system.

### Script Functionality

The script offers the following features:

1. Language selection (English or Ukrainian).
2. Input of the directory path containing PDF files to be compressed.
3. Selection of compression level: low, medium, high, ultra.
4. The script processes all PDF files within the specified directory and its subdirectories.
5. Displays progress of file processing and compression.
6. Upon completion, provides an overview of script execution, including the number of processed files, sizes before and after compression, and the compression ratio.
7. Additionally, the script checks the system for the presence of Ghostscript before execution and maintains a detailed log for each compression operation.

### Usage

1. Install Ghostscript if not already installed.
2. Run the script by double-clicking it or through the command line.
3. Choose your desired language (1 - English, 2 - Ukrainian).
4. Enter the path to the directory containing the PDF files to be compressed.
5. Select the compression level (1-4) corresponding to the provided options.
6. After completion, the log file will open, containing information about processed files and compression results.

### License

This script is distributed under the MIT License. For more details, refer to the [LICENSE.md](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md) file.

---
