use Image::Magick;
use registro;
my $ima=new Image::Magick;
$ima->Set(size=>'600x400');
$ex=0;$ey=200;
$ima->Quantize(colors=>4);
$ima->Read('xc:white');
$pen="black";
cargavalores();
##########################
sub cargavalores{
$key_programa="software\\perl\\Turtle_GCM";
if(leerreg()){
cargarparametros();
}else{
$rule=<<END;
F->C
C->ABA
A->+F+F
B->F+F++
END
$iter=12;$start="F";$angle=45;$len=7;
}
$res="";

$text="$rule\nITER: $iter\nANGLE: $angle\nLEN: $len";

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
for(1..$iter){
$res=sust($res,\%RULES);
print "($_ ->)\n$res\n\n";
}
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
sub leerreg{
print "DESEAS LEER LOS PARAMETROS DEL REGISTRO PARA $key_program\n? ";
$r=<>;
chomp($r);
if($r==1 || $r eq "s" || $r eq "S" || $r eq "y" || $r eq "Y"){
 return 1;  
}else{
 return 0;
}
}
sub cargarparametros{
$rule=cargarclave($key_programa,"rule");
$iter=cargarclave($key_programa,"iter");
$start=cargarclave($key_programa,"start");
$angle=cargarclave($key_programa,"angle");
$len=cargarclave($key_programa,"len");
}