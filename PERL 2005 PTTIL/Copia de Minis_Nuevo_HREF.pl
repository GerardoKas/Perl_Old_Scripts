use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';

my $dir=shift @ARGV;

my $minidir="miniaturas";
my $suposeMini="127";#pixeles de la miniatura suponemos
my $page_save="Minis_With_Href.html";
my $visual="Visual.html";
print "\n$dir\n";

opendir(DR,$dir) or die "NO EXISTE $dir";
@fs=readdir(DR);
closedir DR;

@fs=grep {/\.jpe?g$/i} @fs;
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
	($w,$h)=imgsize($_);
	($mw,$mh)=imgsize("$minidir/$_");
	$fname=escapar($_);
	push(@lista_js,$fname);
	if ($num%4==0){
	print FL "$table_sup_end<!-- NEWLINE -->$table_sup";
	}
  print FL "<table class=TUna align=left width='".($suposeMini+32)."' height='".($suposeMini+60)."'>\n";
  print FL "<tr><td valign=middle align=center>";
  print FL "<a target=Visual href=\"$visual?$num\">\n";
  print FL "<img src=\"$minidir/$fname\" width='$mw' height='$mh' align='middle'>";
  print FL "</a></td></tr>";
  print FL "<tr><td align=center class=ImName>$_</td></tr>\n";
  print FL "$table_sup_end\n\n";
  $num+=1;
}
print FL "$table_sup_end";
print FL "<!-- Made By TallerAbracadabra2005 -->";
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
var file;
var Imags=new Array($arrayJs);

function carga(){
  n=location.search;
  n=n.substr(1,n.length);
  if (!n) n=int(Math.random(1)*Imags.length);
  file=Imags[n];
  myImage.src=file;
  self.focus();
}
function datos(){
  mw=myImage.width;mh=myImage.height
  myText.innerText=file + ", Ancho:"+mw + " x Alto:"+mh
}
</script>
<body onload=carga()>
<span id=Links><a href="javascript:opener.focus()">INDICE</a></span>
<div align=center>
<img id=myImage src="http://" alt="Imagen" title="IMAGEN" onload="datos()">
</div>
<span id=myText>&nbsp;</span>
</body>
</html>
END
close VIS;

print "\n.. HECHO\n\n";

sub escapar(){
	uri_escape($_);#,"^A-Za-z");
}
