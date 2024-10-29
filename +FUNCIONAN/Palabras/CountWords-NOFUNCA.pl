=HEAD1 USO
Contar Palabras Distibntas (de nuevo)

=HEAD1 SEUDOCODIGO
#%PALABRAS={'palabra'=>(numveces,archivo,linea)};
my %palabras=();
$file=abrir
while($line de $file){
	@palabras=dividir($line);
	foreach(@palabras){
		%palabras[$_]++;
	}
}
=cut

$fname=shift @ARGV;
print "\n$fname\n";
my %palabras=('uno'=>10);
open(FILE,"<$fname") or die "ERROR TONOTOT";
while($l=<FILE>){
	@pal=split("[ .,\?¿¡\!\"]+?",$l);
	foreach(@pal){
		print "$_\n";
		
	}	
}
close FILE;