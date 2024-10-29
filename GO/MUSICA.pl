push (@INC,".");
use fecha();
use forms();
$tamano=150;
if (%data=forms::form()){
$eldir=$data{'dir'}
}else{
$eldir="e:";
}
$TOTAL=0;
print <<HTML;
<title>IMAGENES Ð $eldir</title>
<body bgcolor=black text=white link=00cc55 vlink=00cc55 alink=red>
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
print "Total de Musica: $total<br>";

sub Mostrardir {
		my($dirx)=@_;
	   my ($dir,@files,@DIRS);
	   $dir=$dirx;
	$impreso=0;

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

  					if($file=~/(?:\.wav|\.mp3|\.au|\.rm|\.mid)$/i){
					if (!$impreso){print "<hr width=50% align=center>";print "<font color=red size=+1>$dir</font><br>\n";$impreso=1}
	               print "<a href='$cfile'>$file</a><br>\n";
					$total+=1;
					 }else{
	              # print "<li><a href='$cfile'>$file</a><br>\n";
	            }
	         }
			}

	         foreach $undir(@DIRS){
					$impreso=0
	            &Mostrardir($undir);
	            #print "";
	         }

	#print "</ul>";
	   }


	#  return 1;
}
#Hay un problema que es que se reescribe el array y se borran los anteriores. COCORRIGIENDO...usar my(@files);