use Image::Magick;
my ($file,$im,$p)="";
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
   $im->[$_]->Modulate(hue=>$_*2);
   
}

$im->Set(delay=>10,loop=>-1);
#$im->Quantize(colors=>16);
print "\nGUARDANDO";
$im->Write("$dest/ModulateHue.gif");
print "\nFINITO\n";
