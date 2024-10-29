use Image::Magick;
use FIle::basename;
if (!@ARGV){
die "Faltan el ficheros de entrada";
}else{
print @ARGV;
}
$fuente="c:\\windows\\fonts\\Arial.ttf";
print "Escribe la cadena que deseas que aparezca en todas las imagenes:\n";
$cadena=<STDIN>;
chomp($cadena);
if(!$cadena){
	$cadena = "Made By Gcm 2004";
}
print  "Deseas Añadir el nombre de archivo al final?";
$ok=<STDIN>;
foreach(@ARGV){
	$destino=dirname($_);
	if(!-e $destino){
			mkdir($destino,777);
	}
	Anotar ($_);
}

######################
sub Anotar{
my $file=shift;
($dir,$name,$ext)=fileparse($file);
$fileput=$destino."$name-Nota.jpg";
if(!-e $original){rename($file,$original);}
if($ok eq "s" or $ok eq "S"){$cadena=$cadena." - $name";}
my $i=new Image::Magick;
$i->Read($original);
#$err=$i->Annotate(text=>"$cadena", font=>"\@$fuente", pointsize=>24, geometry=>'+0+0', #pen=>"red", gravity=>"SouthWest", antialias=>"true", scale=>(50,50));pointsize=>20
($w,$h)=$i->Get('width','height');
$x=0;$y=0;
$percent=40;
$tw=($percent*$w)/100;
$th=($percent*$h)/100;
$x=$percent;
$y=$percent;
$err=$i->Annotate(font=>"\@$fuente", text=>$cadena, density=>$tw."x".$th, geometry=>"$w"."x$h", stroke=>'red', fill=>'yellow', box=>'black', x=>$x, y=>$y, gravity=>'SouthEast'); 
print "\n".0+$err."\n";
#Creo que y= tiene que ser igual o mayor que el tamaño en puntos . O al menos asi funcuiona el error

#$i->Normalize();
$i->Write($fileput);
}



__END__