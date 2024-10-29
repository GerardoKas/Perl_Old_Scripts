my $NAMES=[
            ["niño", "s", "m"],
            ["abuela", "s", "f"],
            ["coche rojo", "s", "m"],
            ["tela de araña", "s", "f"],
            ["mariposas saltarinas", "p", "f"],
            ["Magos Multicolor","p","m"]
          ];
my $VBOS=[ ['come', 'comen'],  
            ['corre sobre','corren sobre']
            ];
my $ATRIBS=['vieja','interesante','perdida','colorado']        ;
my $CC=['de vez en cuando','','ultimamente','cuando puede','cuando llueve'];
my $ARTS=['un una unos unas','el ella ellos ellas','este esta estos estas','aquel aquella aquellos aquellas'];
for (1..10){
   my $c;
   print nombre(\$c);
   print verbo($c);
   
   #print cc();
   print nombre();
   print "\n";
   
}

sub nombre{
   my $var=shift;
$n=$NAMES->[irand(6)];
$nome=$n->[0];
$g=$n->[2];
$c=$n->[1];

$art=$ARTS->[irand(3)];
#print "-$c-";
$$var=$c;
if($g eq 'f'){
 if($c eq 'p'){$i=3}else{$i=1;}
}else{
 if($c eq 'p'){$i=2}else{$i=0;}
}
@rt=split(" ",$art);

$art_n=$rt[$i];

return "$art_n $nome ";
}
sub verbo{
my $c=shift;
if($c eq "p"){
return $VBOS->[irand(2)][1]." ";
}else{
return $VBOS->[irand(2)][0]." ";
}
}

sub cc{
return $CC->[irand(4)]." ";
}
sub irand{
   my $max=shift;
   return int(rand($max));
}