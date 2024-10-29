
print <<HTML;
<body bgcolor=black text=yellow link=55ff00 vlink=55ff00 alink=red>
<basefont face="Arial">
HTML
#DIRECTORIO QUE LEE ..
&Mostrardir("..");
print "<hr size=20>\n";
sub Mostrardir {
	my($dirx)=@_;
   my ($dir,@files,@DIRS);
	if ($dirx) {$dir=$dirx;print "<font color=red><h2>$dirx</h2></font>\n"}
	@items=();
	if (!(-e $dir)) {
		print "NO EXISTE $dir";
	}else{
		opendir(ELDIR,$dir) or print "ERROR AL ABRIR $dir";
	   #print "<b>ARCHIVOS DE $dir</b><br>\n<ul>";
	   @files=readdir(ELDIR);
			#print @files;
	   foreach $file(@files){

			$cfile="$dir/$file";
			if (-d $cfile){
				if ($file!~/\.\.?/){
            push(@DIRS,$cfile);
					#print "<li><i><b>$file</b></i>\t\t-DIR<br>\n";
				}
         }else{
	         if($file=~/(?:\.pl|\.txt)$/i){
					push(@items,$file);
	            #print "<li><a href='$dir/$file'>$file</a><br>\n"
				}
			}
   	}
			@items=sort(@items);
			foreach $it(@items){
			    $tamano=(-s "$dir/$it");
				print "<li><a href='$dir/$it'>$it</a>,$tamano bytes<br>\n";
			}
			foreach $undir(@DIRS){
	         print "<DIR><ul>";
	         &Mostrardir($undir);
            print "</DIR></ul>";
			}

#print "</ul>";
	}


#	return 1;
}

#Hay un problema que es que se reescribe el array y se borran los anteriores. COCORRIGIENDO...usar my(@files);