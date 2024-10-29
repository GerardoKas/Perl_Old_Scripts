my $file=shift;


die "Falta el fichero de entrada" if ($file eq "");
print "OPERANDO CON $file\n";

$file=~/(.+?)([^\\]+)$/i;
$dir=$1;$name=$2;
$name=~/(.+?)\.(.+)$/i;
$name=$1;$ext=$2;
$nuevo="$dir"."$name\.new\.$ext";


use Image::Magick;
my $i=new Image::Magick;
$i->Read($file);


print "Equalize";
$i->Equalize();
print "Enhance";
$i->Enhance();
print "\nSaving";
$i->Write($nuevo);
print "Starting ... ";
system ("$nuevo");





__END__