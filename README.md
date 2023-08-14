## Batch PDF compressor

This Windows batch processing script provides an efficient way to compress PDF files using different compression levels and options. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) for performing the compression.

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/ee416d56-c254-4184-8f3a-3ec555ab56fe)

### Requirements

1. Installed [Ghostscript](https://www.ghostscript.com/).
2. Windows operating system.

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/b316d6b8-2e39-417f-915e-50e6ad23b127)

### Script Functionality

The script offers the following features:

1. Automatic selection of English, Ukrainian, or Russian according to the system language using universal UTF-8 (support for external message files has been added).
2. Selection the path to the directory with PDF files to be compressed using the windows.Forms.FolderBrowserDialog. With path validation and allowance for 3 false addresses or bounces.
3. Selection of compression level: low, medium, high, ultra.
4. Choose to delete or save original PDF files.
5. The script processes all PDF files within the specified directory and its subdirectories.
6. Displays progress of file processing and compression.
7. Upon completion, provides an overview of script execution, including the number of processed files, sizes before and after compression, and the compression ratio.
8. Additionally, the script checks the system for the presence of Ghostscript before execution and maintains a detailed log file for each compression operation.

### Usage

1. Install Ghostscript if not already installed.
2. **[Use an executable file](https://github.com/sergeiown/batch_PDF_compressor/releases)** *(best practice)* or run a script with a double click or via the command line *(If you are using a batch script, make sure that the text files with messages are available in the `/messages` directory and the modules are available in the `/modules` directory)*.
3. The required language will be selected automatically according to the system settings.
4. Select the directory containing the PDF files you want to compress. The script will "look" at the lower levels and process the PDFs in the subdirectories on its own.
5. Select the compression level (1-4) corresponding to the provided options.
6. Choose whether to delete or keep the original PDF files.
7. After completion, the log file will open, containing information about processed files and compression results.

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/c5716406-4982-49d7-be7f-facd45ae4d0a)

### License

This script is distributed under the MIT License. For more details, refer to the [LICENSE.md](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md) file.

---
