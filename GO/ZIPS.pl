use fecha();
use cadenas();
use forms();
if (%data=forms::form()){
$eldir=$data{'dir'}
}else{
$eldir="/";
}
print "<title>ZIPS de la carpeta->$eldir</title>";
print cadenas::bodyoscuro();
print fecha::fecha();
#DIRECTORIO QUE LEE ..
&Mostrardir($eldir);
print "<hr>Archivos ZIP: $htm<br>Otros Archivos: $every<br>";
sub Mostrardir {
		my($dir)=@_;
	   my (@files,@DIRS);

		$titulado=0;
	   if (!(-e $dir)) {
	      print "NO EXISTE $dir";
	   }else{

	      opendir(ELDIR,$dir) or print "ERROR AL ABRIR $dir";
	      #print "<b>ARCHIVOS DE $dir</b><br>\n<ul>";
	      @files=readdir(ELDIR);
         if ($dir eq "/"){$dir=""}
         foreach $file(@files){
				$cfile="$dir/$file";
	         if (-d $cfile){
	            if ($file!~/\.\.?/){push(@DIRS,$cfile)}
	         }else{
  					if($file=~/(?:\.zip)$/i){
						if (!$titulado){print "<font color=red><h2>$dir</h2></font>\n";$titulado=1;$totdirs++}
						$htm+=1;
	               print "<li><a href='$cfile'><font color=ff3333>$file</font></a><br>\n";
	            }else{
						$every+=1;
	               #print "<li><a href='$cfile'>$file</a><br>\n";
	            }
	         }
			}

	         foreach $undir(@DIRS){
	            print "<DIR><ul>";
	            &Mostrardir($undir);
	            print "</DIR></ul>";
	         }

	#print "</ul>";
	   }


	#  return 1;
}
#Hay un problema que es que se reescribe el array y se borran los anteriores. COCORRIGIENDO...usar my(@files);