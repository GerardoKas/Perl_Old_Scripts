my $SUJ=['El caracol amarillo', 'El papa gru�on','Un grano saltar�n','Una mama reghordeta',
  'Una mariposa alocada','Un pantalon de piernas largas','Los lazos de mil colores y las flores preguntonas',
  'Esas hormiguitas flacas y nerviosas'];
my $VBO=['duerme con','pinta','gru�ia a','pens� en','se pregunt� sobre','camin� en',
        'camina salta corre y se cae en','se escondieron acurrucadas dentro de',
        'se enredaron y protestaron mucho por'];
my $PRED= ['la escalera interminable','el techo roto','un peri�dico indescifrable','la nevera llena de quesos',
          'un pozo de mil colores y sonidos','un castillo de chocolate y crema'];

$num=4;
for(1..20){
$f="\n";
  $f.=$SUJ->[irand(8)];
  $f.=" ".$VBO->[irand(9)];
  $f.=" ".$PRED->[irand(6)];

print "$f\n";
}
sub irand{
  my $max=shift;
  return int(rand($max));
}

__END__
C:\>perl -w -n c:\frases.pl

El caracol amarillo pinta la escalera interminable

Una mama reghordeta pinta la nevera llena de quesos

El papa gru�on pens� el techo roto

Una mariposa alocada gru�ia la nevera llena de quesos


El papa gru�on caminan saltan corren y se caen en un peri�dico indescifrable

Los lazos de mil colores y las flores preguntonas caminan saltan corren y se cae
n en un castillo de chocolate y crema

Un grano saltar�n pinta la escalera interminable

Una mariposa alocada caminan saltan corren y se caen en un castillo de chocolate
 y crema

Un pantalon de piernas largas se escondieron acurrucadas dentro de un pozo de mi
l colores y sonidos

Una mariposa alocada se pregunt� sobre un peri�dico indescifrable

Los lazos de mil colores y las flores preguntonas se escondieron acurrucadas den
tro de la nevera llena de quesos

Una mariposa alocada duerme con la nevera llena de quesos

Una mama reghordeta pens� en el techo roto

Una mariposa alocada duerme con un peri�dico indescifrable

Esas hormiguitas flacas y nerviosas se enredaron y protestaron mucho por la esca
lera interminable

Esas hormiguitas flacas y nerviosas se escondieron acurrucadas dentro de un pozo
 de mil colores y sonidos

Un pantalon de piernas largas se enredaron y protestaron mucho por la escalera i
nterminable

Un grano saltar�n pinta un pozo de mil colores y sonidos

Una mama reghordeta se enredaron y protestaron mucho por un pozo de mil colores
y sonidos

Una mariposa alocada duerme con la escalera interminable

Un grano saltar�n pinta la escalera interminable

Esas hormiguitas flacas y nerviosas se enredaron y protestaron mucho por el tech
o roto

El caracol amarillo gru�ia a un castillo de chocolate y crema

Una mama reghordeta pens� en la nevera llena de quesos

Un pantalon de piernas largas se enredaron y protestaron mucho por la escalera i
nterminable

El papa gru�on se pregunt� sobre un peri�dico indescifrable

Una mariposa alocada duerme con un pozo de mil colores y sonidos

Una mariposa alocada duerme con la escalera interminable

Los lazos de mil colores y las flores preguntonas se pregunt� sobre un peri�dico
 indescifrable

Los lazos de mil colores y las flores preguntonas duerme con un pozo de mil colo
res y sonidos

Un grano saltar�n pinta un pozo de mil colores y sonidos

El papa gru�on se pregunt� sobre un pozo de mil colores y sonidos

Un grano saltar�n se enredaron y protestaron mucho por el techo roto

Esas hormiguitas flacas y nerviosas se enredaron y protestaron mucho por un peri
�dico indescifrable

El caracol amarillo se enredaron y protestaron mucho por el techo roto

Un grano saltar�n se pregunt� sobre la nevera llena de quesos

Esas hormiguitas flacas y nerviosas se pregunt� sobre la escalera interminable

Un pantalon de piernas largas se pregunt� sobre la nevera llena de quesos

El caracol amarillo se pregunt� sobre un pozo de mil colores y sonidos

El papa gru�on se pregunt� sobre el techo roto

El caracol amarillo se escondieron acurrucadas dentro de la nevera llena de ques
os

Una mariposa alocada se pregunt� sobre la nevera llena de quesos

Una mariposa alocada se escondieron acurrucadas dentro de un peri�dico indescifr
able

Un grano saltar�n duerme con la escalera interminable

Esas hormiguitas flacas y nerviosas pinta la escalera interminable

El papa gru�on se pregunt� sobre la escalera interminable

Una mariposa alocada se enredaron y protestaron mucho por la nevera llena de que
sos

Una mariposa alocada duerme con la nevera llena de quesos

El papa gru�on se escondieron acurrucadas dentro de la nevera llena de quesos

Los lazos de mil colores y las flores preguntonas se escondieron acurrucadas den
tro de la nevera llena de quesos

El caracol amarillo pens� en un peri�dico indescifrable

Una mama reghordeta gru�ia a la escalera interminable

Un pantalon de piernas largas gru�ia a la nevera llena de quesos
