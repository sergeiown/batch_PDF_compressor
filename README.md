# [PDF Compression Script](https://github.com/sergeiown/compress_PDF/blob/main/script_v2.bat)

![image](https://github.com/sergeiown/compress_PDF/assets/112722061/6b974831-2d20-450c-a939-598b478aac7d)

This script is a Windows batch process file written in the Batch command language. It utilizes the [Ghostscript utility](https://www.ghostscript.com/) to compress PDF files using different compression levels. If you prefer to use JavaScript, there is an alternative script available along with a win64 executable.

![image](https://github.com/sergeiown/compress_PDF/assets/112722061/5219e01b-a14d-44fe-b76a-9bdda2c562b5)

Additional information about the compression process and results is provided during and after the script runs.

![image](https://github.com/sergeiown/compress_PDF/assets/112722061/1a980c49-e8b6-47be-88b3-7d3551ecf2a2)

## Prerequisites

**Before running the script, ensure that you have the `Ghostscript utility` installed**

**Current stable version of the batch script is [script_v2.bat](https://github.com/sergeiown/compress_PDF/blob/main/script_v2.bat)**

## Usage

There are three different ways to use the PDF Compression Script, depending on your preference and the operating system you are using. Choose the appropriate method below:

### Using the Batch Script (`script.bat`)

If you want to use the original Windows batch script, follow these steps:

1. Clone the repository and navigate to the project directory.

2. Open a command prompt and navigate to the project directory.

3. Run the script by executing the following command: `script.bat`

4. Follow the on-screen instructions to compress your PDF files.

##

### Using the Batch Script for a very large number of pdf files (`script_v2.bat`)

This original Windows batch script is designed for compressing very large number of pdf files and has several improvements:

-   added a current file counter indicating the total number of files in the job;

-   added the ability to compress all pdf files in all subdirectories relative to the path specified by the user.

-   added checking the need for file compression.

-   added a check for creating a compressed file and checking its size: if it is less than 5 kilobytes, we assume that the file does not contain correct data and save the original file.

-   added additional information at the end of the script.

If you want to use this Windows command script, follow the same steps as for a regular script.bat

##

### Using the JavaScript (`script.js`)

If you prefer to use JavaScript, follow these steps:

1. Clone the repository and navigate to the project directory.

2. Install the required dependencies using the following command: `npm install`

3. Run the script by executing the following command: `node script.js`

4. Follow the on-screen instructions to compress your PDF files.

##

### Using the Windows Executable (`script-win.exe`)

If you prefer a standalone executable for Windows, follow these steps:

1. Clone the repository and navigate to the project directory.

2. Open a command prompt and navigate to the project directory.

3. Run the executable by executing the following command: `script-win.exe`

4. Follow the on-screen instructions to compress your PDF files.

**_Note: Make sure to have Ghostscript installed on your system and its executable added to the system's PATH environment variable before running any of the scripts._**

## Script Functionality

1. Check if [Ghostscript utility](https://www.ghostscript.com/) is installed and terminate the script execution if it is not (_Windows batch script only_).

2. Checking whether a file has been compressed using a script before and whether it needs to be compressed (_Windows batch script V2 only_).

3. The script displays the current version of Ghostscript.

4. The user is prompted to enter the path to the directory containing the PDF files.

5. The user is asked to select a compression level based on their desired quality for the compressed files.

6. The script searches for all PDF files in the specified directory.

7. Each file is compressed using Ghostscript with the selected compression level.

8. After compression, the user is prompted to confirm whether to delete the original file. (_except for the Windows V2 batch script_)

9. Once all files are processed, a message is displayed to indicate that the compression is complete.

## Notes

-   Make sure [Ghostscript](https://ghostscript.com/releases/gsdnld.html) is installed on your system and its executable is added to the system's PATH environment variable.

-   It is recommended to create a backup of your PDF files before running the compression script.

-   The JavaScript version of the script relies on the `child_process` and `readline` modules to provide a similar functionality as the original Windows batch script.

-   The script can be modified and customized according to your specific requirements.

-   For creating the Windows executable (`script-win.exe`), the `pkg@5.8.1` package was used.
