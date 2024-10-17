#define MyAppName "Batch PDF Compressor"
#define MyAppVersion "1.5"
#define MyAppPublisher "Serhii I. Myshko"
#define MyAppURL "https://github.com/sergeiown/batch_PDF_compressor"
#define MyAppExeName "batch_PDF_compressor.bat"

[Setup]
AppId={{E714ADFC-E269-465D-9ED7-B54959018F8E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={userdocs}\batch_PDF_compressor
DefaultGroupName=Batch PDF compressor
AllowNoIcons=yes
LicenseFile=LICENSE.md
InfoAfterFile=infoafter.txt
OutputBaseFilename=batch_PDF_compressor_install
SetupIconFile=batch_PDF_compressor.ico
Compression=lzma
SolidCompression=yes
WizardStyle=classic
PrivilegesRequired=lowest

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "batch_PDF_compressor.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "batch_PDF_compressor.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "modules\compression.bat"; DestDir: "{app}\modules"; Flags: ignoreversion
Source: "modules\date_time.bat"; DestDir: "{app}\modules"; Flags: ignoreversion
Source: "modules\directory.bat"; DestDir: "{app}\modules"; Flags: ignoreversion
Source: "modules\ghostscript.bat"; DestDir: "{app}\modules"; Flags: ignoreversion
Source: "modules\information.bat"; DestDir: "{app}\modules"; Flags: ignoreversion
Source: "modules\installer.bat"; DestDir: "{app}\modules"; Flags: ignoreversion
Source: "modules\language.bat"; DestDir: "{app}\modules"; Flags: ignoreversion
Source: "modules\options.bat"; DestDir: "{app}\modules"; Flags: ignoreversion
Source: "messages\messages_english.txt"; DestDir: "{app}\messages"; Flags: ignoreversion
Source: "messages\messages_russian.txt"; DestDir: "{app}\messages"; Flags: ignoreversion
Source: "messages\messages_ukrainian.txt"; DestDir: "{app}\messages"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\batch_PDF_compressor.ico"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

Name: "{userstartmenu}\Batch PDF compressor\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\batch_PDF_compressor.ico"
Name: "{userstartmenu}\Batch PDF compressor\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\batch_PDF_compressor.ico"; Tasks: desktopicon

[Uninstall]
DisplayName={#MyAppName}
AppId={{E714ADFC-E269-465D-9ED7-B54959018F8E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
UninstallDisplayIcon={app}\batch_PDF_compressor.ico
UninstallString="{app}\{#MyAppExeName}" /uninstall
