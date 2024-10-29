use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';

my $dir=shift @ARGV;

my $minidir="miniaturas";
my $suposeMini="127";#pixeles de la miniatura suponemos
my $page_save="Minis_With_Href.html";
my $visual="Visual.html";
my $hoy=getFecha();
print "\n$dir\n";

opendir(DR,$dir) or die "NO EXISTE $dir";
@fs=readdir(DR);
closedir DR;

@fs=grep {/\.(jpe?g|gif)$/i} @fs;
@fs=sort(@fs);
print "\n$#fs Archivos\n";
chdir($dir);

#Abrimos y nos ponemos a escribir
open(FL,">$page_save") or die "ERROR EsCRITURA";
open(VIS,">$visual") or die "ERROR EN write VISUAL";
print "\nGUARDANDO\n";

print FL <<END;
<html>
<head>
<title> Taller de Arte Abracadabra </title>
<!-- <link rel="stylesheet" type="text/css" href="../estilo.css"> -->
<style>
IMG{border:1 solid black;}
BODY{font-family:comic;font-size:14pt;color:darkblue;background-color:ffed77}
#.Imagen{text-align:center;vertical-align:width:100;height:100;middle;margin:10;border:0 groove maroon;}
.TSup{border:0;}
.TUna {border:4 double maroon;background-color:tomato;}
</style>
</head>
<body>
END

$num=0;
my @lista=();
$table_sup="\n<TABLE WIDTH=75% align=center class=TSup><tr><td>\n\n";
$table_sup_end="\n\n</TABLE>\n";

print FL $table_sup;

foreach(@fs){
	($mw,$mh)=imgsize("$minidir/$_");
	$fname=escapar($_);
	push(@lista_js,$fname);
	if ($num%4==0){
	print FL "$table_sup_end\n$table_sup";
	}
  print FL "<table class=TUna align=left width='".($suposeMini+32)."' height='".($suposeMini+60)."'>\n";
  print FL "<tr><td valign=middle align=center>";
  print FL "<a target=Visual href=\"$visual?$num\">\n";
  print FL "<img src=\"$minidir/$fname\" width='$mw' height='$mh' align='middle'>";
  print FL "</a></td></tr>";
  print FL "<tr><td align=center class=ImName>$_</td></tr>\n";
  print FL "</table>\n\n";
  $num+=1;
}
print FL "$table_sup_end";
print FL "<!-- Made By TallerAbracadabra2005 -->";
print FL "<hr size=1 width=100%><small>Fabricada por el Taller Abracadabra en el d&iacute;a de $hoy</small><hr size=1 width=100%>";
print FL "\n</body></html>";
close FL;
my $arrayJs="\"".join("\", \"",@lista_js)."\"\n";

#AHORA IMPRIMIR LA VUSIAL;
print VIS <<END;
<html>
<head>
<title>VIENDO IMAGENES</title>
</head>
<script>
var Imags=new Array($arrayJs);

var pageTitle="Obras Ana Pasarin 2005";
var mini="miniaturas/";
var file;
var n;
var pr
var po

function carga(){
  n=location.search;
if (n == "" ){
   noSearch()
   return 0
}
  n=n.substr(1,n.length);
  n=parseInt(n)
  file=Imags[n];
  putImage()
}
function noSearch(){
 n=parseInt(Math.random()*Imags.length)
  file=Imags[n]
  putImage()
}

function putImage(){
  myImage.src=file;
  myImage.alt=file + "\\n" + pageTitle;
  self.focus();
  myImage.focus()
  datos()
}

function datos(){
  mw=myImage.width;
  mh=myImage.height
  Actual.innerHTML=unescape(file.bold().big()) + "<br>"+mw + "x"+mh + "pixels"

  pr=((n-1)<0)?Imags.length-1:(n-1);
  po=((n+1)>Imags.length-1)?0:(n+1);
  
  iPrev.src=mini+Imags[pr]
  iPos.src=mini+Imags[po]
  iPrev.alt=Imags[pr]
  iPos.alt=Imags[po]
  Prev.innerHTML="(" + pr + ")<br><a href='?"+pr+"'>" + unescape(Imags[pr]) + "</a><BR>"
  Post.innerHTML= "(" + po + ")<br><a href='?"+po+"'>" + unescape(Imags[po]) + "</a><BR>"
  document.title="+" + file + "[" + pageTitle + "] - Taller de Arte Abracadabra de Vigo"
}
</script>

<style>
BODY{
  background-color:262222
}
.T{
background-color:444448;color:gold;text-align:center
}
.I{
background-color:333339;color:gold
}
a{
  color:orange;
  text-decoration:underline;
  font-weight:bold
}
a:hover{
  color:yellow;
  text-decoration:underline overline;
  font-weight:normal;
}
</style>

<body onload=carga()>

<table align=center>
<tr><td class=T align=center colspan=3><a href="javascript:opener.focus()">INDICE</a></td></tr>
<tr>
<td class=I align=middle valign=middle><span id=Prev>&nbsp;</span><br><img id=iPrev src="http://"></td>
<td class=I align=middle valign=middle><span id=Actual>&nbsp;</span><br><img id=myImage src="http://" onload="datos()"></td>
<td class=I align=middle valign=middle><span id=Post>&nbsp;</span><br><img id=iPos src="http://"></td>
</tr>
<tr><td class=T align=center colspan=3><a href="javascript:opener.focus()">INDICE</a></td></tr>
</table>
<br>
<small>Hecho por el Taller Abracadabra el d&iacute;a $hoy</small>
<hr>
</body>
</html>
END
close VIS;

print "\n.. HECHO\n\n";

sub escapar(){
	uri_escape($_);#,"^A-Za-z");
}

sub getFecha(){
@fecha=localtime(time);
$mday=$fecha[3];
$mon=$fecha[4]+1;
$year=1900+$fecha[5];
$fecha_hoy="$mday/$mon/$year";
return $fecha_hoy;
}
