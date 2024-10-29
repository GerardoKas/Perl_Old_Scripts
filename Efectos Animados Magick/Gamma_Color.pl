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
   $im->[$_]->Gamma(red=>$_);
   
}

$im->Set(delay=>10,loop=>-1);
print "\nCONVIRTIENDO COLOR ...";
$im->Quantize(colors=>16);
print "\nGUARDANDO";
$im->Write("$dest/Gammaged_red.gif");
print "\nFINITO\n";
