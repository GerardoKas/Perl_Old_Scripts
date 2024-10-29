use Image::Magick;
use Data::Dumper;
my $ima=new Image::Magick;

$ima->Set(size=>'300x300');
$ima->Quantize(colors=>16);
$ima->Read('xc:white');


$a=0;
for (1..8){
$ox=30;
$oy=0;
($x,$y)=rota($ox,$oy,$a);
print "$x,$y\n";
$x+=100;
$y+=100;
#$ima->[$_]=$ima->[0]->Clone();
$ima->Draw(pen=>$pen,primitive=>'line',points=>"100,100 $x,$y");
   $a+=45;
}


$dest="IMA.gif";
$ima->Write($dest);
system "start $dest";


sub rota{
#ROTACION RESPECTO AL EJE 0,0
   my($x,$y,$a)=@_;
   if ($a==0) {return ($x,$y);}
  # $a=360/$a;
   #p1rint "a($a)";
   $a=(3.141592*$a)/180;
   print "\t$a\n";
my $dx=int(cos($a)*$x -sin($a)*$y);
my $dy=int(sin($a)*$x +cos($a)*$y);
#print "$dx---$dy\n";
return ($dx,$dy);
}