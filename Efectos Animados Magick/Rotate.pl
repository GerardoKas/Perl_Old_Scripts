use Image::Magick;
my ($file,$im,$p)="";
print "\nESTE TAMPOCO FUNCIONA MUY BIEN\n";
$dest="C:/temp";

$file=shift @ARGV;
$im=new Image::Magick;

$im->Read($file);
$im->Scale(geometry=>300);
$im->Quantize(colors=>16);
$im->Set(background=>'black',mattecolor=>'black',matte=>True);
$p=$im->Clone();
for (1..10){
   print $_;
   $im->[$_]=$p->Clone();
   $im->[$_]->Rotate(degrees=>(360/10*$_),crop=>False,sharpen=>False);
   
}
$im->Set(delay=>20,loop=>-1);
#$im->Quantize(colors=>16);
print "\nGUARDANDO";
$im->Write("$dest/Rotate.gif");
print "\nFINITO\n";
