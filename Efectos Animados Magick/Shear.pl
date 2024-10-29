use Image::Magick;
my ($file,$im,$p)="";
#print "\nESTE ES GENIAL\n";
$dest="C:/temp";

$file=shift @ARGV;
$im=new Image::Magick;

$im->Read($file);
$im->Scale(geometry=>300);
$im->Quantize(colors=>16);
$im->Set(
   background=>'black',
   bordercolor=>'black',
   #mattecolor=>'black',
   #matte=>True
   );

$p=$im->Clone();

for (1..15){
   print $_;
   $x=$_-1;$y=$_;
   $im->[$_]=$p->Clone();
   $im->[$_]->Set('white-point'=>'$x,$y');
   
}
$im->Set(delay=>12,loop=>-1);
#$im->Quantize(colors=>16);
print "\nGUARDANDO";
$im->Write("$dest/White-point.gif");
print "\nFINITO\n";
