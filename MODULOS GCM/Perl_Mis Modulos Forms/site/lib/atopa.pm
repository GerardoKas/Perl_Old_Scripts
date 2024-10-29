#El programa buasca los archivos y los concatena en un string segun el formato especificado
#EJEMPLO DE USO@
# $tex= Busca ("E:\\_OCTUBRE\\LIBRO_ARQUIT_Ð_ORDS_",
#            "-#ID#--->#DIR#/#NOM#.#EXT# - Tamaño=#SIZE#, #DATE#\n",$extensiones);
# print $tex;
##FIN DE EJEMPLO#
$debug=1;
#VARIABLES QUE SE DEBENE MANTENER AUN QUE SE CAMBIE DE RUTINA RECURSIVA
my(@LINEAS,$RESULTADO,$formato,$exts,$total);
$total=0;

sub Busca{
    my($dirinicial,$fmt,$extensiones)=@_;
    ($debug)?print "INICIANDO ATOPA.PM\n":0;
    $RESULTADO="";
    $formato=$fmt;
    @extes=split(" ",$extensiones);
    #$exts="\.pl|\.pm";
    for ($i=0;$i<=$#extes;$i++){
        $extes[$i]="\\.".$extes[$i];
    }
    $exts=join('|',@extes);
    #$dirinicial=corrigedir($dirinicial);    

    ($debug)?print"DIRINICIO:$dirinicial\nFORMATO:$formato\nEXTENSIONES:$exts\n\n":0;

    &Mostrardir($dirinicial);
    ($debug)?print"\nTERMINADO PROCESO EN MODULO ATOPA\n\n":0;
    return $RESULTADO;
}

sub Mostrardir {
    #@items los archivos todos a barullo
    #@DIRS LOS DIRECTORIOS PARA LLAMAR AL FINAL Y CONTINUAR BUSCANDO
	my($dir)=@_;
    my (@files,@DIRS,@items,@LINEAS);
    @LINEAS=();
    @items=();
	
	    
	
	if(!-e $dir) {
	    print "ERROR: NO EXISTE $dir\n";
	print "Elige otro directorio, porque <i>$dir</i> no es un directorio";    
    #$RESULTADO.="EL DIRECTORIO $dir NO EXISTE \n PRUEBA CON C:\\." ;
        return;
    }
	if(!(-r $dir)){
		print "ERROR::::NO SE PUEDE LEER $dir\n";
		return;

	}
    ($debug)?print"ENTRANDO EN DIR:$dir\n":0;
    opendir(ELDIR,$dir) or die "ERROR AL ABRIR $dir AUNQUE EXISTE\n";
    $dir=~s/[\/\\]$//;
	@files=readdir(ELDIR);
	($debug)?print "ARCHIVOS TOTALES:$#files":0;
	#($debug)?print(@files):0;
	($debug)?print"\n":0;
	close ELDIR;
    foreach $file(@files){
			$cfile="$dir/$file";
#DIRECTORIO->
			if (-d $cfile){
				if ($file!~/\.\.?/){push(@DIRS,$cfile);}
#FICHERO
            }else{
	            if($file=~/(?:$exts)$/i){push(@items,$file);}
			}
#FIN DE IF      
    }
#FIN DE FOR
	#sacarle la ultima barra;

#AHORA SE SELECCIOPNAN LOS QUE COINCIDEN EN EXTENSION
	@items=sort(@items);
	foreach $it(@items){
	    $cadena=$formato;                         
        $it=~/(.+)\.(.{1,10}$)/i;
        $nombre=$1;
        $ext=$2;
        $fecha=Fecha("$dir/$it");
        $tamano=(-s "$dir/$it");  
        $tamano=&convertir($tamano);          
        $cadena=~s/#DIR#/$dir/g;
        $cadena=~s/#FILE#/$it/g;
        $cadena=~s/#EXT#/$ext/g;
        $cadena=~s/#NOM#/$nombre/g;  
        $cadena=~s/#ID#/$total/g; 
        $cadena=~s/#SIZE#/$tamano/g;
        $cadena=~s/#DATE#/$fecha/g;
    	push(@LINEAS,$cadena );
    	($debug && $total==0)?print "FOUND->$cadena\n":0;
    	$total++;
			
    }
    ($debug)?print "ARCHIVOS BUSCADOS:$#LINEAS":0;
$estedir=join("",@LINEAS);
$RESULTADO.= $estedir;
	foreach $undir(@DIRS){
	    #Recursivo
	    &Mostrardir($undir);
	}


}   
sub convertir(){
    my($tam)=@_;
    if($tam>1024){
        $tam=int($tam/1024);
        if($tam>1024){
        $tam=int($tam/1024);
        $tam.=" Mb";
        }else{
        $tam.=" Kb";  
        } 
    }else{
        $tam.=" Bytes";
    }
    return $tam;
}
sub Fecha{
    my($file)=@_;
    @stat=stat($file);
    $fecha=$stat[9];
    ($sec,$min,$hora,$dia,$mes,$ano)=localtime($fecha);
    $mes++;
    $ano+=1900;
    return "$dia/$mes/$ano $hora:$min:$sec";
}
########################################################################################
sub corrigedir{
    my($d)=@_;
    $d=~s|\\+|/|g; #Se cambian \ por /(para internet)
    if(-f $d){
    $d=~s|(/[^/]+)$||;    #Se elimina el nombre de archivo si lo hay    
    }
    #$d=~s|/$||;    #Se elimina la ultima barra si la hay
    return $d;
}
########################################################################################

1;