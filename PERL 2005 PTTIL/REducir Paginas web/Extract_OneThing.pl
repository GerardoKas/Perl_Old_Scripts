#extrae el texto entre dos marcas
use File::Find;
#SAcar Teleport confirms y poner url

$rexx=q|\<\!-- BEGIN_CONTENT --\>(.+)\<\!-- END_CONTENT --\>|;

my @files=@ARGV;
#print $files[0];
$cadena=cargar();
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
  print "Reading ... $fichero";
  open (READ,"<$fichero") or die "cant open $fichero";
  my @lines=<READ>;
  close READ;
  
  print "Replacing:";
  my $todo_texto=join("",@lines);
  $todo_texto=~/$rexx/s;
  
  $todo_texto=$1;

  print "-Saving.\n";
  rename($fichero,"$fichero\.bak");
  open(SAVE,">$fichero") or die "canot open for save $fichero";
  print SAVE $cadena;
  print SAVE $todo_texto;
  print SAVE "</body></hmtl>";
  close SAVE;
}
sub cargar{
$cadena=<<END;
<HTML >
<HEAD>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252" />
    	<TITLE>Programming and Reusing the Browser (Internet Explorer - WebBrowser)</TITLE>
<META NAME="Description" CONTENT="This section includes documentation on programming and reusing the browser."/>
<META NAME="Robots" CONTENT="all"/>
<META NAME="Keywords" CONTENT="Programming and Reusing the Browser"/>
<META NAME="MS.LOCALE" CONTENT="en-us"/>
<LINK REL="stylesheet" TYPE="text/css" HREF="../../library/shared/comments/css/down.css" tppabs="http://msdn.microsoft.com/library/shared/comments/css/down.css" />


	<style>
	BODY
	{
		font-family:verdana,arial,helvetica;
		margin:0;
		background-color:white;
		
	}
	</style>
<LINK REL="stylesheet" TYPE="text/css" HREF="../css/ie4.css" tppabs="http://msdn.microsoft.com/workshop/css/ie4.css" />
<LINK REL="stylesheet" TYPE="text/css" HREF="../css/inetsdk.css" tppabs="http://msdn.microsoft.com/workshop/css/inetsdk.css" />
<LINK REL="stylesheet" TYPE="text/css" HREF="../css/glossary.css" tppabs="http://msdn.microsoft.com/workshop/css/glossary.css" />
<LINK REL="stylesheet" TYPE="text/css" HREF="../../library/shared/eyebrow/css/default.css" tppabs="http://msdn.microsoft.com/library/shared/eyebrow/css/default.css" />
<META name="pagetype" content="ovw">
<META name="devlang" content="">
<META name="src" content="/workshopx/browser/prog_browser_node_entry.xml">
<META name="pubpath" content="/workshop/browser/prog_browser_node_entry.asp">
<META name="ID" content="prog_browser_node_entry">
<META name="MS-HAID" content="prog_browser_node_entry">

</HEAD>
<BODY TOPMARGIN="0"  LEFTMARGIN="0" MARGINHEIGHT="0" MARGINWIDTH="0" BGCOLOR="#FFFFFF" TEXT="#000000">

END
return $cadena;
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
