ext=inputbox("Que CLSID?")

while ext <> ""
Set WshShell = WScript.CreateObject("WScript.Shell")
ext_name=WshShell.RegRead("HKCR\CLSID\" & ext & "\")
msgbox ext_name,,"Descripcion de la clave"
ext=inputbox("Que CLSID?")
wend