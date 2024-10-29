use cadenas();
use fecha();
$cadena="algoritmo";
$eldir="/";
#$busca='while';
#intento de buscar expresiones regulares ($item=~m|~/([^/]+)/|) pero no va
print "<title>BUSCANDO '$cadena' EN $eldir</title>";
print cadenas::bodyoscuro();
print fecha::fecha();
print "<h2>Busqueda: '$cadena'</h2>";
#DIRECTORIO QUE LEE ..
&Mostrardir($eldir);
print "<br>Total directorios: $totdirs<br>Total archivos hypertexto: $tothtm<br>Total contienen:$tottienen<br>";
sub Mostrardir {
		my($dir)=@_;
	   my (@files,@DIRS);
$totdirs+=1;
	   if (!(-e $dir)) {
	      print "°°°NO EXISTE $dir!!!";
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
  					if($file=~/(?:\.htm|\.html|\.txt|\.doc|\.asp|\.xp)$/i){
					$tothtm+=1;
					 #print "$cfile<br>";
					 		@tienen=();
                  if (@tienen=leerfile($cfile)){
                     #print @tienen;
							$tottienen+=1;
                     if (!$titulado){print "<font color=red><h2>$dir</h2></font>\n";$titulado=1}
                     print "<font color=99ff00><a href='$cfile'>$file</a></font><br>\n";
                     print "<ol>";
                     foreach $it(@tienen){
								($linea,$numlinea)=split("–",$it);
                        print "<li value=$numlinea><i>$linea</i>\n";
                     }
                     print "</ol>\n";
						}

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
	#$texto=join("",@lines);
	for ($i=0;$i<$#lines;$i++){
		$item=$lines[$i];
		if ($item=~/$cadena/i){
			#$item=~s/[.]*<title>([^<]*)<\/title>[.]*/$1/i;
			#$item=~s/<meta (?=name|http-equiv)=[^\"\']+
			$item=~s/($cadena)/<font color=red><b>$1<\/b><\/font>/ig;
			push(@contienen,"$item–$i");
 		}
  }
	return @contienen;
}