use Win32::API;
$library="shell32.dll";
#formato de la estructura browseinfo
$browsepack="LLppLLLL";
$id=cargar();
print $id;

$browsearg=pack($browsepack,0,0,"","Elige el más bonito pá tí",0,0,0x21,0);


  $browseff = new Win32::API($library,"SHBrowseForFolder",["P"],"N");
  $getfromid=new Win32::API($library,"SHGetPathFromIDList",["N","P"],"N");                            
  $idlist = $browseff->Call($browsearg);
  if ($idlist){
   $buffer=0x0 x 80;
   $ok=$getfromid->Call($idlist,$buffer);
   $ndir=substr($buffer,0,index($buffer,0x0));
   
   print "BUFFER=$ndir\n\n";
   
   &guardar($idlist)
  }else{
      print "NO HAS ELEGIDO DIRECTORIO";
  }
sub cargar{
open(LEE,"<c:/temp/BROWSEFF.LOG") or return 0;
$pid=<LEE>;
close LEE;
return $pid;
}
sub guardar{
my($ruta)=@_;
open(SV,">c:/temp/BROWSEFF.LOG");
print SV $ruta;
close SV
}
__END__
1=Çexplorer
2=programas del menuinicio
3=panel control
4=impresoras
5=mIS DOCUMENTS
6=favoritos
7=carpeta inicio del menu inicio
8=Carpeta Recent
9=carpeta sendto
10=papelera de reciclaje
11=todo el menu inicio
12+=runtime eroor
Private Declare Function SHBrowseForFolder Lib "shell32.dll" (lpbi As BrowseInfo) As Long
//ESTO HAY QUE pack()earlo
Private Type BrowseInfo
    hWndOwner               As Long             ' hWnd del formulario
    pIDLRoot                As Long             ' Especifica el pID de la carpeta inicial
    pszDisplayName          As String           ' Nombre del item seleccionado
    lpszTitle               As String           ' Título a mostrar encima del árbol
    ulFlags                 As Long             '
    lpfnCallback            As Long             ' Función CallBack
    lParam                  As Long             ' Información extra a pasar a la función Callback
    iImage                  As Long             '
End Type
--------------------
Private Declare Function SHGetPathFromIDList Lib "shell32.dll" _
        (ByVal pidList As Long, ByVal lpBuffer As String) As Long
'
'// Browsing for directory.
Public Const BIF_RETURNONLYFSDIRS = &H1&       '// For finding a folder to start document searching
Public Const BIF_DONTGOBELOWDOMAIN = &H2&      '// For starting the Find Computer
Public Const BIF_STATUSTEXT = &H4&
Public Const BIF_RETURNFSANCESTORS = &H8&
Public Const BIF_EDITBOX = &H10&
Public Const BIF_VALIDATE = &H20&              '// insist on valid result (or CANCEL)
'
Public Const BIF_BROWSEFORCOMPUTER = &H1000&   '// Browsing for Computers.
Public Const BIF_BROWSEFORPRINTER = &H2000&    '// Browsing for Printers
Public Const BIF_BROWSEINCLUDEFILES = &H4000&  '// Browsing for Everything
'
'// message from browser
Public Const BFFM_INITIALIZED = 1
Public Const BFFM_SELCHANGED = 2
Public Const BFFM_VALIDATEFAILED = 3          '// lParam:szPath ret:1(cont),0(EndDialog)
'Public Const BFFM_VALIDATEFAILEDW = 4&         '// lParam:wzPath ret:1(cont),0(EndDialog)
'
'// messages to browser
Public Const BFFM_SETSTATUSTEXT = (WM_USER + 100)
Public Const BFFM_ENABLEOK = (WM_USER + 101)
Public Const BFFM_SETSELECTION = (WM_USER + 102)
'Public Const BFFM_SETSELECTIONW = (WM_USER + 103&)
'Public Const BFFM_SETSTATUSTEXTW = (WM_USER + 104&)
'
