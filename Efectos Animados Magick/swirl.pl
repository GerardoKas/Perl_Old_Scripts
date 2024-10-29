use Image::Magick;
my ($file,$im,$p)="";
#print "\nESTE ES GENIAL\n";
$dest="C:/temp";

$file=shift @ARGV;
$im=new Image::Magick;

$im->Read($file);
$im->Scale(geometry=>300);
$im->Quantize(colors=>16);
#$im->Set(
#   background=>'black',
#   bordercolor=>'black',
#   #mattecolor=>'black',
#   #matte=>True
#   );

$p=$im->Clone();

for (1..15){
   print $_;
   $x=$_/2;$y=$_/3;
   $im->[$_]=$p->Clone();
   $im->[$_]->Swirl(degrees=>$_*10);
   
}
$im->Set(delay=>12,loop=>-1);
#$im->Quantize(colors=>16);
print "\nGUARDANDO";
$im->Write("$dest/Swirl.gif");
print "\nFINITO\n";
