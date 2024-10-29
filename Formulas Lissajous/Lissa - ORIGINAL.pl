use Image::Magick;

my $ima=new Image::Magick;
$ladoX=200;$ladoY=225;
print "TAMAÑO : $ladoX"."x$ladoY\n";
$ima->Set(size=>"$ladoX"."x$ladoY");
$ima->Read("xc:white");
$ima->Transparent('white');
$ima->Quantize(colors=>4);


$frecX=1;$frecY=1;       #<--- PON AQUI LAS FRECUENCIAS
print "fRECUENCIAS: $frecX a $frecY\n";
$numframes=10;             #<---- PON AQUI EL NUMERO DE FRAMES

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
      $xa=sin($i*$frecX+$n)*100+100;
      $ya=cos($i*$frecY+$n)*100+125;
      $xa=int($xa);$ya=int($ya);
      #print "LINEA: $xa,$ya $xb,$yb\n";
      $ima->[$j]->Draw(pen=>'#660011',primitive=>'line',points=>"$xa,$ya $xb,$yb");
      $xb=$xa;
      $yb=$ya;        
   }
$n+=$frame;
}

$ima->[0]->Annotate(pen=>'#00ff00',font=>'@c:/windows/fonts/ariblk.ttf',text=>"Frec: $frecX a $frecY");


print "Decolorando ...\n";
$ima->Quantize(colors=>4);

$ima->Set(delay=>16,loop=>-1);
$anima=($numframes>1)?" - $numframes":"";
$dest="Frec_$frecX a $frecY - ORIG.gif";
print "GUARDANDO EN $dest\n";
$ima->Write($dest);
              