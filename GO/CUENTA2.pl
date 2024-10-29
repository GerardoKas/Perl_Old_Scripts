use cadenas();
use fecha();
use forms;
if (%data=forms::form()){
$eldir=$data{'dir'}
}else{
$eldir="/";
}
print "<title>NUMERO de PALABRAS DE $eldir</title><style>a{text-decoration:none;font-weight:900}</style>";
print cadenas::bodyoscuro();
print fecha::fecha();

#DIRECTORIO QUE LEE ..
&Mostrardir($eldir);
 #%lista=sort(%lista); #????????????
foreach $k(keys(%lista)){
	if ($lista{$k}>4){print "$k :: $lista{$k}<br>\n";}
}
$sin=$tothtm-$tottit;
print "<br>Total Archivos HTML: $tothtm<br>Total de Archivos con titulo: $tottit<br>Total sin Titulo:$sin";
sub Mostrardir {
		my($dir)=@_;
	   my (@files,@DIRS);

	   if (!(-e $dir)) {
	      print "¡¡¡NO EXISTE $dir!!!";
	   }else{

	      opendir(ELDIR,$dir) or print "ERROR AL ABRIR $dir";
	      #print "<b>ARCHIVOS DE $dir</b><br>\n<ul>";
	      @files=readdir(ELDIR);
			close ELDIR;
         if ($dir eq "/"){$dir=""}
			#print @files;
         foreach $file(@files){
				$cfile="$dir/$file";
	         if (-d $cfile){
				#print "$cfile<br>";
	            if ($file!~/\.\.?/){push(@DIRS,$cfile)}
	         }else{
  					if($file=~/(?:\.htm|\.html)$/i){
							@tienen=();
					$tothtm+=1;
					leerfile($cfile);

					}
	         }
			}
			$titulado=0;
	         foreach $undir(@DIRS){
	            &Mostrardir($undir);
	         }
	   }
}

sub leerfile{
	my($file)=@_;
		my @contienen;
	open (FILE,$file);
	@lines=<FILE>;
	close FILE;
	chop(@lines);
	$texto=join("",@lines);
	$texto=~s/<[^>]*>/ /;
	@words=split(/[^\w_0-9]+/,$texto);
	foreach $word(@words){
	      $lista{$word}+=1;
   }
	#	return @contienen;
}