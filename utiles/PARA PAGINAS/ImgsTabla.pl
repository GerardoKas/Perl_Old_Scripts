use Image::Size 'html_imgsize';
use CGI 'escapeHTML';

$dir=shift @ARGV;
print "TABLA de \"$dir\"\n";
opendir(DR,$dir) or err( "NO EXISTE $dir");
@fs=readdir(DR);
closedir DR;

@fs=grep {!/^\./} @fs;
@fs=grep {/\.jpe?g/i} @fs;
@fs=sort(@fs);

print "Existen @fs Imagenes JPG\n\n";

chdir($dir);
open(FL,">TablaDeImagenes.html") or err( "ERROR EsCRITURA");
select FL;

print "<table width=75% border=1 cellspacing=0 cellpadding=10>\n";
foreach(@fs){
	$f=escapeHTML($_);
	$alt=$f;
	$alt=~s/\.jp?g$//i;
	print "<tr><td>\n<img src=\"$f\" alt=\"$alt\">\n<br><small>$alt</small></td><td>&nbsp;</td></tr>\n";
}
print "</table>";

print FL $lista;
close FL;
select STDOUT;
print "HECHO\n";
system "pause";

sub err{
	
print "Error: ".shift(@_)."\n";
system("pause");
exit;
}







__END__