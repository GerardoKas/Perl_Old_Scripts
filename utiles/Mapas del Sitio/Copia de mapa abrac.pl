use File::Find;
use File::Basename;
use HTML::HeadParser;
$raiz=".";
find(\&mostrar, $raiz);

sub mostrar{
	if(-d $_ && $_ ne "miniaturas"){
		if($File::Find::name=~m|^$raiz/$_|i){
			print "Dentro de $raiz <blockquote>";

		}else{
			print "</blockquote>";
		}
		print "<h2>>$File::Find::name :: $_</h2>\n";
		$raiz=$File::Find::name;
	}elsif($_=~/html$/i){
		$cabecera=leercabecera($_);
		$p = HTML::HeadParser->new;
	 	$p->parse($cabecera);
	 	$titulo=$p->header('Title');   
		print "\t<a href=\"$File::Find::name\">$titulo</a><br>\n";
	}else{
		#print "*$File::Find::name\n";
	}
}

sub leercabecera{
	my $fichero=shift;
	my $cab="";
	open(FILE,"<$fichero") or die ("\nNo se pudo leer!\n$fichero\n");
	for($i=0;$i<30;$i++){
		$cab.=<FILE>;
	}
	return $cab;
}

__END__
primer dir
name : C:/primera/segunda
dir : c:/primera/
file : segunda

segundo dir
name : C:/primera/segunda/tercera
dir : c:/primera/segunda/
file : tercera