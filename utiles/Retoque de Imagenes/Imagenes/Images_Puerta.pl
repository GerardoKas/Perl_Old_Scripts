use Image::Magick;
use File::Basename qw(dirname basename);
$baseFile=shift ;
@files=@ARGV;
#$directorio=dirname($files[0]);
$dest="png:c:/perl/utiles/montaje.png";
my $img=new Image::Magick;
my $fondo=new Image::Magick();


print "Reading:\n";
$fondo->Read($baseFile);

$img->Read(@files);


print "\nScaling";
print $img->Scale(geometry=>"140x140");
($w,$h)=$img->Get('width','height');
print "\nComposing";
#crea frame en una imagen
my $montage = $img->Montage(
                        caption=>'IMAGS',
                        geometry=>'300x300',#"$w"."x$h", 
                        tile=>'2x2', 
                        borderwidth=>2,
                        #mode=> 'Frame',
                        frame=>'10x10',    
                        transparent=>'black',
                        );
#$montage->Set(delay=>100,matte=>1); 
                 
print "...Saving";
$montage->Write($dest);
print "Done";
#system("$dest");
