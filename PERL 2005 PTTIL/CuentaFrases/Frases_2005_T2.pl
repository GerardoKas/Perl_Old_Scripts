
$destino="Frases-".time().".html";

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

open(FILE,"ACCIONES.txt") or die "No esta acciones.txt";
@ACCION=<FILE>;
close FILE;
chomp(@ACCION);

#$ADJETIVo
rand(time());
open(SAVE,">$destino") or die "no se pudo save";
select SAVE;
print "<table border=1>";
print "<tr><td>QUIEN?</td><td>HACE QUÉ?</td><td>EN DONDE?</td></tr>";
for($i=0;$i<24;$i++){
$nSuj=int($#SUJETO * rand()+1);
$nAcc=int($#ACCION * rand()+1);
$nObj=int($#OBJETO * rand()+1);
$nLug=int($#LUGAR  * rand()+1);
print "<tr><td>".$SUJETO[$nSuj]."</td><td>".$ACCION[$nAcc]."</td><td>".$LUGAR[$nLug]."</td></tr>";
print "\n\n";
}
print "</table>";
close SAVE;

system "$destino";
