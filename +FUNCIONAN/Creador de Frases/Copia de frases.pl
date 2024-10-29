my $SUJ=['el niño','la abuela','un coche rojo','el sol que no sale','la tela de araña'];
my $VBO=['come de vez en cuando','corre con','se perdió en','detectó'];
my $PRED= ['un coche verde','una casa perdida y muy vieja','las piramides de egipto', 'la esquina dorada'];

$num=4;
$f="\n";
  $f.=$SUJ->[irand($num)];
  $f.=" ".$VBO->[irand($num)];
  $f.=" ".$PRED->[irand($num)];

print $f;
sub irand{
  my $max=shift;
  return int(rand($max));
}

__END__
C:\>perl -w -n c:\frases.pl

la abuela come de vez en cuando las piramides de egipto

la abuela corre con la esquina dorada

el ni±o se perdi¾ en las piramides de egipto

la abuela corre con una casa perdida y muy vieja

la abuela corre con la esquina dorada

la abuela come de vez en cuando la esquina dorada

la abuela corre con las piramides de egipto

el ni±o detect¾ las piramides de egipto

el ni±o corre con las piramides de egipto

el sol que no sale se perdi¾ en una casa perdida y muy vieja

el sol que no sale come de vez en cuando las piramides de egipto

el sol que no sale detect¾ la esquina dorada

un coche rojo come de vez en cuando un coche verde

un coche rojo se perdi¾ en un coche verde

la abuela come de vez en cuando una casa perdida y muy vieja

un coche rojo corre con una casa perdida y muy vieja



