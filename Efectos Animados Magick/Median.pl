use Image::Magick;
my ($file,$im,$p)="";
print "\nPARECE QUE ESTE NO FUNCIONA\n";
$dest="C:/temp";

$file=shift @ARGV;
$im=new Image::Magick;

$im->Read($file);
$im->Scale(geometry=>300);
$im->Quantize(colors=>16);
$p=$im->Clone();
for (1..15){
   print $_;
   $im->[$_]=$p->Clone();
   $im->[$_]->MedianFilter(radius=>$_*1.5);
   
}

$im->Set(delay=>10,loop=>-1);
print "\nCONVIRTIENDO COLOR ...";
#$im->Quantize(colors=>16);
print "\nGUARDANDO";
$im->Write("$dest/MedianFilter.gif");
print "\nFINITO\n";
