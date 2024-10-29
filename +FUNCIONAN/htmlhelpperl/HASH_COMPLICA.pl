use Data::Dumper;
my @a=qw(uno dos tres cuatro);

my $temp={};
$t="\$temp";
foreach(@a){
  $t.="->{$_}";
}
eval("$t='FINAL'");
if ($@){
   print "HA HABIDO UN ERROR EN LA CADENA\nESTA ES\n$t\n\n";
   
   ;

use Data::Dumper;
print Dumper $temp;

