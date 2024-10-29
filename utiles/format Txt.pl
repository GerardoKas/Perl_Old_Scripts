$file= shift;
die "No hay fichero" unless $file;

open(FILE,"<$file") or die "no se puede abrir $file";
@lines=<FILE>;
close FILE;

$texto=join("",@lines);

$texto=~s/(\.[^\.]+"?)/$1\n/g;

print $texto;

$dest="$file\.bak";

rename($file,$dest);
open(SAVE,">$file") or die "cannot save";
print SAVE $texto;
close SAVE;