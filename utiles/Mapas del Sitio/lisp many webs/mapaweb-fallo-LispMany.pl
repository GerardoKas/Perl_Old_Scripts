use File::Find;
use File::Basename;
use HTML::HeadParser;
my $antesbarras=$countbarras=$cwd=~s|/|/|g;
my $space=0;
$raiz=shift @ARGV;
open(SAVE,">$raiz/MapaWebUL-T.html") or die "ERROR SAV E:$!";
select(SAVE);
print <<END;
<style>
LI{text-indent:10px;width:640px;}
.File{font-family:arial;background-color:cyan;font-size:small}
.Bin{background-color:gray;font-family:terminal}
.Head{list-style-type:circle}
</style>
END

find(\&mostrar, $raiz);
close SAVE;
sub mostrar{
	$fname=$File::Find::name;
	if(-d $_ && $_ ne "miniaturas"){
		if($#binaries>0){
		print sp(1)."<li class=Bin>\n\t".join(",\n\t",@binaries)."\n</li>\n";
		@binaries=();
		}
		print STDOUT "$_\n";
		$countbarras=$File::Find::name=~s|/|/|g;
		$space=$countbarras;
		if ($countbarras>$antesbarras){
			print sp()."<UL>\n";
		}elsif($countbarras<$antesbarras){
			for($countbarras..$antesbarras){
			print sp()."</UL>\n";
			}
		}
		print sp()."<li class=Head>$_ (<a href=\"$File::Find::name\">+</a>)</li>\n";

	}elsif($_=~/html?$/i){
		$cabecera=leercabecera($_);
		$p = HTML::HeadParser->new;
	 	$p->parse($cabecera);
	 	$titulo=$p->header('Title');   
	 	if($titulo eq ""){$titulo=$_;}
		print sp(1)."<li><a href=\"$File::Find::name\" title=\"$_\">$titulo</a></li>\n";
	}elsif(-T $_ && $_!~/\.css$/i){
		print sp(1)."<li class=File><a href=\"$File::Find::name\">$_</a></li>\n";
	}elsif(-B $_ && $_!~/\.(gif|jpe?g|png|bmp|pcx)$/i){
		push(@binaries,$_);
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
sub sp{
$i=shift;
if($i){
return " "x($space+2);
}else{
return " "x$space;
}
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