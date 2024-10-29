use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';

my $dir=shift @ARGV;
my $minidir="miniaturas";
my $suposeMini="127";#pixeles de la miniatura suponemos

print "Listado de \"$dir\"";

opendir(DR,$dir) or die "NO EXISTE $dir";
@fs=readdir(DR);
closedir DR;

@fs=grep {/\.jpe?g$/i} @fs;
@fs=sort(@fs);
print "\n$#fs Archivos";
chdir($dir);

#Abrimos y nos ponemos a escribir
open(FL,">LasMinisFormatoEnPruebas.html") or die "ERROR EsCRITURA";

print "\nGUARDANDO\n";

print FL <<END;
<html>
<head>
<title> Taller de Arte Abracadabra </title>
<link rel="stylesheet" type="text/css" href="../estilo.css">
<style>
IMG{border:1 solid black;}
BODY{font-family:comic;font-size:14pt;color:darkmaroon;background-color:ffed77}
#.Imagen{text-align:center;vertical-align:width:100;height:100;middle;margin:10;border:0 groove maroon;}
.TSup{border:1 solid white;}
.TUna {border-width:1;border-color:lime;}
</style>
<script>
function abrir(lk,w,h){  
	w+=20
	h+=20
	window.open(lk,"","width="+w+",height="+h);
}
</script>

</head>
<body>

END
print $minidir;
$num=0;
print FL "<TABLE WIDTH=75% align=center class=TSup><tr><td>\n\n";
foreach(@fs){
	($w,$h)=imgsize($_);
	($mw,$mh)=imgsize("$minidir/$_");
	$fname=escapar($_);
	if ($num%4==0){
	print FL "\n\n</TABLE>\n<!-- HUECO -->\n<TABLE WIDTH=75% align=center class=TSup><tr><td>\n\n";
	}
  print FL "<table align=left width='".($suposeMini+32)."' height='".($suposeMini+60)."' class=TUna>\n";
  print FL "<tr><td valign=middle align=center><a href=\"$fname\">\n";
  print FL "<img src=\"$minidir/$fname\" width='$mw' height='$mh' align='middle'>\n";
  print FL "</a></td></tr><tr><td align=center>$_</td></tr>\n";
  print FL "</table></span>\n\n";
  $num+=1;
}
print FL "</table>";
print FL "<!-- Made By TallerAbracadabra2005 -->";
print FL "\n</body></html>";
close FL;

print "\n.. HECHO\n\n";

sub escapar(){
	uri_escape($_);#,"^A-Za-z");
}
