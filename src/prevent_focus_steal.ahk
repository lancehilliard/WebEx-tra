#Persistent

; https://www.google.com/search?q=shell32.dll+icon+numbers
Menu, Tray, Icon, %windir%\system32\mmcndmgr.dll, 81 ; computerandapp


ProcessNameRegExMatch := "(atmgr.exe)"

SetTimer,CheckUpdatedScript,1000

WinGet, ProcessNameLast, ProcessName
WinGetActiveTitle, TitleLast

Loop {
	WinGet, ProcessName, ProcessName, A
	WinGetActiveTitle, Title

	GetKeyState, Clicking, LButton, P

	; Allow task switching to WebEx if:
	; - the user is clicking left mouse button (presumably to select WebEx, but some false positives will happen, sometimes)
	; - most recent window still exists and has a title
	; - most recent window is not minimized
	; - most recent window is not WebEx (yay edge cases! ...)
	If (Clicking = "U") and (ProcessNameLast != "") and (!(RegExMatch(ProcessNameLast, ProcessNameRegExMatch))) and (ProcessNameLast != ProcessName) and (RegExMatch(ProcessName, ProcessNameRegExMatch)) and (WinExist(TitleLast)) {
		WinGet, MinMaxStatusOfTitleLastWindow, MinMax, %TitleLast%
		If (MinMaxStatusOfTitleLastWindow <> -1) {
			TrayTip, Focus to %ProcessNameLast%..., ... after %ProcessName% stole it., 10, 1
			WinActivate, %TitleLast%
			Sleep 1500
			TrayTip
		}
	} else if (ProcessNameLast != ProcessName) {
		ProcessNameLast := ProcessName
		TitleLast := Title
	}
	Sleep 50
}

; auto-reload the script when edits are saved
CheckUpdatedScript:
	FileGetAttrib,attribs,%A_ScriptFullPath%
	IfInString,attribs,A
	{
		FileSetAttrib,-A,%A_ScriptFullPath%
		Sleep,500
		Reload
	}
Return 