use File::Find;
#SAcar Teleport confirms y poner url
#$rexp[0]=q|\<!-- #BeginStatic "top menu" --\>.+\<!-- #EndStatic "top menu" --\>|;
#$rexp[1]=q|\<!-- #BeginStatic "side menu" --\>.+\<!-- #EndStatic "side menu" --\>|;
#$rexp[0]=q|\<XML\:.+\<\/xml\>|;
#$rexp[1]=q|\<\?IMPORT NAMESPACE="." IMPLEMENTATION=".+"\>|;
#$rexp[2]=q|\<\!--VENUS_START--\>.+\<\!--VENUS_END--\>|;
#$rexp[3]=q|\<script language=javascript\>.*?\<\/script\>|;
$rexp[0]=q|\<table align="left" border="0" cellpadding="2" cellspacing="2"\ssummary="Navigation buttons" width="20%"\>.+\<\/table\>|;
my @files=@ARGV;
#print $files[0];
if (-d $files[0]){
  print "Now: ";
    File::Find::find(\&ReplacePanes,$files[0]);
  print "Done;";
  }else{
  foreach(@files){ReplacePanes($_);}
}
sub ReplacePanes{
  $fichero=$_;
  print $_;
  return unless ($fichero=~/\.html?$/i);
  print "Reading ... ";
  open (READ,"<$fichero") or die "cant open $fichero";
  my @lines=<READ>;
  close READ;
  
  print "Replacing ... ";
  my $todo_texto=join("",@lines);
  
  foreach(@rexp){
    $num=$todo_texto=~s/$_/<!-- Deleted -->/gsi;
    print "$num";
  }
  
  print " - Saving.\n";
  rename($fichero,"$fichero\.bak");
  open(SAVE,">$fichero") or die "canot open for save $fichero";
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
