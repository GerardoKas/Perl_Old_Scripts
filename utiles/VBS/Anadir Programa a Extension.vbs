ext=inputbox("Que Extension?")
Set WshShell = WScript.CreateObject("WScript.Shell")
ext_name=WshShell.RegRead("HKCR\." & ext & "\")
ext_desc=WshShell.RegRead("HKCR\" & ext_name & "\")

prg_name=inputbox ("Nombre del comando?")
prg_path=inputbox ("Ruta de la aplicacion a ejecutar?")
WshShell.RegWrite "HKCR\" & ext_name & "\shell\" & prg_name & "\command\",prg_path & " ""%1"""
