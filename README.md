## Batch PDF compressor

This Windows batch processing script provides an efficient way to compress PDF files using different compression levels and options. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) for performing the compression.

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/ee416d56-c254-4184-8f3a-3ec555ab56fe)

### Requirements

1. Installed [Ghostscript](https://www.ghostscript.com/).
2. Windows operating system.

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/b316d6b8-2e39-417f-915e-50e6ad23b127)

### Script Functionality

The script offers the following features:

1. Language selection (English or Ukrainian).
2. Selection the path to the directory with PDF files to be compressed using the windows.Forms.FolderBrowserDialog. With path validation and allowance for 3 false addresses or bounces.
3. Selection of compression level: low, medium, high, ultra.
4. The script processes all PDF files within the specified directory and its subdirectories.
5. Displays progress of file processing and compression.
6. Upon completion, provides an overview of script execution, including the number of processed files, sizes before and after compression, and the compression ratio.
7. Additionally, the script checks the system for the presence of Ghostscript before execution and maintains a detailed log file for each compression operation.

### Usage

1. Install Ghostscript if not already installed.
2. Run the script by double-clicking it or through the command line.
3. Choose your desired language (1 - English, 2 - Ukrainian).
4. Select the directory containing the PDF files you want to compress. The script will "look" at the lower levels and process the PDFs in the subdirectories on its own.
5. Select the compression level (1-4) corresponding to the provided options.
6. After completion, the log file will open, containing information about processed files and compression results.

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/c5716406-4982-49d7-be7f-facd45ae4d0a)

### License

This script is distributed under the MIT License. For more details, refer to the [LICENSE.md](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md) file.

---
