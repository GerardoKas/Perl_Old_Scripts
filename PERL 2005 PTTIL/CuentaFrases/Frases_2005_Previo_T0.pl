@SUJETO=
            qw(perro gato araña raton pez pollo cocodrilo cerdo minotauro grifo centauro unicornio toro_alado
            cura carpintero leñador librero camarero camionero limpiacristales medico filosofo cientifico detective primitivo futurista indio
);
@ACCION=qw(come jiña mea lava_los_dientes_a ducha_a viste_a lee escribe piensa mira oye estudia aprende toma ara recoge hace sube talla);
@OBJETO=
  qw(televisor coche telefono calculadora reloj telar arado yugo hoz saco piedra pava botella vaso libro silla vino patata pitillo ordenador impresora Bomba_H lapiz cuchillo lamparita vela fuego atomo gafas
  bananas peras tomates huevos pollo
);
@LUGAR=qw(campo retrete copaArbol estadio interior_coche biblioteca armario_oscuro salon_con_luz playa chiquero establo dormitorio parque nubes puerto concierto iglesia escuela);
#$ADJETIVo
rand(time());
for($i=0;$i<24;$i++){
$nSuj=int($#SUJETO * rand()+1);
$nAcc=int($#ACCION * rand()+1);
$nObj=int($#OBJETO * rand()+1);
$nLug=int($#LUGAR  * rand()+1);
print "SUJETO:".$SUJETO[$nSuj];
print " HACE:".$ACCION[$nAcc];
#print " A_UN:".$OBJETO[$nObj];
print " EN:".$LUGAR[$nLug];
print "\n\n";
}

