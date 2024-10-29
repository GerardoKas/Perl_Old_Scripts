use Image::Magick;

my $ima=new Image::Magick;
$ladoX=200;$ladoY=225;
print "TAMA�O : $ladoX"."x$ladoY\n";
$ima->Set(size=>"$ladoX"."x$ladoY");
$ima->Read("xc:white");
$ima->Transparent('white');
$ima->Quantize(colors=>4);


$frecX=16;$frecY=24;       #<--- PON AQUI LAS FRECUENCIAS
print "fRECUENCIAS: $frecX a $frecY\n";
$numframes=11;             #<---- PON AQUI EL NUMERO DE FRAMES

#Crear todos los frames
for(0..$numframes-1){
   $ima->[$_]=$ima->[0]->Clone();   
}

$n=0;
$p=10;
$ciclo=6.28;
$frame=$ciclo/$numframes;

for ($j=0;$j<$numframes;$j++){
   print "FRAME: $j\n";
   $xb=$ladoX/2;
   $yb=$ladoY/2;
   $p+=3;
   for($i=0;$i<300;$i++){
      $xa=int(sin($i*$frecX)*100)+100;
      $ya=int(cos($i*$frecY+$n)*cos($i)*100)+125;
      #print "LINEA: $xa,$ya $xb,$yb\n";
      $ima->[$j]->Draw(pen=>'#660011',primitive=>'line',points=>"$xa,$ya $xb,$yb");
      $xb=$xa;
      $yb=$ya;        
   }
$n+=$frame;
}

$ima->[0]->Annotate(pen=>'green',font=>'@c:/windows/fonts/ariblk.ttf',text=>"Frec: $frecX a $frecY");


print "Decolorando ...\n";
$ima->Quantize(colors=>4);

$ima->Set(delay=>12,loop=>1);
$anima=($numframes>1)?" - $numframes":"";
$dest="Frec_$frecX a $frecY$anima - TRANSP.gif";
print "GUARDANDO EN $dest\n";
$ima->Write($dest);
              