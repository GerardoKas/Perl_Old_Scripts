#!perl.exe -w
use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';

$dir=shift @ARGV;
$minidir="miniaturas";
if(!-e "$dir/$minidir"){
  print "Tiene que existir el directorio 'miniaturas' dentro de esta misma carpeta";
  exit;
}
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
<title>Taller de Arte Abracadabra de Vigo - Galería de Imágenes de Artista</title>
<meta name="keywords" content="taller,arte,abracadabra,pintura,dibujo,grabado,niños,adultos">
<meta name="description" content="Galería de Imágenes de alumnos del Taller Abracadabra">
<!-- <link rel="stylesheet" type="text/css" href="../estilo.css"> -->
<style>
BODY{
	background-color:black;
	color:#00ff00;
}
A {color:gold;}
A:hover{color:cyan;}
IMG{border:none}
.cont{
	text-align:center;
	height:100;
	margin:25;padding:15;
	border:1 solid green;
}
</style>
<script>
function Ampliar(lk,w,h){  
	w+=20
	h+=25
	window.open(lk,"","top=10,left=10,width="+w+",height="+h);
}
</script>

</head>
<body>

END
print FL "<h1 align=center>Obras de <b>Artista</b></h1>\n";
print FL "<h4 align=center>Taller Abracadabra de Vigo 2005</h4>\n";
print FL "<!-- FOTOS -->\n\n";
foreach(@fs){
	($w,$h)=imgsize($_);
	$_=~/^(.+)\.jp?g$/i;
	$nombre=$1;
	$size=int((-s $_)/1024)."Kb";
  print FL "<span class=cont>\n<a href='javascript:Ampliar(\"".uri_escape($_)."\",".$w.",".$h.")'>";
  print FL "<img src=\"$minidir/".uri_escape($_)."\" ".html_imgsize("$minidir/$_");
  print FL " alt=\"Taller Abracadabra\n$nombre\nClick Para Agrandarla\n$size\"><br>$nombre\n</a></span>\n\n";
}
print FL "\n<!-- FOTOS -->\n";
#Fin del Bucle Para ARCHIVOS

#PIE dE PAGINA

#Espacio para El comentario

print FL "<hr width=50% size=1>\n";
print FL "<div style='float:none;margin:40px;padding:25px;border:1 solid white'>\n";
print FL " - Comentario Para La Pagina - \n";
print FL "</div>";
#Calculos
@fecha=localtime(time);
$mday=$fecha[3];
$mon=$fecha[4]+1;
$year=1900+$fecha[5];
$fecha_hoy="$mday/$mon/$year";
#Al final de Todo
print FL <<END;
<hr class=B style="margin:15px"><center>
<a href="/tallerabracadabra/mandaremail.html">
Comunicarse con : TallerAbracadabra(2005)
</a><br> - Todos los derechos reservados - <br>
<a style="font-size:28pt" title="Haz click para entrar a la web completa" href="http://members.fortunecity.es/tallerabracadabra/">
P&aacute;gina Principal
</a>
<br>
<script>
document.write(document.title +"<br>")
</script>
P&aacute;gina creada el : $fecha_hoy
</center><hr class=B> 
END

#FIN DEL DOCUMENTO
print FL "\n</body>\n</html>";
close FL;

print "\n\nHECHO\n\n";








__END__
