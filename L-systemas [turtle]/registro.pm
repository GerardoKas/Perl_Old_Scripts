use Win32API::Registry qw(:ALL);

sub test{
$laclave="Software\\MiPrograma\\Dato";
$entrada="MiPrograma";
$valor="Esto es un dato binario";
print "Creando clave $laclave con $entrada=$valor\n";
crear($laclave,$entrada,$valor);
print "Ahora leyendo la entrada $entrada\n";
$cadena=cargar($laclave,$entrada);
print "Contiene el dato: $cadena";
}

sub cargarclave{
   my ($cKey,$nEntrada)=@_;
   RegOpenKeyEx( HKEY_LOCAL_MACHINE, $cKey, 0, KEY_READ, $key )  or  do{print "NO EXISTE LA CLAVE $cKey : $^E\n";return "";}  ;
   RegQueryValueEx( $key, $nEntrada, [], $type, $dato, [] )  or  do{print "NO SE PUE LEER LA CLAVE  $cKey ERRO: $^E\n";return;}; 
   RegCloseKey( $key )    or  die "Can't close $ckey: $^E\n";
   print "CARGADA $cKey=$nEntrada\n";
return $dato;
}

sub crearclave{
   my ($sSubKey,$sName,$pData)=@_;
   
   RegCreateKeyEx( HKEY_LOCAL_MACHINE, $sSubKey, 0, "", 0, KEY_WRITE, [], $ohNewKey,[]) or do{print "ERROR CREATE CLAVE $^E\n"};
   RegSetValueEx( $ohNewKey, $sName, $uZero, REG_BINARY, $pData, 0 ) or do{print "ERROR SE VALIUE: $^E\n";};
print "CREADA $sSubKey\@$sName=$pData\n";
}

1;