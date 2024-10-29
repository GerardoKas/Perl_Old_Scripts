package leedirs;

my %CLAVES=();

####USAXE:#####
#$esto= &getposdir("JAVASCRIPT");
#print $esto;
###############
#Aca no hay que ponerles los parentesis!!!!!
sub leedirs::getvalue{
	my ($key)=@_;
&claves();
return $CLAVES{$key};
}

sub claves(){
	open (FILE,"folders.dat") or print "LEEDIRS::NO SE ENCUENTRA /folders.dat";
	@LINEAS=<FILE>;
	chop(@LINEAS);
	#print @LINEAS;
	foreach $item(@LINEAS){
	  ($nombre,$valor)=split("=",$item);
	  $CLAVES{$nombre}=$valor;
	  #print $CLAVES{$nombre};
	}
	#print "HECHO";
}

1