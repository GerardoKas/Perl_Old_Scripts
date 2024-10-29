#LEE FORMULARIO Y GENERA FORMULARIO A PARTIR DE CAMPOS DEFINIDOS
package BUS;

sub new{
    my($class)=shift;#Esto devuelve el nombre con que se llamo al metodo (BUS->new())
    print "*$class*";
    my $este={};
    my %rCampos=@_;
    print $class->{'_cargado'}."<br>";
    foreach $k(keys %rCampos){
    $este->{$k}=$rCampos{$k};
    }
    if(!$ENV{'QUERY_STRING'}){
        print "INICIO PRIMERO";
        #$este->{'_cargado'}=0;
        $este->{'ID'}={'value'=>time(),'type'=>'hidden'};

        
    }else{
        print "A PUNTO DE PROCESAR";
        #avisar que se debe procesar datos
        #$este->{'_cargado'}=1;
        #Leer el formulario y meterlo en fichas;
    }
    bless($este,$class);
    return $este;
}

sub valor{
    my($class)=shift;
    $cam=shift;
    print "*PET::$cam=$class->{$cam}{'value'}*";
    return $class->{$cam}{'value'};

}
sub printobjeto{
    my $class=shift;
    %o=%$class;

    foreach $k(keys %o){
    print "<b>$k</b>=<U> $o{$k} &nbsp;&nbsp;</u>";
        %cam=%{$o{$k}};
        
        foreach $sub(keys %cam){
            print "&nbsp;&nbsp;&nbsp;&nbsp;$sub==$cam{$sub}";
        }
        
    
    }

}

sub Cargado{
    my $this=shift;
    if ($this->{'_cargado'}){return 1;}
    print "NO HAN LLEGADO DATOS DE ENTRADA";
    return 0;
}
sub LeerEntrada{
    my($class)=shift;
    my ($cadena)=$ENV{'QUERY_STRING'};
    if ($cadena eq ''){return 0;}
  @line=split(/&/,$cadena);
  foreach $valor(@line){
          ($nombre,$val)=split(/=/,$valor);
          $val=~tr/+/ /;
          $val=~s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/eg;
          $class->{$nombre}{'value'}=$val;
  }
  return 1;
}
######################3######################3######################3######################3
sub PeticionDatos{
    my($class)=shift;
    my(%cp,$cadena);
    %cp=%$class;
    $cadena="<form method=get>\n";
    foreach $key(sort(keys %cp)){
        #print "$key=$cp{$key}\n";
        %uno=%{$cp{$key}};
    $s=($s=$uno{'size'})?'size='.$s:'';
    $t=($t=$uno{'type'})?'type='.$t:'type=text';
        $cadena.= "$uno{'desc'}<input name=$key $t $s value=\"$uno{'value'}\"><br>\n";
    }
    $cadena.="\n</form><br>";
   print $cadena;
}

##############################################################################
#sub combinar{
##Mete los datos del formulario en un hash de campos definidos
#    my($df,$ff)=@_;
#    my(%data,%form);
#    %data=%$df;
#    %form=%$ff;
#    for $k (keys %data){
#        $valor='';
##print "TODOS-$k=$data{$k}{'value'}\n";
#
#        if($valor=$form{$k}){
#        #print "EN FORM: $k=$valor\n";
#        #print "EN DATA: $data{$k}{'value'}";#="PUESTO";#$valor;
#        $data{$k}{'value'}=$valor;
#
#        }
#    }
#}

1;
