use Image::Magick;
use registro;
use Tk;
use Tk::Balloon;
my ($res,$rule,$angle,$len,$iter,$start);
my ($w,$h);
my $ima;
my $mw=MainWindow->new;
$mw->geometry('+0+0');
$mw->OnDestroy(\&closin);
$centros="200,200";
$tamano="400,400";
my $ccc=$mw->Canvas()->pack;
$ccc->configure(-width=>'800',-height=>'400');
$bal=$mw->Balloon();
$Trule=$mw->Text(width=>20,height=>3)->pack(side=>left);
$Trule->insert('end',$rule);
$FR0=$mw->Frame()->pack(side=>left);
$Tstart=$FR0->Entry(-textvariable=>\$start)->pack(side=>top);
$FR1=$mw->Frame()->pack(side=>left);
$Tcentro=$FR1->Entry(-textvariable=>\$centros)->pack(side=>top);
$Tlen=$FR1->Entry(-textvariable=>\$len)->pack(side=>bottom);
$FR2=$mw->Frame()->pack(side=>left);
$Tangle=$FR2->Entry(-textvariable=>\$angle)->pack(side=>top);
$Titer=$FR2->Entry(-textvariable=>\$iter)->pack(side=>bottom);

$mw->Button(text=>"GO!",command=>\&boton)->pack(side=>left);
$Fr3=$mw->Frame()->pack(side=>left);
$Fr3->Button(text=>"CREARARCHIVO!",command=>\&creaimagen)->pack(side=>top);
$Ttamano=$Fr3->Entry(textvariable=>\$tamano)->pack(side=>bottom);
$mw->Entry(textvariable=>\$status)->pack(side=>left);
#$mw->Button(text=>'BORRAR',command=>\&borrar)->pack(side=>left);
$bal->attach($Tcentro,-msg=>'Centro X,Y del grafico');
$bal->attach($Tlen,-msg=>'Largo de la linea');
$bal->attach($Tangle,-msg=>'Angulo de la linea');
$bal->attach($Titer,-msg=>'Numero Iteraciones');
$bal->attach($Ttamano,msg=>"Ancho,Alto de la imagen png");
#&crear
MainLoop;
sub BEGIN{
$key_programa="software\\perl\\Turtle_GCM";
unless($rule=cargarclave($key_programa,"rule")){
$rule=<<END;
F->+F+F+F-F-F-F
END
}
$iter=cargarclave($key_programa,"iter") || 4;
$start=cargarclave($key_programa,"start") || "F";
$angle=cargarclave($key_programa,"angle") || 60;
$len=cargarclave($key_programa,"len") || 5;
$res="";
#$doframes=1;
}

sub closin{
print "CERRANDO\nEL\nPROGRAMA\nADIOS\nHASTA LA\nVISTA\n";
crearclave($key_programa,"rule",$rule);
crearclave($key_programa,"angle",$angle);
crearclave($key_programa,"start",$start);
crearclave($key_programa,"len",$len);
crearclave($key_programa,"iter",$iter);
}

sub boton{
&borrar;
&parametros;
&regularizar;
&crear;
}
sub borrar{
$ccc->delete('all');
}

sub creaimagen{
$ima=new Image::Magick;
$ima->Set(size=>$w."x$h");
print "TAMANO IMAGEN: $wx$h\n";
$ima->Quantize(colors=>4);
$ima->Read('xc:white');
$pen="black";
&crear(1);
if($doframes){$ima->Set(delay=>30);$ext="gif"}else{$ext="png"}
print "\nSAVING...\n";
$dest="turtle_N.$ext";
$ima->Quantize(colors=>4);
$ima->Write($dest);
system "start $dest";
}

sub parametros{
($ex,$ey)=split(",",$centros);#copiar cdentroX cnetroY
($w,$h)=split(",",$tamano);
$rule=$Trule->get('0.0','end');#copiar la rule
}
#CREAR########################
sub crear{
my $doim=shift;
$res=$start;
for(1..$iter){
$res=sust($res,\%RULES);
print "($_ ->)\n$res\n\n";
}
$cop=$res;
$num=$cop=~s/F/F/g;
$status="\n$num Lineas\n";

dibuja($res,$doim);
}
##############################
################################################################################
sub dibuja{
my $r=shift;
my $hacerimagen=shift;
$text="$rule\nITER: $iter\nANGLE: $angle\nLEN: $len";
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
if($hacerimagen){
   print "anotando\n";
$ima->[0]->Annotate(pen=>'red',font=>'@c:/windows/fonts/arial.ttf', text=>"$text",pointsize=>6,gravity=>'NorthWest');
}
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
      $ccc->createLine($ox,$oy,$dx,$dy,-fill=>'red',-width=>1,-tags=>'ll');
      if($hacerimagen){
         $ima->[$frame]->Draw(pen=>$pen,primitive=>'line',points=>$line); 
      }
      $pa=$aang-$pa;
      $ox=$dx;$oy=$dy;
      $pa=$aang;
   }elsif($_ eq "+"){
      $aang+=$angle;
   }elsif($_ eq "-"){
      $aang-=$angle;
   }
}
}
############################
sub regularizar{
#Comprobar Reglas
my @rs=split("\n",$rule);
foreach(@rs){
($var,$val)=split("->",$_);
$RULES{$var}=$val;
print "$var ==> $val\n";
}
}

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

__END__
RULES PARA PROBAR:

45§
RULE=
F->-FA-FA
A->F++F++F++F
-------
70§
F->AABBB
A->F++F++F++F
B->F-F

------
F->+F+F+F-F-F-F
------
