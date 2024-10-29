#SAcar Teleport confirms y poner url
#$rexp[0]=q|\<!-- #BeginStatic "top menu" --\>.+\<!-- #EndStatic "top menu" --\>|;
#$rexp[1]=q|\<!-- #BeginStatic "side menu" --\>.+\<!-- #EndStatic "side menu" --\>|;
$rexp[0]=q|\<!-- Auto Banner Insertion Begin --\>.+\<!-- Auto Banner Insertion Complete THANK YOU --\>|;
my @files=@ARGV;
if (-d $files[0]){
  chdir($files[0]);
  opendir(DIR,$files[0]) or die "el directorio no se pudo abrir";
  @files=readdir(DIR);
  closedir DIR;
  @files=grep {$_ !~/^\./} @files;
}else{
  print "Leyendo @files Ficheros";
}


foreach(@files){

  ReplacePanes($_);
}

sub ReplacePanes{
  $file=shift;
print "Reading ... ";
open (READ,"<$file") or die "cant open $file";
my @lines=<READ>;
close READ;

#print "\n$rexp_Teleport\n";
print " Replacing ... ";
my $todo_texto=join("",@lines);

foreach(@rexp){
$num=$todo_texto=~s/$_/<!-- Deleted -->/gsi;
print "\n$num Reemplazos\n";
}

print "Saving.\n";
rename($file,"$file\.bak");
open(SAVE,">$file") or die "canot open for save $file";
print SAVE $todo_texto;
close SAVE;
}
__END__
###########3

print $example=~s/$rexp_Teleport/$1/i;
print "\n";
print $example;
exit;

############3
###$Old_rexp_Teleport=q(href="javascript:if\(confirm\('[^']+Teleport Pro.+'\)\)window.location='.+'" tppabs="([^"]+)");
$example=q|<a class="menu" href="javascript:if(confirm('http://www.devguru.com/Technologies/ado/quickref/ado_intro.html  \n\nThis file was not retrieved by Teleport Pro, because it is addressed on a domain or path outside the boundaries set for its Starting Address.  \n\nDo you want to open it from the server?'))window.location='http://www.devguru.com/Technologies/ado/quickref/ado_intro.html'" tppabs="http://www.devguru.com/Technologies/ado/quickref/ado_intro.html" target="_self">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADO</a><br>|;
