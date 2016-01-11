#Persistent
ProcessNameRegExMatch := "(atmgr.exe)"

SetTimer,CheckUpdatedScript,1000

WinGet, ProcessNameLast, ProcessName
WinGetActiveTitle, TitleLast

Loop {
	WinGet, ProcessName, ProcessName, A
	WinGetActiveTitle, Title

	GetKeyState, Clicking, LButton, P

	If (Clicking = "U") and (ProcessNameLast != ProcessName) and (RegExMatch(ProcessName, ProcessNameRegExMatch)) and (ProcessNameLast ~= "") and (WinExist(TitleLast)) {
		TrayTip , Focus to %ProcessNameLast%..., ... after %ProcessName% stole it., 10, 1
		WinActivate, %TitleLast%
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