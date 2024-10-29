use fecha;
use cadenas;
print "<title>TITULO</title>";
print cadenas::bodyoscuro();
print fecha::fecha();

#QUE LEE ..
&Mostrardir("c:");
print "Total Directorios: $totdirs<br>Total Items: $totitems<br>";

###########################################
sub Mostrardir {
	my($dir)=@_;
   my(@files,@DIRS);
	$titulado=0;
	@items=();
	if (!(-e $dir)) {
		print "NO EXISTE $dir";
	}else{
	      opendir(ELDIR,$dir) or print "ERROR AL ABRIR $dir";
	      @files=readdir(ELDIR);
	         #print @files;
	      foreach $file(@files){
	            $cfile="$dir/$file";
	            if (-d $cfile){
	               if ($file!~/\.\.?/){
	                  push(@DIRS,$cfile);
	                  $totdirs++;
	               }
	            }else{
	               if($file=~/(?:\.htm|\.txt)$/i){
	                  $totitems++;
	                  if (!$titulado){print "<font color=red><h2>$dir</h2></font>\n";$titulado=1;}
	                  push(@items,$file);
	               }
	            }
			#fin foreach
	      }
	         @items=sort(@items);
	         foreach $it(@items){
	            print "<li><a href='$dir/$it'>$it</a><br>\n";
	         }
	         foreach $undir(@DIRS){
	            print "<DIR><ul>";
	            &Mostrardir($undir);
	            print "</DIR></ul>";
	         }
	#fin primer if
	}
}