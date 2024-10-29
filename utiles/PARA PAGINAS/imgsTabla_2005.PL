use Image::Size 'html_imgsize';
use CGI 'escapeHTML';
use File::Find qw(find);
$dir=shift @ARGV;
print "TABLA de \"$dir\"\n";

# opendir(DR,$dir) or err( "NO EXISTE $dir");
# @fs=readdir(DR);
# closedir DR;

chdir($dir);
open(FL,">TablaTuraImagens.html") or die( "ERROR EsCRITURA");
print "Imagenes JPG\n\n";
print "<table width=75% border=1 cellspacing=0 cellpadding=10>\n";
find(\&procesar,$dir);
print "</table>";
close FL;
print "HECHO\n";
system "pause";


sub procesar{
  my $file=shift;
  return unless ($file=~/\.jpe?g$/i);
	$f=escapeHTML($file);
	$alt=$f;
	$alt=~s/\.jp?g$//i;
	print FL "<tr><td>\n<img src=\"$f\" alt=\"$alt\" width=300>\n<br><small>$alt</small></td><td>&nbsp;</td></tr>\n";

}

__END__