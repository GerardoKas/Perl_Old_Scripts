	Item=wscript.arguments(0)

 MsgBox "Empezamos.No toques nada"
  Set Shell = Wscript.CreateObject("Wscript.Shell") ' para RUN
  Set fs = Wscript.CreateObject("Scripting.FileSystemObject") 'para basename folder...
'   dim IE
   Set IE=Wscript.CreateObject("InternetExplorer.Application")
'   MsgBox "Seteando propiedades"
 IE.width = 900
 IE.height = 700
 IE.top=0
 IE.left=0
 IE.visible = 1 ' keep visible

	sCarpeta=fs.GetParentFolderName(Item)
	sNombre=fs.getBasename(Item)
	IE.navigate Item
	Do While (IE.Busy):loop
	wscript.echo(Item & Chr(10) & "Pulsa OK y espera" & chr(10) & IE.document.title)
  Shell.run "i_view32.exe /capture=1 /aspectratio /resample=(250,250) /convert=" & Chr(34) & sCarpeta & "\" & sNombre& ".jpg" & Chr(34),0,TRUE


msgbox "SE HA CREADO LA CAPTURA"
IE.quit
