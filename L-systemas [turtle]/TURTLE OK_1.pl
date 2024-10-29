use Image::Magick;

##########################
sub cargavalores{

$rule=<<END;
F->C
C->ABA
A->+F+F
B->F+F++
END
$iter=12;
$start="F";
$angle=45;
$len=7;
$res="";
$text="$rule\nITER: $iter\nANGLE: $angle\nLEN: $len";
my $ima=new Image::Magick;
$ima->Set(size=>'400x400');
$ex=200;$ey=200;
$ima->Quantize(colors=>4);
$ima->Read('xc:white');
$pen="black";
}
#$doframes=1;
############################

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
$res=sust($res,\%RULES);
print "($_ ->)\n$res\n\n";
print LOG "($_)\n$res\n\n";
}
close LOG;
$cop=$res;
$num=$cop=~s/F/F/g;
print "\n$num Lineas\n";
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
print "$text\n";
##########################
my($ox,$oy,$dx,$dy,$aang);
$ox=$ex;
$oy=$ey;
$aang=0;

@rr=split("",$r);
##########################
my $frame=0;
$pa=0;
$ima->[0]->Annotate(pen=>'red',font=>'@c:/windows/fonts/arial.ttf', text=>"$text",pointsize=>6,gravity=>'NorthWest');
for(@rr){
   if($_ eq "F"){
      $num--;
      if($num % 10 == 0){print "Quedan $num Lineas\n";}
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
      $pa=$aang-$pa;
      #$ima->[$frame]->Annotate(pen=>'red',font=>'@c:/windows/fonts/arial.ttf', text=>"$pa",pointsize=>5,x=>$ox,y=>$oy);
      $ox=$dx;$oy=$dy;
      $pa=$aang;
   }elsif($_ eq "+"){
      $aang+=$angle;
   }elsif($_ eq "-"){
      $aang-=$angle;
   }
}
if($doframes){$ima->Set(delay=>30);$ext="gif"}else{$ext="png"}
print "\nSAVING...\n";
$dest="turtle.$ext";
$ima->Quantize(colors=>4);
$ima->Write($dest);
system "start $dest";
}
################################################################################
sub rota{
#ROTACION RESPECTO AL EJE 0,0
   my($x,$y,$a)=@_;
   if ($a==0) {return ($x,$y);}
   $a=(3.141592*$a)/180;
my $dx=(cos($a)*$x -sin($a)*$y);
my $dy=(sin($a)*$x +cos($a)*$y);
return ($dx,$dy);
}
################################################################################