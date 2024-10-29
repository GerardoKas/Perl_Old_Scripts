package getfolder2;
use Exporter;

@EXPORT=qw(getafolder getfolder);
@ISA=qw(Exporter);
sub getafolder{
   my @dirs=();
   while($d=shift @ARGV){
      print "Leyendo Parametros\n";
   if(-d $d){
      push @dirs,$d;   
   }
   }
   if ($#dirs<1) {
      print "Elige un directorio en el Menu\n";
      $dir=&getfolder("Elige un directorio");
      push @dirs ,$dir;
   }
   return @dirs;
}



sub getfolder{
   my($titulo)=shift;
   $titulo="Elige el directorio más bonito" unless $titulo;
   $ndir="";
   use Win32::API;
   $library="shell32.dll";
#formato de la estructura browseinfo
   $browsepack="LLppLLLL";
#compilar argumentos
   $browsearg=pack($browsepack,0,0,"",$titulo,0,0,0x21,0);
#Creacion :rutina de bff
  $browseff = new Win32::API($library,"SHBrowseForFolder",["P"],"N");
#Creacion :rutina a convertir id en string
  $getfromid=new Win32::API($library,"SHGetPathFromIDList",["N","P"],"N");                            
#Llamada bff
  $idlist = $browseff->Call($browsearg);
  if ($idlist){
   #buffer de nulos 
      $buffer="?" x 512;#lo llenamos de comillas, podriamos usar ? * etc
   #Llamada a getpathfromid
      $ok=$getfromid->Call($idlist,$buffer);
   #Cortar el path sin los nulos
      $ndir=substr($buffer,0,index($buffer,"?")-1);
   #Imprimir path  
      print "BUFFER=$ndir\n\n";
      #system("pause");
  }else{
      print "NO HAS ELEGIDO DIRECTORIO\n";
  }
   return $ndir;
}


1;