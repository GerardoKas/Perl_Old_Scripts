my $file=shift;


die "Falta el fichero de entrada" if ($file eq "");
print "OPERANDO CON $file\n";

$file=~/(.+?)([^\\]+)$/i;
$dir=$1;$name=$2;
$name=~/(.+?)\.(.+)$/i;
$name=$1;$ext=$2;
$original="$dir"."$name\.original\.$ext";
if(!-e $original){
rename($file,$original);
}

use Image::Magick;
my $i=new Image::Magick;
$i->Read($original);



$i->Normalize();
$i->Write($file);




__END__