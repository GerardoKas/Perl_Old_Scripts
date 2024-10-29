=HEAD1 USO
Contar Palabras Distibntas (de nuevo)

=HEAD1 SEUDOCODIGO
#%PALABRAS={'palabra'=>(numveces,archivo,linea)};
my %palabras=();
$file=abrir
while($line de $file){
	@palabras=dividir($line);
	foreach(@pal){
		$palabras[$_]++;
	}
}
=cut
my %palabras=();
my @files=();
while($fname=shift @ARGV){
print "\n$fname\n";
push(@files,$fname);
open(FILE,"<$fname") or die "ERROR TONOTOT";
while($l=<FILE>){
	@pal=split(/[\s\.,\)\(\"!¡\?¿\-_:\[\]]+/,$l);
	foreach(@pal){
		$palabras{lc($_)}++;
	}
}
close FILE;
}
open(SV,">c:/perl/utiles/Cuantas_Palabras.txt") or die "ERRRO R SABVING";
print SV @files;
foreach $key(sort {$palabras{$a} <=> $palabras{$b}}keys(%palabras)){
	if($palabras{$key}==1){
		print SV "$key\t";
	}else{
	print SV "\n$key=$palabras{$key}";	
	}
}
close SV;