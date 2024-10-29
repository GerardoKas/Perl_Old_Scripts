use Image::Magick;
my ($file,$im,$p)="";

$dest="C:/temp";

$file=shift @ARGV;
$im=new Image::Magick;

$im->Read($file);
$im->Scale(geometry=>300);
$p=$im->Clone();
for (1..20){
   print $_;
   $im->[$_]=$p->Clone();
   $p->Blur(geometry=>$_^2,radius=>$_^2,sigma=>$_^2);
   
}

$im->Set(delay=>16,loop=>-1);
print "\nCONVIRTIENDO COLOR ...";
$im->Quantize(colors=>64);
print "\nGUARDANDO";
$im->Write("$dest/Blurred.gif");
print "\nFINITO\n";
