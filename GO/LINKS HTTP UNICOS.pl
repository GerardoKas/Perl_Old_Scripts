use fecha();
use forms();
if (%data=forms::form()){
$eldir=$data{'dir'}
}else{
$eldir="e:";
}
#$busca='while';
#intento de buscar expresiones regulares ($item=~m|~/([^/]+)/|) pero no va
print <<HTML;
<title>LINKS EXTERNOS EN $eldir</title>
<body bgcolor=black text=yellow link=55ff00 vlink=55ff00 alink=red>
<basefont face="Arial">
HTML

#print fecha::fecha();
#DIRECTORIO QUE LEE ..
&Mostrardir($eldir);
$resto=$tothtm-$tiene;
if ($x==1){
	print "<font size=-2><ol>";
	foreach $it(@notiene){
	$pos=rindex($it,"/");
	$udir=substr($it,0,$pos+1);
	$unom=substr($it,$pos+1);
	print "<a href='$it'>$udir<font color=red>$unom</font></a><br>\n";
	}
	print "</ol></font>";
}
print "<br>Paginas HTML: $tothtm<br>Paginas con links externos:$tiene<br>Paginas sin links externos:$resto<br>\n";

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
							$tothtm+=1;
                  if (@tienen=leerfile($cfile)){
                     #print @tienen;
							$tiene+=1;
                     if (!$titulado){print "<font color=red><h2>$dir</h2></font>\n";$titulado=1}
                     print "<font color=99ff00 size=+1><b><a href=\"$cfile\">$file</a></b></font><br>\n";
                     print "<ol>\n";
                     foreach $it(@tienen){
                        print "<li><i>$it</i>\n";
                     }
                     print "</ol>\n\n\n";
						}else{
							push(@notiene,$cfile);
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
		if ($item=~/href=[\"\']?http:\/\/([^\"\']+)[\"\']?[^>]*>([^<]*)<\/a>/i){
			#$item=~s/[.]*<title>([^<]*)<\/title>[.]*/$1/i ;
			$ret="<a href='http://$1'>$2</a>";
			push(@contienen,$ret);
 		}
  }
	return @contienen;
}