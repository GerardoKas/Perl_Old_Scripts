use Image::Magick;
my ($file,$im,$p)="";
$dest="C:/temp";

$file=shift @ARGV;
$im=new Image::Magick;

$im->Read($file);
$im->Scale(geometry=>300);
$im->Quantize(colors=>16);
$p=$im->Clone();
for (1..10){
   print $_;
   $im->[$_]=$p->Clone();
   $im->[$_]->Roll(geometry=>"10",x=>$_*30);
   
}

$im->Set(delay=>20,loop=>-1);
#$im->Quantize(colors=>16);
print "\nGUARDANDO";
$im->Write("$dest/Roll.gif");
print "\nFINITO\n";
