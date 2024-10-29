
$eldir="/";
#$busca='while';
#intento de buscar expresiones regulares ($item=~m|~/([^/]+)/|) pero no va
print <<HTML;
<title>BUSCANDO EN $eldir</title>
<body bgcolor=black text=yellow link=55ff00 vlink=55ff00 alink=red>
<basefont face="Arial">
HTML

#print fecha::fecha();
#DIRECTORIO QUE LEE ..
&Mostrardir($eldir);

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
  					if($file=~/(?:\.htm|\.html|\.txt|\.doc|\.asp|\.xp)$/i){
							@tienen=();
                  if (@tienen=leerfile($cfile)){
                     #print @tienen;
                     if (!$titulado){print "<font color=red><h2>$dir</h2></font>\n";$titulado=1}
                     print "<font color=99ff00><a href='$cfile'>$file</a></font><br>\n";
                     print "<ol>";
                     foreach $it(@tienen){
                        print "<li><i>$it</i>\n";
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
	foreach $item(@lines){
		if ($item=~/href=[\"\']*([^\"\']+)[\"\']*[^>]*>([^<]*)<\/a>/i){
			#$item=~s/[.]*<title>([^<]*)<\/title>[.]*/$1/i ;
			$ret="<a href='$1'>$2</a>";
			push(@contienen,$ret);
 		}
  }
	return @contienen;
}