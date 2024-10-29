
@ACCION=qw(come jiña mea lava_los_dientes_a ducha_a viste_a lee escribe piensa mira oye estudia aprende toma ara recoge hace sube talla);
@OBJETO=
  qw(televisor coche telefono calculadora reloj telar arado yugo hoz saco piedra pava botella vaso libro silla vino patata pitillo ordenador impresora Bomba_H lapiz cuchillo lamparita vela fuego atomo gafas
  bananas peras tomates huevos pollo
);

open(FILE,"SUJETOS.txt") or die "No esta sujetos.txt";
@SUJETO=<FILE>;
close FILE;
chomp(@SUJETO);


open(FILE,"LUGARES.txt") or die "No esta lugares.txt";
@LUGAR=<FILE>;
close FILE;
chomp(@LUGAR);
#$ADJETIVo
rand(time());
for($i=0;$i<24;$i++){
$nSuj=int($#SUJETO * rand()+1);
$nAcc=int($#ACCION * rand()+1);
$nObj=int($#OBJETO * rand()+1);
$nLug=int($#LUGAR  * rand()+1);
print "".$SUJETO[$nSuj];
print " ".$ACCION[$nAcc];
print " UN ".$OBJETO[$nObj];
print " ".$LUGAR[$nLug];
print "\n\n";
}
