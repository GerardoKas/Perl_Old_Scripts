$rule=<<END;
F->F++FF++F
END
############################
$iter=4;
$start="F";
$angle=51;
$len=20;
$res="";
############################
my $ima=new Image::Magick;
$ima->Set(size=>'800x500');
$ex=400;$ey=250;
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
for(1..$iter){
print "$res\n";
$res=sust($res,\%RULES);

}
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
for(@rr){
   if($_ eq "F"){
      $dx=$ox;$dy=$oy;
      $dx+=$len;
      ($dx,$dy)=rota($len,0,$aang);
      $dx+=$ox;$dy+=$oy;
      $line="$ox,$oy $dx,$dy";
      $ima->Draw(pen=>$pen,primitive=>'line',points=>$line);   
      $ox=$dx;$oy=$dy;
   }elsif($_ eq "+"){
      $aang+=$angle;
   }elsif($_ eq "-"){
      $aang-=$angle;
   }
}

####PROBLEMAS CON EL DIR
mkdir ("C:\\TURTLES") or  print "CANNOT CREATE EL DIRECTOIRO TURTLES ENC";
$dest="\"c:\\TURTLES\\turtle".time.".png\"";
print "\n\n\n $dest";
$ima->Write($dest);
system ("start '$dest'");
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