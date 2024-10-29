use Image::Magick;
my ($file,$im,$p)="";

$dest="C:/temp";

$file=shift @ARGV;
$im=new Image::Magick;

$im->Read($file);
@nss=qw(Uniform Gaussian Multiplicative Impulse Laplacian Poisson);
foreach (@nss){
   $p=$im->Clone();
   $p->AddNoise(noise=>$_);
   $p->Write("$dest/$name\_$_.jpg");
}

