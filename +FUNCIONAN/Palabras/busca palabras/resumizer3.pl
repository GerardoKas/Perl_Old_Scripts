use atopa;
my(%etiq);
my(%pals);
#$dir="J:/INET31-10-01/viabilidad";
#$dir="F:/LENGUAJES_565Mb/_Internet/W_Perl/CGI/faq";
$dir="E:\\_DISCOS\\ALL WEB\\Argentina\\p12";
$sep="\n<br>";
$formato="#DIR#/#NOM#.#EXT#$sep";
$extensiones="html htm asp php";
$debug=0;
$\="<br>";
$|=1;
$encontrados=Busca($dir,$formato,$extensiones);
print "".$encontrados;

@htms=split("$sep",$encontrados);
print "NUMERO DE ARCHIVOS: $#htms\n";

foreach $uno(@htms){
    
    $pointer=&lee($uno);
    solotexto($pointer);
    frases($pointer);
    #last;
}
($debug)?print "IMPRIMIENDO\n":0;
foreach $key(sort keys %pals){
    if($pals{$key} > 0 && $pals{$key} < 3){
    print "$key=$pals{$key}\n";
    $num+=1;    
    }
}
print "\nNUMERO DE ENCONTRADAS ESTRUCTURAS: $num";
exit;

#MUESTRA LAS ETIQUETAS HTML y el numer ode veces    que aparecen    
foreach $uno(@htms){
    $pointer=&lee($uno);
    #print $$pointer;
    etiquetas($pointer);   
}
foreach $key(sort(keys %etiq)){
          print "$key=$etiq{$key}\n";
    }
exit;
###############################################

#MUESTRA LOS HEADINGS DE HTM <h1..6>
foreach $uno(@htms){
    $pointer=&lee($uno);
    
    $tits=&traducetitulos($pointer);
    
    if (@$tits){
        $titulos=join("<br>\n",@$tits);
    print "\n\nFILE: $uno<br>\n";    
    print $titulos;
    }
    #exit;
}
print "\nTERMINADO\n";

sub lee(){
    my($file)=@_;
    open(HTM,"<$file") or die "\nNO SE PUEDE ABRIR $file\n";
    @lines=<HTM>;
    close HTM;
    $line=join("\n",@lines);
    return \$line;    
}
sub traducetitulos(){
    my($pointexto)=@_;
    @titulos=();
    $tex=$$pointexto;
    while($tex=~/<h\d>([^<]+)<\/h(\d)>/gmi){
    #print "==$1==";
    push(@titulos,"H$2-$1");
}
    return \@titulos;
    
}

###################################3

sub etiquetas{
    my($pointexto)=@_;
    $tex=$$pointexto;
    
    while($tex=~/<(([\w\d]+) [^\\>]+)>/gi){
        #print "$1\n";
        $esta=uc($2);
        $etiq{$esta}+=1;
    }
    #return \%etiq;
}

sub frases{
    my($pointex)=@_;
    #este valor de split:/[\W]+/ pasaría por alto los acentos, que no son palabras para el perl ingles;
    #crea dibujos con lso epspacios /[:;,!"\.\(\)\/\?\n]+/
    ($debug)?print "REDUCIENDO ESPACIOS\n":0;
    $$pointex=~s/[\s]+/ /g;
    ($debug)?print "BUSCANDO FRASES\n":0;
    @palabras=split(/[:;,!\"\.\(\)\t]+/,$$pointex);
    ($debug)?print "QUITANDO ESPACIO INICIAL\n":0;    
    grep(s/^ //,@palabras);
    ($debug)?print "CONTANDO REPETICIONES\n":0;
    foreach $una(@palabras){
        #print "$una\n";
        $lcase=lc($una);
        if($una!~/^\d+$/){
        $pals{$una}+=1;       
        } 
    }
        
}
sub solotexto{
    my($pointex)=@_;
    ($debug)?print "TRADUCIENDO SOLO TEXTO\n":0;
    $$pointex=~s/<br>/\n/gi;
    $$pointex=~s/<[^>]+>/ /g;
    #print $$pointex;
    #return $pointex;


}
