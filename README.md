# [Batch PDF compressor](https://github.com/sergeiown/batch_PDF_compressor/releases/tag/Final)

This Windows batch processing script provides an efficient way to compress PDF files using different compression levels and options. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) for performing the compression.

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/4023a1b7-5b51-4f55-91a6-7b34245f0af4)

## Requirements

1. Installed [Ghostscript](https://www.ghostscript.com/).
2. Windows operating system.*

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/ed8ea024-9edf-43b4-829b-925daa2c9071)

* - *Tested on windows 10 and windows 11 x64 systems. The scripts have not been tested on earlier versions.*

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

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/d01cc59a-68e3-40ae-acbd-68d9529d07ec)

### Usage

1. Install Ghostscript if not already installed.
2. **[Use an executable file](https://github.com/sergeiown/batch_PDF_compressor/releases)** _(best practice)_ or run a script with a double click or via the command line _(If you are using a batch script, make sure that the text files with messages are available in the `/messages` directory and the modules are available in the `/modules` directory)_.
3. The required language will be selected automatically according to the system settings.
4. Select the directory containing the PDF files you want to compress. The script will "look" at the lower levels and process the PDFs in the subdirectories on its own.
5. Select the compression level (1-4) corresponding to the provided options.
6. Choose whether to delete or keep the original PDF files.
7. After completion, the log file will open, containing information about processed files and compression results.

![image](https://github.com/sergeiown/batch_PDF_compressor/assets/112722061/8c874426-ffab-4d7e-8749-0e70e52fbdb2)

### License

This script is distributed under the MIT License. For more details, refer to the [LICENSE.md](https://github.com/sergeiown/compress_PDF/blob/main/LICENSE.md) file.

---
