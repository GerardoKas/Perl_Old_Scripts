use File::Find;
use File::Spec;
use Image::Magick;
$dir="C:/Mis documentos/Mis im�genes/2002-03-29";

local @files=();
local $n=0;
local $size=100;
local $dest="c:/Minuaturas2";
if(!-e $dest){mkdir($dest,700);}

find(\&tratar,$dir);

$fs=join("\",\"",@files);# unir con ","
$eltexto="<script>\nvar AR=new Array(\n\"$fs\"\n)<!--$n archivos-->\n</script>";
$tempfile="C:/windows/temp/unarrayjs.txt";
open(FL,">$tempfile") or die "ERROR TNTO";
print FL $eltexto;
close FL;
#system("start $tempfile");


sub tratar{
if($_=~/^\.+$/){return 0;}
&unfile($_);
&reducir($_);
}
sub reducir{
print $_;
if(!$_){return 0;};
  $p = new Image::Magick;
  
  $p->Read($_);
  ($w,$h) =$p->Get("width", "height");
  $h=150*$h/$w;
  $w=150;
  print "WIDTH=$w HEIGHT=$h";
  $p->Scale(height=>($h),width=>($w));
  $p->Sharpen(radius=>5,sigma=>3);
  $p->Write("$dest/$_");

}
sub unfile{
if(! -d $_){
$relfile="$File::Find::dir/$_";
$relfile=File::Spec->abs2rel($relfile,$dir);
$relfile=~s/\w:[\/\\]//;
$relfile=~s/\\/\//g;
push(@files,$relfile);
$n++;
#print $relfile."\n";
print $_."\n";
}

#print "--$_\n";
#push(@files,"$sdir\\$_") unless (/^\.+$/);
}