$rule=<<END;
F->Z
X->+FX--FX+
Y->-FY++FY-
Z->+
END
############################
$iter=8;
$start="FX";
$angle=60;
$len=15;
$res="";
$doframes=0;
############################
my $ima=new Image::Magick;
$ima->Set(size=>'400x300');
$ex=200;$ey=150;
$ima->Quantize(colors=>4);
$ima->Read('xc:white');
$pen="black";
############################

#Comprobar Reglas
my @rs=split("\n",$rule);
foreach(@rs){
($var,$val)=split("->",$_);
$RULES{$var}=$val;
print "$var ==> $val\n";
}

#CREAR########################
$res=$start;
open(LOG,">log.txt") or die "erro tonto";
print LOG "-"x80;
print LOG "\n$rule\n";
print LOG "-"x80;
print LOG "\n";
for(1..$iter){
print "$res\n";
$res=sust($res,\%RULES);
print LOG "($_)\n$res\n\n";
}
close LOG;
dibuja($res);
##############################




################################################################################
sub sust{
#Creacion  de iteraciones;
my ($fase,$RS)=@_;
foreach(sort keys %$RS){
$k=$_;
$v=$RS->{$k};
${$k}=$v;
$fase=~s/$k/\$$k/g;
}
$r=eval("\"$fase\"");
return $r;
}
################################################################################
sub dibuja{
my $r=shift;
use Image::Magick;
##########################
my($ox,$oy,$dx,$dy,$aang);
$ox=$ex;
$oy=$ey;
$aang=0;

@rr=split("",$r);
##########################
my $frame=0;
for(@rr){
   if($_ eq "F"){
      $dx=$ox;$dy=$oy;
      $dx+=$len;
      ($dx,$dy)=rota($len,0,$aang);
      $dx+=$ox;$dy+=$oy;
      $line="$ox,$oy $dx,$dy";
      if($doframes>0){
         print "FRAMING: $frame";
      $frame++;
      $ima->[$frame]=$ima->[$frame-1]->Clone();
      
      }
      $ima->[$frame]->Draw(pen=>$pen,primitive=>'line',points=>$line);   
      $ox=$dx;$oy=$dy;
      
   }elsif($_ eq "+"){
      $aang+=$angle;
   }elsif($_ eq "-"){
      $aang-=$angle;
   }
}
if($doframes){$ima->Set(delay=>30);$ext="gif"}else{$ext="png"}
print "\nSAVING...\n";
$dest="turtle.$ext";
$ima->Write($dest);
system "start $dest";
}
################################################################################
sub rota{
#ROTACION RESPECTO AL EJE 0,0
   my($x,$y,$a)=@_;
   if ($a==0) {return ($x,$y);}
   $a=(3.141592*$a)/180;
my $dx=int(cos($a)*$x -sin($a)*$y);
my $dy=int(sin($a)*$x +cos($a)*$y);
return ($dx,$dy);
}
################################################################################