use fecha();
use forms();
use Image::Size;
$tamano=200;
if (%data=forms::form()){
$eldir=$data{'dir'}
}else{
$eldir="e:";
}
$TOTAL=0;
print <<HTML;
<title>IMAGENES Ð $eldir</title>
<body bgcolor=white text=black link=55ff00 vlink=55ff00 alink=red>
<style>image{border:none}</style>
<basefont face="Arial">
<base href='$eldir'>
<!-<script>
<!-alert ("INTRODUZCA EL DISCO '' Y PULSE ACEPTAR")->
<!-</script>
HTML

print fecha::fecha();
#DIRECTORIO QUE LEE ..
&Mostrardir($eldir);
print "Total de Imagenes: $total<br>";

sub Mostrardir {
		my($dirx)=@_;
	   my ($dir,@files,@DIRS);
	   $dir=$dirx;
		print "<font color=red size=+1>$dir</font><br>\n";

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

  					if($file=~/(?:\.gif|\.jpg|\.bmp|\.wmf|\.emf|\.tif|\.ico)$/i){
						($w,$h)=imgsize($cfile);
	               print "<a href='$cfile'><img src='$cfile' width=$tamano alt='$file'>$w x $h</a>\n";
					$total+=1;
					 }else{
	              # print "<li><a href='$cfile'>$file</a><br>\n";
	            }
	         }
			}
	         foreach $undir(@DIRS){
	            print "<hr width=50% align=center>";
	            &Mostrardir($undir);
	            #print "";
	         }

	#print "</ul>";
	   }


	#  return 1;
}
#Hay un problema que es que se reescribe el array y se borran los anteriores. COCORRIGIENDO...usar my(@files);