use Image::Magick;
use File::Basename qw(dirname basename);

@files=@ARGV;
#$directorio=dirname($files[0]);
$dest="gif:c:/perl/utiles/try.gif";
my $img=new Image::Magick;
#my $papel=new Image::Magick;
#$papel->Read("xc:white");
#$papel->Set(geometry=>'600x600');

print "Reading:\n";
$img->Read(@files);

for($a=0;$a<=2;$a++){
print "Rotate $files[$a] - ";
#print $img->[$a]->Set(matte=>'true');
#print $img->[$a]->Set(background=>'black');
#print $img->[$a]->Rotate(degrees=>(rand()*8+3) ,sharpen=>0,crop=>0);

}
print "\nScaling";
print $img->Scale(geometry=>"223x223");
($w,$h)=$img->Get('width','height');
print "\nComposing";
#crea frame en una imagen
my $montage = $img->Montage(
                        caption=>'IMAGS',
                        geometry=>"$w"."x$h", 
                        tile=>'1x1', 
                        borderwidth=>2,
                        mode=> 'Frame',
                        frame=>'10x10+4+4',
                        bordercolor=>'tomato',
                        transparent=>'black',
                        image=>$files[0]
                        );
$montage->Set(delay=>100,matte=>1); 
                 
print "...Saving";
$montage->Write($dest);
print "Done";
#system("$dest");
