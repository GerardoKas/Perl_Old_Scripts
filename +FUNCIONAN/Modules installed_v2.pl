use Extutils::Installed;
$ins=ExtUtils::Installed->new();
open(SAVE,">d:\modulos_Instalados.txt") or die "Erro escritura";
print "Searching...\n";
select(SAVE);
foreach $mod(sort($ins->modules())){
	print "+".$mod."\n";
	if($missing=$ins->validate($mod)){
		print "! -> Faltan: ".$missing;
	}
	foreach $file(sort($ins->files($mod))){
		print "\t$file\n";
	}
}
select (STDOUT);
close SAVE;
print "Done\n";