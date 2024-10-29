my $SUJ=['El Mago de Color Verde','La serpiente roja','El camino serpenteante','Mi perro'];
my $VBO=['tiene','estudia','crea','imagina','descubre','olfatea','pinta'];
my $PRED= ['un queso','filosofia','una manzana','el final','la monta鎙'];

$num=4;
$f="\n";
  $f.=$SUJ->[irand(4)];
  $f.=" ".$VBO->[irand(7)];
  $f.=" ".$PRED->[irand(5)];

print $f;
sub irand{
  my $max=shift;
  return int(rand($max));
}

__END__
C:\>perl -w -n c:\frases.pl
Name "main::num" used only once: possible


La serpiente roja descubre la monta帶

El Mago de Color Verde imagina una manzan

El camino serpenteante olfatea un queso

El Mago de Color Verde tiene una manzana

Mi perro pinta el final

El Mago de Color Verde crea una manzana

El camino serpenteante crea el final

Mi perro crea el final

Mi perro imagina filosofia

El camino serpenteante estudia el final

El Mago de Color Verde descubre filosofia

La serpiente roja olfatea la monta帶

El camino serpenteante estudia una manzan

La serpiente roja estudia filosofia

La serpiente roja descubre la monta帶

El camino serpenteante crea la monta帶
