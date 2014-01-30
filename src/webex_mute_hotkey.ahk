;Allows for the script to be reloaded everytime it's saved
SetTimer,UPDATEDSCRIPT,1000

UPDATEDSCRIPT:
FileGetAttrib,attribs,%A_ScriptFullPath%
IfInString,attribs,A
{
FileSetAttrib,-A,%A_ScriptFullPath%
Sleep,500
Reload
}
Return 

#z::
  WinGetTitle ActiveWindowTitle, A
  WinActivate ahk_class WbxDockParent
  ControlClick WbxButtonEx1, ahk_class WbxDockParent
  WinActivate %ActiveWindowTitle%
return