use LWP::Simple;
$destino="i:/CHISTE_P12";
print "SE GUARDAN EN $destino\n";
if (! -e $destino){mkdir ($destino,700);}
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$ye=$year+1900;
$mo=$mon+1;
$mo=(length($mo)==1)?"0$mo":$mo;
$da=$mday;
$da=(length($da)==1)?"0$da":$da;
$fecha=$ye.$mo.$da;
print "$fecha\n";

my %URLS=(
"PazyRudi","http://www.pagina12web.com.ar/fotos/$fecha/rudypaz/NA01DI01.GIF",
"Rep",     "http://www.pagina12web.com.ar/fotos/$fecha/rep/NA28DI01.GIF",
"Rep-",     "http://www.pagina12web.com.ar/fotos/$fecha/rep/NA32DI01.GIF",
"Fontanarrosa","http://www.clarin.com/diario/$ye/$mo/$da/fontanarrosatira.gif",
"Matias","http://www.clarin.com/diario/$ye/$mo/$da/matiastira.gif",
"Diogenes","http://www.clarin.com/diario/$ye/$mo/$da/diogenestira.gif",
"Clemente","http://www.clarin.com/diario/$ye/$mo/$da/clementetira.gif",
#"CronicaDiaria","http://www.clarin.com/diario/hoy/cronicatira.gif",
#"Crist","http://www.clarin.com/diario/hoy/cristtira.gif"
);


$f="$mday-".($mon+1)."-".($year+1900);
$conerror=0;$vez=0;
do{
	foreach $k(keys(%URLS)){
		$name="$k\_$f.gif";
		print "$k...";
		if (-e "$destino/$name"){
			print "Ya Existe\n";
			next;
		}
		$imagen=get($URLS{$k});
		if (!$imagen){
			print "ERROR\n$URLS{$k} : $!\n";
			$conerror++;
		}else{
			open (IMA,">$destino/$name") or die "ERRO OPEN:$!\n";
			binmode (IMA);
			print IMA $imagen;
			close IMA;
			print "Ok\n";
		}
	}
#	if($conerror>1){
#		print "Deseas repetir para bajar las -$conerror- imagenes fallidas [s/n]? : ";
#		$r=<>;
#		chomp($r);
#		if($r eq 's' || $r eq 'S'){$repetir=1;}
#	}
	if($conerror>1){
		$repetir=1;
		$vez++;	
		
	}
	if($vez==3){
		last;
	}
}while($repetir);