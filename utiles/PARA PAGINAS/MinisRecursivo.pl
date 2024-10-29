#!perl.exe -w
use File::Find;
use Image::Size qw(html_imgsize imgsize);
use URI::Escape 'uri_escape';
$dir=shift @ARGV;
$dir=~s|\\|/|g;
$dir.="/";
$basePath=$dir;
#Abrimos y nos ponemos a escribir
chdir ($dir);
open(FL,">ElRecursivo.html") or die "ERROR EsCRITURA";
print "GUARDANDO EN $dir\n\n";
cabecera();
find(\&Hacer,$dir);
final();
sub Hacer{
	$n=$_;	
	$f=$File::Find::name;
	$d=$File::Find::dir;
	if(-d $f){
	print FL "<h3>$_</h3>";
	return;	
	}
	#print "N:$n : D:$d : $f \n\n";
	$url=uri_escape(remainin($d."/".$n));
	return if ($_=~/^\./);
	return unless ($n=~/\.jpe?g$/i);
	($w,$h)=imgsize($f);
	$n=~/^(.+)\.jp?g$/i;
	$nombre=$1;

print FL "<span class=cont>\n<img src=\"$url\" alt=\"$url\" width=$w height=$h)'>";
print FL "<br>$nombre</span>\n\n";
}

sub remainin{
($ruta)=@_;
$ruta=~s/$basePath//;
return $ruta;
}
sub cabecera{
print FL <<END;
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
END

print FL "<!-- FOTOS -->\n\n";
}

sub final{
print FL "\n<!-- FOTOS -->\n";
print FL "\n</body>\n</html>";
close FL;
print "\n\nHECHO\n\n";
}
__END__