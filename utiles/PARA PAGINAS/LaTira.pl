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
open(FL,">LaTiradeImagenes.html") or die "ERROR EsCRITURA";
print "GUARDANDO EN $dir";
print FL <<END;
<html>
<head>
<title>Taller Abracadabra de Vigo</title>
<link rel="stylesheet" type="text/css" href="../estilo.css">
<style>
BODY{
	background-color:black;
	color:#00ff00;
}
A{color:yellow}
A:hover{color:white}
A:visited{color:gold}
A:active{color:red}
IMG{border:none}
.marco{
	text-align:center;
	height:100;
	padding:15;margin-bottom:10;
	border:1 solid green;
}
#LaTira{
position:absolute;
width:220;height:460;
text-align:center;
overflow:scroll;
}
#LaFoto{
position:relative;
left:235;
width:620;height:460;
overflow:scroll;
}
#Titulo{
position:absolute;
padding:3;
border:1 solid black;
background-color:maroon;color:gold;
}

H6{font-family:arial;padding:5;border:1 solid white;}
</style>

<script>
function abrir(lk,w,h){  
	LaFoto.innerHTML="<span id=Titulo>" + lk + "</span><img src=\\"" + lk + "\\" width="+w+" height="+h+">";
}

function sizeIt(){
w=document.body.clientWidth
h=document.body.clientHeight
window.status=w + ", " + h
dh=h-80
LaTira.style.height=dh
LaFoto.style.height=dh
dw=w-220-25
window.status=dw
LaFoto.style.width=dw
}
</script>

</head>
<body onload=sizeIt() onresize=sizeIt()>

END
print FL "<h6 align=center>Obras de $dir</h6>\n";
print FL "<!-- FOTOS -->\n\n<div id=LaTira>";
@marquee=();
foreach(@fs){
	($w,$h)=imgsize($_);
	$_=~/^(.+)\.jp?g$/i;
	$nombre=$1;
	print FL "<span class=marco>\n<a href='javascript:abrir(\"".uri_escape($_)."\",".$w.",".$h.")'><img src=\"$minidir/".uri_escape($_)."\" ".html_imgsize("$minidir/$_")."></a>\n<br>".$nombre."</span>\n\n";
	push(@marquee,"<a href='javascript:abrir(\"".uri_escape($_)."\",".$w.",".$h.")'>$nombre</a>");
}#fin de foreach
print FL "\n</div>\n<!-- /FOTOS -->\n";
print FL "<div id=LaFoto>&nbsp;</div>\n\n";
print FL "<marquee scrolldelay=100 scrollamount=3>".join(" -#- " , @marquee)."</marquee>\n\n";
print FL "\n</body>\n</html>\n";
print FL "<!-- Copyright Taller de Arte Abracadabra de Vigo 2004. http://members.fortunecity.es/tallerabracadabra/ -->\n";
close FL;
print "\n\nHECHO\n\n";
system "pause";







__END__