use Image::Magick;
use File::Basename qw(dirname basename);

@files=@ARGV;
$nFiles=$#files;
$directorio=dirname($files[0]);
#$dest="png:c:/perl/utiles/montaje.png";

my $img=new Image::Magick;

my $tInit=time();
foreach($i=0;$i<=$nFiles;$i++){
  print "Reading ... ";
  $img->Read($files[$i]);

  #img->[$i]->Sample(geometry=>'141x141');
  #$img->[$i]->Blur(geometry=>'2x0.5');
  $img->[$i]->Resize(geometry=>'141x141', filter=>'Hermite');
  $img->[$i]->Set(compression=>'JPEG',quality=>'4');
  print $new=$img->[$i]->Profile(name=>'IPTC');
  print "Saving $i ...\n";
  $img->[$i]->Write("c:/perl/utiles/".basename($files[$i]),compression=>'JPEG',quality=>4);
}
my $tEnd=time();
my $tTiempo=int($tEnd-$tInit);
print "Tardamos $tTiempo en hacer $nFiles Imagenes\n";
$img->Destroy();
