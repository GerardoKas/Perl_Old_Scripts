#!perl.exe -w
use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';

$dir=shift @ARGV;
$minidir="miniaturas";
print "Listado de \"$dir\"";
#$dir='E:\Abracadabra\Taller abracadabra\En Clase Lunes 13-10-2003\miniaturas';
opendir(DR,$dir) or die "NO EXISTE $dir";
@fs=readdir(DR);
closedir DR;
@fs=sort(@fs);
@fs=grep {!/^\./} @fs;
@fs=grep {/\.jpe?g$/i} @fs;

#@fs=map{$_="\"$_\""} @fs;$lista=join(", ",@fs); #para listado en js
chdir($dir);
#Abrimos y nos ponemos a escribir
print "\n\n";
open(FL,">Miniaturas.html") or die "ERROR EsCRITURA";
print "Creando Contenido Miniaturas.html";
print FL <<END;
<html>
<head>
<title> Artistas del Taller Abracadabra. 2004</title>
<!--
	<meta name="keywords" content="taller,abracadabra,vigo,artista,pintor,pintora">
	<meta name="description" content>
-->
<link rel="stylesheet" type="text/css" href="estilo.css">
<style>
.cont{
	text-align:center;
	padding:10;
	border:1 solid green;
}
</style>
</head>
<body>

END
print FL "<h2 align=center>Obras de $dir</h2>\n";
print FL "<!-- FOTOS -->\n\n";
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

foreach(@fs){
	$_=~/^(.+)\.jp?g$/i;
	$nombre=$1;
print FL "<span class=cont>\n<a href=\"vista.html?".uri_escape($_)."\" target=vista><img src=\"$minidir/".uri_escape($_)."\" ".html_imgsize("$minidir/$_")."></a>\n<br>".$nombre."</span>\n\n";
}
print FL "\n<!-- FOTOS -->\n";
print FL "<span style='border:1 solid black;padding:10;width:235px'>Creado el D&iacute;a $mday/$mon/$year a las $hour:$min:$sec</span>";
print FL "\n</body>\n</html>";
close FL;
print "Ok\n";

print "Creando Vista.html...";
open(VS,">Vista.html") or die "ERROR EsCRITURA";
print VS <<END;
<html><head><link rel="stylesheet" type="text/css" href="estilo.css">
<script>
function cargar(){
var q=location.search
var titulo=q.slice(1,q.length-4)
document.getElementById('Laimagen').innerHTML="<center><h3>"+titulo+"</h3><br><img src=\""+q.slice(1,150)+"\"></center>"
}
</script></head>
<body onload="cargar()">
<div id="Laimagen" style='border:1 solid red'>&nbsp;</div>
</body></html>
END
print "Ok\n";
print "Creando Frames : index.html...";
open(VS,">index.html") or die "ERROR EsCRITURA";
print VS <<END;
<frameset cols="25%,*" frameborder=3>
	<frame name=minis src="Miniaturas.html">
	<frame name=vista src="Vista.html">
</frame>
END
print "Ok\n";
print "\n\nHECHO\n\n";
system "pause";







__END__