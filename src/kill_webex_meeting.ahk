
; https://www.google.com/search?q=shell32.dll+icon+numbers
Menu, Tray, Icon, %windir%\system32\mmcndmgr.dll, 98 ; checkeredflag

SetTimer,UPDATEDSCRIPT,1000
SetTimer,TOGGLEWEBEXTOPDOCKVISIBILITY,1000

UPDATEDSCRIPT:
FileGetAttrib,attribs,%A_ScriptFullPath%
IfInString,attribs,A
{
FileSetAttrib,-A,%A_ScriptFullPath%
Sleep,500
Reload
}


;=============================
;KILL WEBEX
;=============================
^!+w::Process,Close,atmgr.exe

TOGGLEWEBEXTOPDOCKVISIBILITY:
CoordMode, Mouse, Screen
MouseGetPos, MouseX, MouseY
if (MouseX < 10) and (MouseY < 10)
{
    If ( mod(A_Sec, 2) == 0)
	WinHide, DlgFITMain ahk_class wcl_manager1
    Else 
        WinShow, DlgFITMain ahk_class wcl_manager1
    Return
}
Return