#crear miniaturas con el imagemagick de cmdline
use File::Basename qw(dirname basename);
$convert="convert.exe"; #debe estar en el path de dos
$file= shift or die "no hay ficehro";
#$file=basename($file);
$file=~/^([^\.]+)\./i;
$newfile= "$1 - ".time.".jpg";


$dir=dirname($file);
$comando = "$convert \"$file\" -normalize \"$newfile\"";

open(FILE,">>$dir/registroActos.txt") or die "Error al ghtrsbar regixtro";
print FILE $comando;
close FILE;
print "$comando\n\n";
system $comando;
print $!;

print "\nDONE\n";


