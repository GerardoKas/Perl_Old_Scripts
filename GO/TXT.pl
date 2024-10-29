use fecha();
use forms();
if (%data=forms::form()){
$eldir=$data{'dir'}
}else{
$eldir="/";
}
#$eldir="/";
print <<HTML;
<title>Paginas Ð $eldir</title>
<body bgcolor=black text=yellow link=55ff00 vlink=55ff00 alink=red>
<basefont face="Arial">
HTML

print fecha::fecha();
#DIRECTORIO QUE LEE ..
&Mostrardir($eldir);

sub Mostrardir {
		my($dirx)=@_;
	   my ($dir,@files,@DIRS);
	   if ($dirx) {$dir=$dirx;}

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
  					if($file=~/(?:\.nfo|\.diz|\.txt|\.doc|\.inf|\.ini)$/i){
						if (!$titulado){
							print "<font color=red><h2>$dir</h2></font>\n";
							$titulado=1
						}
	               print "<li><font color=99ff00><a href='$cfile'>$file</a></font><br>\n";
	            }else{
	              # print "<li><a href='$cfile'>$file</a><br>\n";
	            }
	         }
			}
			$titulado=0;
	         foreach $undir(@DIRS){
	            &Mostrardir($undir);
	         }

	#print "</ul>";
	   }


	#  return 1;
}
#Hay un problema que es que se reescribe el array y se borran los anteriores. COCORRIGIENDO...usar my(@files);