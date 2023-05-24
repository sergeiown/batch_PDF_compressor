const { execSync } = require('child_process');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

// Display current Ghostscript version
console.log('Current Ghostscript version:');
execSync('gswin64c.exe --version', { stdio: 'inherit' });

console.log();

rl.question('Enter the path to the directory with PDF files:\n', (directory) => {
    console.log();

    // Add compression level options
    console.log('Select compression level:');
    console.log('1 - Low quality (screen)');
    console.log('2 - Medium quality (ebook)');
    console.log('3 - High quality (printer)');
    console.log('4 - Ultra quality (prepress)');
    console.log();

    rl.question('Enter compression level: ', (compressLevel) => {
        console.log();

        let pdfSettings;
        switch (compressLevel) {
            case '1':
                pdfSettings = '/screen';
                break;
            case '2':
                pdfSettings = '/ebook';
                break;
            case '3':
                pdfSettings = '/printer';
                break;
            case '4':
                pdfSettings = '/prepress';
                break;
            default:
                console.log('Invalid compression level selected.');
                rl.close();
                return;
        }

        console.log();

        const compressFile = (input, output) => {
            console.log(`Compressing file: ${input}`);

            const command = `gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=${pdfSettings} -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${output}" "${input}"`;

            execSync(command, { stdio: 'inherit' });

            console.log();
        };

        const deleteOriginalFile = (input) => {
            rl.question('Do you want to delete the original file? (Y/N): ', (deleteConfirmation) => {
                console.log();

                if (deleteConfirmation.toLowerCase() === 'y') {
                    console.log(`Deleting original file: ${input}`);
                    require('fs').unlinkSync(input);
                    console.log();
                }

                processNextFile();
            });
        };

        let fileIndex = 0;
        const files = require('fs')
            .readdirSync(directory)
            .filter((file) => file.endsWith('.pdf'));

        const processNextFile = () => {
            if (fileIndex >= files.length) {
                rl.close();
                console.log('Compression complete. All files have been compressed successfully.');
                return;
            }

            const input = `${directory}/${files[fileIndex]}`;
            const output = `${directory}/${files[fileIndex].replace('.pdf', '_compressed.pdf')}`;

            compressFile(input, output);
            deleteOriginalFile(input);

            fileIndex++;
        };

        processNextFile();
    });
});
