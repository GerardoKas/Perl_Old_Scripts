use File::Find;
my $total=0;
my $minimo=0;
$|=1;
$minimo=2;#mb
print "BUSCA FICHEROS USANDO EL MODULO FILE::FIND\n\n";

find(\&Prime,"m:/");
print "\n\n\nENCONTRADOS $total Ficheros";
sub Prime{
	$size=int((-s $File::Find::name)/1024/1024);
	if((-s $File::Find::name)>=$minimo*1024*1024){
   print "$File::Find::name\t$size\Mb<br>\n";
	}
   $total++;
   
}