use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';

$dir=shift @ARGV;
$minidir="miniaturas";
$filesave="Cuartetas.html";
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
open(FL,">$filesave") or die "ERROR EsCRITURA";
print "GUARDANDO EN $dir/$filesave";
print FL <<END;
<html>
<head>
<title> INTRODUCIRTITULO </title>
<meta name="keywords" content="PONERALGOAQUI">
<meta name="description" content>
<link rel="stylesheet" type="text/css" href="../estilo.css">
<style>
.cont{text-align:center;vertical-align:width:100;height:100;middle;margin:10;border:1 solid black;}
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
$partir=1;
foreach(@fs){
	($w,$h)=imgsize($_);
	$_=~/^(.+)\.jp?g$/i;
	$nombre=$1;	
	
	#folio= 21x29.5 ==> en cm son 9x12
	if($w>=$h){
		$wcm=4;
		$hcm=$h*$wcm/$w;	
	}else{
		$hcm=7;
		$wcm=$w*$hcm/$h;
	}
$wcm=~s/\.\d+$//;
$hcm=~s/\.\d+$//;
print "$partir\n";
if($partir == 4){
	$break="<br style='page-break-before:always'>\n\n";;	
	$partir=1;
	print "-DIV\n";
}else{
	$break="";
	$partir++;
}
print FL "<span class=cont><img src=\"".uri_escape("$_")."\" style='width:$wcm"."cm;height:$hcm"."cm'>\n<p style='width:$wcm"."cm'>".$nombre."</p></span>\n\n$break";

}
print FL "\n</body></html>";
close FL;

print "HECHO\n";
system "pause";







__END__