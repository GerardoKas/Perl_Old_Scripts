package busca;
use File::Find;
my $raiz,$rextes,$callback;
=head1 NAME

busca - Busca archivos por extension en un directorio
=head1 SYNOPSIS

C<busca($dir,\&callback, $recursivo,@extensiones);>

=cut

$dir="";$completo="";$extension="";$nombre="";$archivo="";

sub buscar{
my ($dir,$subrutina,$recorrer,@extes)=@_;
$raiz=$dir;
$callback=$subrutina;
@e=map{"($_)"}@extes;
$rextes=join("\|",@e);
print "EXTES; $rextes\n";
if ($recorrer){
File::Find::find(\&recursivo,$raiz);   
}else{
estedir();
}
}
####################################################################################
sub recursivo{
if(-d $_){return};
my $dac=$File::Find::dir;
my $name=$_;
return unless ($name=~/($rextes)/i);
my $e=$1;
$extension=$e;
$dir=$dac;
$completo="$dac/$name";
$archivo=$name;
$name=~s/($rextes)//i;
$nombre=$name;
&$callback($completo);   
}
####################################################################################
sub estedir{
   ($DEBUG)?print "BUSCANDO AQUI SOLO\n":0;
   opendir(DR,$raiz) or die "NO SEP UE ABIR $raiz\n";
   
   while($_=readdir(DR)){
      if($_=~/^\./){next}
      if($_=~/($rextes)/i){
         $ext=$1;
         ($DEBUG)?print "LLAMANDO\n":0;
         &$callback($raiz,$_,$ext);   
      }
   }
   
   closedir DR;
}



1;