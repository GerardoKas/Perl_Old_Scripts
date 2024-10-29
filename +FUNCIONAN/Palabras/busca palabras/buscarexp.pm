#BUSCAR CADENA EN ARCHIVO
#DEVUELVE SEGUNB FORMATO ESPECIFICADO
#
#OJO SOLO BUSCA LINEA PORLINEA
##############################
$debug=1;
sub probar{
$ark="E:/PERL_SAMBAR/sambar44/cgi-bin/NEWbd/GETFORM.pl";
#EN ESTAS DOS TIENE QUE HABER COMILLAS SIMPLES PARA QUE NO LO EVALUE ANTES DE TIEMPO
$cadena='\s*sub\s(\w+)\s*\(*\)*\s*\{*';
$formato='SUB: $1\n';
($debug)?print "FORMATO: $formato\n":0;
printrexp($ark,$cadena,$formato);
}

###################################################################################################################
sub findall{
#BUSCA EN TODO EL FICHERO A LA VEZ
    my($file,$cadena,$formato)=@_;
    my($numline,$total);
    $numline=1;$total=0;
    unless(open(FILE,"<$file")){
        print("NO SE PUEDE ABRIR *$file*\n");
        return 0;
    }
    @lines=<FILE>;
    $fichero=join("",@lines);
    ($debug)?print "PREPARADO PARA LEER $file\n":0;
    while($fichero=~/$cadena/mig){
            #AHORA SE DEBE EVALUAR PARA MOSTRAR $1,$2...
            #AL MISMO TIEMPO LO IMPRIME
            eval("print \"$numline: ".$formato."\"");
            $total++;
            #########################################
    }  
    
       
    print "TOTAL: $total\n";
    close FILE;

}
###################################################################################################################
sub printrexp{
#BUSCA LINEA POR LINEA;
    my($file,$cadena,$formato)=@_;
    my($numline,$total);
    $numline=1;$total=0;
    unless(open(FILE,"<$file")){
        print("NO SE PUEDE ABRIR *$file*\n");
        return 0;
    }
    
    ($debug)?print "PREPARADO PARA LEER $file\n":0;
    while($line=<FILE>){
        #($debug)?print "LINEA $numline\n":0;
        while($line=~/$cadena/mig){
            #AHORA SE DEBE EVALUAR PARA MOSTRAR $1,$2...
            #AL MISMO TIEMPO LO IMPRIME
            eval("print \"$numline: ".$formato."\"");
            $total++;
            #########################################
        }  
    $numline++;
    }   
    print "TOTAL: $total\n";
    close FILE;

}
#########################################################################################################
sub buscarexp{
#AUN NO FUNCIONA
    my($file,$cadena,$formato)=@_;
    my($numline,$res);
    $numline=1;
    unless(open(FILE,"<$file")){
        print("NO SE PUEDE ABRIR *$file*\n");
        return 0;
    }
    
    ($debug)?print "PREPARADO PARA LEER $file\n":0;
    while($line=<FILE>){
        #($debug)?print "LINEA $numline\n":0;
        if($line=~/$cadena/){
            #AHORA SE DEBE EVALUAR PARA MOSTRAR $1,$2...
            #AL MISMO TIEMPO LO IMPRIME
            $res=eval($formato);
            print $res;
            #########################################
        }  
    $numline++;
    }    
    close FILE;
return $res;
}
1;