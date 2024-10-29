use File::Basename qw(dirname basename);
my @files;
$raiz=dirname($ARGV[1]);
chdir($raiz);
@files=map{name($_)} @ARGV;

foreach(@files){
print $_.", ";
}

print "\n\n";
print "Introduce parte1-antigua ((s/PARTE1/sust/i))\nPosicion de Inicio? : ";

$parte1=<STDIN>;chomp($parte1);

print "Introduce parte2-nueva ((s/parte1/PARTE2/i))\nCadena Para Añadir? : ";
$parte2=<STDIN>;chomp($parte2);

@temp=@files;
foreach $uno(@temp){
$uno=~s/$parte1/$parte2/i;
print "$uno, ";
}
#hacer;
$renf="renameThis.bat";
$undf="undoThis.bat";
open(REN,">$renf") or die "\nCannot Create $renf";
open(UNDO ,">$undf") or die "\ncanot create $undf";

print REN  "\@ECHO OFF\ncd $raiz\nECHO Renaming To $parte2\n";
print UNDO "\@ECHO OFF\ncd $raiz\nECHO Undoing  To $parte1\n";

for $uno(@files){
  $dos=$uno;
  $uno=~s/$parte1/$parte2/i;
  print REN  "echo renaming $dos --> $uno\nrename \"$dos\" \"$uno\" \n";
  print UNDO "echo renaming $uno --> $dos\nrename \"$uno\" \"$dos\" \n";
}
close REN;
close UNDO;

print "\n\n(Para cancelar pulsa Ctrl+C)\n\nPulsa ENTER Para CAMBIAR LOS NOMBRES : ";
$ok=<STDIN>;
chomp($ok);
if($ok eq ""){
system "$raiz\\$renf";
print "\n\n'Hecho $!'\n";

}else{
print "'$ok'";
print "No se ha modificado";
}


sub name(){
return basename(shift);

}

