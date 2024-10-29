use File::Find;
use File::Basename;
use HTML::HeadParser;
my $antesbarras=1,$countbarras=1;
$raiz=".";
open(SAVE,">MapaWeb.html") or die "ERROR SAV E:$!";
select(SAVE);
find(\&mostrar, $raiz);
close SAVE;
sub mostrar{
	if(-d $_ && $_ ne "miniaturas"){
		print STDOUT "$_\n";
		$countbarras=$File::Find::name=~s|/|/|g;
		if ($countbarras>$antesbarras){
			print "<blockquote>\n";
		}elsif($countbarras<$antesbarras){
			print "</blockquote>\n";
		}
		print "<h$countbarras>$_</h$countbarras>\n";

	}elsif($_=~/html?$/i){
		$cabecera=leercabecera($_);
		$p = HTML::HeadParser->new;
	 	$p->parse($cabecera);
	 	$titulo=$p->header('Title');   
		print "\t<a href=\"$File::Find::name\">$titulo</a><br>\n";
	}else{
		#print "*$File::Find::name\n";
	}
	$antesbarras=$countbarras;
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