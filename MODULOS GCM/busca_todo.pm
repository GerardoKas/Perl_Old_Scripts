package busca_todo;
use Exporter;
use File::Find;

=HEAD1 NAME
   busca_todo 
=HEAD1 SINOPSYS
   use busca_todo;
   buscaaqui(\&procesa,"C:/",@extensiones); 
   
   buscatodo(\&procesa,"C:/Mis Documentos",@extensiones);
   
   relativo($archivo,"C:/");
=cut
@ISA=qw(Exporter);
@EXPORT= qw(buscaaqui buscatodo relativo);

my $raiz;local $rextes;
$dir="";$completo="";$extension="";$nombre="";$archivo="";

sub buscaaqui{
   $callback=shift;
   $raiz=shift;
   sextes(@_);
   &estedir;
}
sub buscatodo{
   $callback=shift;
   $raiz=shift;
   sextes(@_);
   #print "EXTES:$rextes\n";exit;
   find(\&recursivo,$raiz);
}

sub sextes{

my @e=map{"($_)"}@_;
$rextes=join("\|",@e);
}
sub relativo{
my ($fn,$path)=@_;
$fn=~s/\\/\//g;
$path=~s/\\/\//g;
if ($path!~/\/$/){
   $path.="/";   
}

$fn=~s/$path//i;
return $fn;
}

####################################################################################
sub recursivo{
if(-d $_){return};
my $dac=$File::Find::dir;
my $name=$_;
return unless (es_ok($name));
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
      if(es_ok($_)){
         $ext=$1;
         ($DEBUG)?print "LLAMANDO\n":0;
         &$callback($raiz,$_,$ext);   
      }
   }
   closedir DR;
}

sub es_ok{
return 1 if ($_=~/\.($rextes)$/i);
}


1;
