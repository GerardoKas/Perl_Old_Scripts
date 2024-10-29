#crear miniaturas con el imagemagick de cmdline

$convert="convert.exe"; #debe estar en el path de dos
$minidir="mini";

#use File::Find "find";

$dir=shift or die "Debes enviar el directorio base";
print "\n";
opendir (DIR,$dir) or die "No se pudo abrir el dir $dir";
@files=readdir(DIR);
closedir DIR;
@files=grep{/\.jpe?g$/i} @files;
chdir $dir;
mkdir($minidir,0777) unless (-s $minidir);

print "Hay $#files Imagenes\n\n";
foreach $file(@files){
print "$file : ";
system  "$convert -size 120x120 $file -quality 25 -thumbnail 120x120  $minidir\\$file";

#print $!;
print "\n";
}
print "\nDONE\n";


