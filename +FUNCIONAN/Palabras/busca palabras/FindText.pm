package FindText;
$debug=0;
#sub LeerRexp{
#    my($archivo,$rexp,$imprimir)=@_;
#    my($tot)=0;
#    open(LEE,"<$archivo") || print "ERROR TONTO - LEEPALABRAS ($archivo)";
#    print "<h2>$archivo</h2>";
#    while(<LEE>){
#    if ($_=~/$rexp/){
#        $tot++;
#        print "<span style)='bgcolor:black;color:white'>$_</span>";
#    }
#    }
#    close(LEE);
#    print "Total Encontrados=$tot";
#}
sub LeerPalabras{
    my($archivo,$palabras,$formato,$imprimir)=@_;
	($debug)?print "SUB->LEERPALABRAS\n":0;
	(!$formato)?$formato="LIN:#NUMLIN#;FOUND:#LINEA#":0;
    my(@palas)=split(' ',$palabras);
    my($RESULTADO,$RESLIN,$lin,$tot,$hay);
    $tot=$lin=$hay=0;
    $RESULTADO="";
   #my $repal='([^\s]+)';

    
    open(LEE,"<$archivo") || print "ERROR TONTO-file($archivo)-LEEPALABRAS ";
    $p=join('|',split(' ',$palabras));

    while(<LEE>){
      $_=&ParseLine($_);
      if ($_=~/ ($p) /i){
      $_=~s/($p)/<b>$1<\/b>/gi;
      $RESLIN=$formato;
      $RESLIN=~s/#NUMLIN#/$lin/g;
      $RESLIN=~s/#LINEA#/$_/g;
      $RESULTADO.=$RESLIN;
        $tot++;
        ($imprimir)?print $RESLIN:0;
      }
      $lin++;
    }
    close(LEE);
    #$RESULTADO.= "<br>$tot coincidencias<hr>";

    if ($tot>0 && $imprimir){print "<br>$tot Coincidencias<hr>";}
    return ($tot,$RESULTADO);
}


sub PalabrasAND{
    my($archivo,$palabras,$formato,$imprimir)=@_;
	($debug)?print "SUB->LEERPALABRAS\n":0;
	(!$formato)?$formato="LIN:#NUMLIN#;FOUND:#LINEA#":0;
    my(@palas)=split(' ',$palabras);
    my($RESULTADO,$RESLIN,$lin,$tot,$hay);
   my %P;
    $tot=$lin=$hay=0;

    foreach $i(@palas){
      $P{$i}{'veces'}=0;
      $P{$i}{'found'}=[];
   }
    $p=join('|',split(' ',$palabras));

    open(LEE,"<$archivo") || print "ERROR TONTO-file($archivo)-LEEPALABRAS ";
    
    while(<LEE>){
      $_=&ParseLine($_);
      foreach $i(keys %P){
         if ($_=~/ $i /i){
            $_=~s/($i)/<b>$1<\/b>/gi;
           
            $RESLIN=$formato;
            $RESLIN=~s/#NUMLIN#/$lin/g;
            $RESLIN=~s/#LINEA#/$_/g;
            push(@{$P{$i}{'found'}},$RESLIN);
            $P{$i}{'veces'}+=1;
         }
      }
      $lin++;
    }
    close(LEE);
   
    return (\%P);
}

sub ParseLine{
	my($line)=shift;
	$line=~s/<[^>]*>//g;
   $line=~s/<[^>]*$//g;
   $line=~s/^[^<]*>//g;

#print $line."\n";
	return $line;
}

sub Completo{
   my($hash)=shift;
   %H=%$hash;
   if (!(%H)){print "ERROR-Ftext-NO existe el Hash\n";}
   foreach $i(keys %H){
      if ($H{$i}{'veces'}==0){
        return 0;
      }
   }
   return 1;
}
1;

