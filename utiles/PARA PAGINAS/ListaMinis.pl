use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';

$dir=shift @ARGV;
$minidir="miniaturas";
print "Listado de \"$dir\"";
#$dir='E:\Abracadabra\Taller abracadabra\En Clase Lunes 13-10-2003\miniaturas';
opendir(DR,$dir) or die "NO EXISTE $dir";
@fs=readdir(DR);
closedir DR;

@fs=grep {!/^\./} @fs;
@fs=grep {/\.jpe?g$/i} @fs;

print ($#fs+1)." Archivos";

#@fs=map{$_="\"$_\""} @fs;$lista=join(", ",@fs); #para listado en js
chdir($dir);
#Abrimos y nos ponemos a escribir
open(FL,">LasMinis.html") or die "ERROR EsCRITURA";
print "\nGUARDANDO EN $dir/Lasminis.html\n";
print FL <<END;
<html>
<head>
<title> INTRODUCIRTITULO </title>
<meta name="keywords" content="PONERALGOAQUI">
<meta name="description" content>
<link rel="stylesheet" type="text/css" href="../estilo.css">
<style>
IMG{border:thin solid black;}
.cont{text-align:center;vertical-align:width:100;height:100;middle;margin:10;border:15 solid black;}
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

foreach(@fs){
	($w,$h)=imgsize($_);
print FL "<span class=cont>\n<a href='javascript:abrir(\"".escapar($_)."\",".$w.",".$h.")'><img src=\"".escapar("$minidir/$_")."\" ".html_imgsize("$minidir/$_")."></a>\n</span>\n\n";
}
print FL "\n</body></html>";
close FL;

print ".. HECHO\n\n";
system "pause";

sub escapar(){
	uri_escape($_);#,"^A-Za-z");
	}







__END__