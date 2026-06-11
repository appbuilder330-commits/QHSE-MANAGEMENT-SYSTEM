!define APP_NAME "HSE Manager"
!define APP_VERSION "1.0.0"
OutFile "HSE-Manager-Setup.exe"
InstallDir "$PROGRAMFILES64\HSE Manager"
RequestExecutionLevel admin
SetCompressor lzma

!include "MUI2.nsh"
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Section "Install"
  SetOutPath "$INSTDIR"
  File "..\index.html"
  FileOpen $0 "$INSTDIR\HSEManager.vbs" w
  FileWrite $0 'Set objShell = CreateObject("WScript.Shell")$\r$\n'
  FileWrite $0 'objShell.Run "cmd /c start """" ""$INSTDIR\index.html""", 0, False$\r$\n'
  FileClose $0
  CreateShortCut "$DESKTOP\HSE Manager.lnk" "wscript.exe" '"$INSTDIR\HSEManager.vbs"'
  CreateDirectory "$SMPROGRAMS\HSE Manager"
  CreateShortCut "$SMPROGRAMS\HSE Manager\HSE Manager.lnk" "wscript.exe" '"$INSTDIR\HSEManager.vbs"'
  WriteUninstaller "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HSEManager" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HSEManager" "UninstallString" "$INSTDIR\uninstall.exe"
  MessageBox MB_OK "HSE Manager installed! Shortcut added to Desktop."
SectionEnd

Section "Uninstall"
  Delete "$DESKTOP\HSE Manager.lnk"
  Delete "$INSTDIR\index.html"
  Delete "$INSTDIR\HSEManager.vbs"
  Delete "$INSTDIR\uninstall.exe"
  RMDir "$INSTDIR"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HSEManager"
SectionEnd