use Image::Size 'html_imgsize';
use CGI 'escapeHTML';
$dir=shift @ARGV;
#$dir='E:\Abracadabra\VARIOIMAGEN\Trabajos Niños 1998';
print "Listado de \"$dir\"\n";
opendir(DR,$dir) or die "NO EXISTE $dir";
@fs=readdir(DR);
closedir DR;

@fs=grep {!/^\./} @fs;
@fs=grep {/\.jpe?g$/i} @fs;


print ($#fs+1)." Archivos";
print "$dir\n\n";
foreach(@fs){
	print "$_\n";
open(FL,">$dir/$_\.html") or die "ERROR EsCRITURA";
print FL <<END;
<style>
IMG{border:thin solid black}
</style>
<link rel='stylesheet' type='text/css' href='hoja.css'>
END
print FL "<div class=Cont>\n";
print FL "<img src=\"".escapeHTML($_)."\" ".html_imgsize("$dir/$_")." align=left>\n";
print FL "<span align=right> TEXTOAQUI </span>\n";
print FL "</div>";
close FL;

}
print "HECHO\n";
system "pause";







__END__
