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
open(FL,">LasMinis.html") or die "ERROR EsCRITURA";
print "GUARDANDO EN $dir/LasminisNomArk.html";
print FL <<END;
<html>
<head>
<title> Taller de Arte Abracadabra de Vigo - Galería de Imágenes</title>
<meta name="keywords" content="taller,arte,abracadabra,pintura,dibujo,grabado,niños,adultos">
<meta name="description" content="Galería de Imágenes de alumnos del Taller Abracadabra">
<link rel="stylesheet" type="text/css" href="../estilo.css">
<style>
BODY{
	background-color:black;
	color:#00ff00;
}
IMG{border:none}

.cont{
	text-align:center;
	height:100;
	margin:25;padding:15;
	border:1 solid green;
}
</style>
<script>
function abrir(lk,w,h){  
	w+=20
	h+=25
	window.open(lk,"","width="+w+",height="+h);
}
</script>

</head>
<body>

END
print FL "<h2 align=center>Obras de $dir</h2>\n";
print FL "<!-- FOTOS -->\n\n";
foreach(@fs){
	($w,$h)=imgsize($_);
	$_=~/^(.+)\.jp?g$/i;
	$nombre=$1;
print FL "<span class=cont>\n<a href='javascript:abrir(\"".uri_escape($_)."\",".$w.",".$h.")'><img src=\"$minidir/".uri_escape($_)."\" ".html_imgsize("$minidir/$_")."></a>\n<br>".$nombre."</span>\n\n";
}
print FL "\n<!-- FOTOS -->\n";
print FL "\n</body>\n</html>";
close FL;

print "\n\nHECHO\n\n";
system "pause";







__END__