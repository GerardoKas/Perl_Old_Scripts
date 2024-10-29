use BUS202;
use FindText;
#$ENV{'QUERY_STRING'}="ELDIR=F%3A%5Cpaginas%5CAlgoritmos+CURSOS%5CLGOTRITICA%5Cwww.cicei.ulpgc.es%5Cinf_bas%5Cmtutor&EXTES=htm+html+txt&ID=1010326517&PALABRAS=HOLA+MUNDO&REXP=+%5B12%5D%5Cd%5Cd%5Cd+&_cargado=&enviar=BUSCAR";
#PROGRAMA PARA BUSCAR PATRON EN ARCHIVOS DE TEXTOo  HIPERTEXTO
$\="\n";
$|=1;
%data=( 'ELDIR'=>{'desc'=>'Directorio De Busqueda','value'=>'E:\\ESENCIAL\\PERL\\_Referencias\\Perl Quick Reference'},
        'EXTES'=>{'desc'=>'Extensiones','value'=>'htm html txt'},
        'PALABRAS'=>{'desc'=>'Buscar por Palabras','value'=>'','size'=>'30'},
        'REXP'=>{'desc'=>'Buscar por RegExp','value'=>''},
        'enviar'=>{'type'=>'submit','value'=>'BUSCAR'}
      );
#Primero se debe llamar a leer formulario, 

$mbus=BUS->new(%data);
#$mbus->printobjeto();
if($mbus->LeerEntrada()){
#Se han devuelto datos
#$mbus->printobjeto();
LBuscar();
}else{
    $mbus->PeticionDatos();
    exit;
}


######################3######################3######################3######################3
sub LBuscar{
    #$mbus->printobjeto();
    $formato="#DIR#/#NOM#.#EXT#\n";
	$texformat="[#NUMLIN#]  #LINEA#<br>\n";
    $dir=$mbus->valor('ELDIR');
    $extes=$mbus->valor('EXTES');
    $pals=$mbus->valor('PALABRAS');
    $tienen=0;
    print "<h1>PALABERAS A BUSCAR : $pals</h1>";
    use atopa;
    $debug=0;
    $LISTA=Busca($dir,$formato,$extes);
    @items=split('\n',$LISTA);
    print "<h2>Se procede a buscar en $#items ficheros totales</h2>";
    &unscript();
$id=0;
    foreach $fil(@items){
	   %PAL=%{&FindText::PalabrasAND($fil,$pals,$texformat,0)};
      #print %PAL;
      unless(&FindText::Completo(\%PAL)){next;}
      $tienen++;
      print "$tienen<a href=\"$fil\">$fil</a><br>";

      for $i(keys %PAL){
         $id++;
         print "<h2 onclick='chan(\"D$id\")'>$i=$PAL{$i}{'veces'}</h2>";
         print "<div id=D$id style='position:absolute;visibility:hidden;background-color:eeffee'>\n";
         for $j(@{$PAL{$i}{'found'}}){
            print "$j<br>";
         }
         print "</div>";
      }
        
    }
   print "<h2>ENCONTRADO EN $tienen ficheros de $#items</h2>";
}

sub unscript{
print <<END;
<script>
var ant=''
function chan(sobj){

if (ant!=''){
   var xobj=eval('document.all.'+ant+'.style');
   xobj.visibility='hidden'
}
ant=sobj
var obj=eval('document.all.'+sobj+'.style');

obj.top=document.body.scrollTop;
obj.left=200
obj.visibility=(obj.visibility=='hidden')?'visible':'hidden';

}
</script>
END


}