use GCM::titulo;
use busca;
my @extes=qw/html htm txt/;
open(SV,">index.html") or die "ERROR TONO";
select SV;
busca::buscar("E:/_DISCOS",\&procesar,1,@extes);

sub procesar{
$ex=$busca::extension;
$completo=$busca::completo;
print "<a href=\"$completo\">$busca::archivo</a><br>\n";
if($ex=~/html?/i){
  $titulo=GCM::titulo::titulo($completo);
  print "&nbsp;&nbsp;$titulo<br>\n";  
}

}

close SV;








__END__