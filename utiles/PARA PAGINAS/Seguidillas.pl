use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';

$dir=shift @ARGV;
$minidir="miniaturas";
$filesave="Seguidillas.html";
print "Listado de \"$dir\"";
#$dir='E:\Abracadabra\Taller abracadabra\En Clase Lunes 13-10-2003\miniaturas';
opendir(DR,$dir) or die "NO EXISTE $dir";
@fs=readdir(DR);
closedir DR;

@fs=grep {!/^\./} @fs;
@fs=grep {/\.(jpe?g|PNG)$/i} @fs;
@fs=sort(@fs);
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
body{background-color:dark-gray}
.cont{text-align:center;vertical-align:width:100;height:100;middle;margin:10;border:1 solid black;}
img{border:none}
a:hover{border:2 solid cyan}
</style>
<script>
var Mi="Obras Dixitales de Gerardo El Castro"
function abrir(lk,w,h){  
	w+=20
	h+=25
	var MyWin=window.open("","MyWin","width=475,height=475,resizable=1,scrollbars=1,statusbar=1");
	MyWin.document.open();
	MyWin.document.write("<center><b>"+lk + "</b></center><input type=button onclick='window.close()' value='Cerrar LaVentana'><br>")
	MyWin.document.write("<input type=button value='Ampliar Imagen' onclick='Imm.width=Imm.width*1.3;Imm.height=Imm.height*1.3'>")
	MyWin.document.write(" -- <input type=button value='Reducir Imagen' onclick='Imm.width=Imm.width*0.7;Imm.height=Imm.height*0.7'>")
  MyWin.document.write("<br><img id=Imm src='"+lk+"' width="+w*2+" height="+h*2+">");
	MyWin.document.close();
	MyWin.document.title=Mi
	MyWin.status=Mi
	MyWin.moveTo(0,0)
}
</script>

</head>
<body>
<h2><i>Fai Click Nas Imaxes Para Amplialas</i> - Haz Click En Las Imagenes Para Ampliarlas</h2>
END
$partir=1;
foreach(@fs){
	($w,$h)=imgsize($_);
	$_=~/^(.+)\.jp?g$/i;
	$nombre=$1;	
	
	#folio= 21x29.5 ==> en cm son 9x12
	if($w>=$h){
		$wcm=9;
		$hcm=$h*$wcm/$w;	
	}else{
		$hcm=12;
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
print FL "<span class=cont>";
print FL "<a href=\"javascript:void(0)\" onclick='abrir(\"".uri_escape($_)."\",$w,$h)'>\n";
print FL "<img src=\"".uri_escape("$_")."\" style='height:${w}px;width:${h}px' alt='".uri_escape($_)."'>\n";
#print FL "<span class=detalles>".$nombre."</span></span>\n\n";
print FL "</a></span>\n\n";

}#END FOREACH
print FL "\n</body></html>";
close FL;

print "HECHO\n";


__END__
