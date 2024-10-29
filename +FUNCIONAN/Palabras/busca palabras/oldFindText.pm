package FindText;

sub LeerRexp{
    my($archivo,$rexp,$imprimir)=@_;
    my($tot)=0;
    open(LEE,"<$archivo") || print "ERROR TONTO - LEEPALABRAS";
    print "<h2>$archivo</h2>";
    while(<LEE>){
    if ($_=~/$rexp/){
        $tot++;
        print "<span style)='bgcolor:black;color:white'>$_</span>";
    }
    }
    close(LEE);
    print "Total Encontrados=$tot";
}
sub LeerPalabras{
    my($archivo,$palabras)=@_;
	($debug)?print "SUB->LEERPALABRAS\n":0;
    my(@palas)=split(' ',$palabras);
    my($tot,$nue,$ret);
    $tot=$nue=0;
    $ret="";
    my $repal='([^\s]+)';
    my $nlin=0;
    $IniTabla="<table bgcolor=yellow border=1><colgroup width=50><colgroup bgcolor=ffdd00>";
    $LineaItem='$ret.="<tr><td>$nlin</td><td>$_</td></tr>\n";';
    $LineaTitulo='$ret.="<tr><td bgcolor=red text=yellow colspan=2><a href=\"$archivo\">$archivo</a></td></tr>";';
    
    open(LEE,"<$archivo") || print "ERROR TONTO - LEEPALABRAS";
    $ret.=$IniTabla;
    $p=join('|',split(' ',$palabras));

    while(<LEE>){
        if ($_=~/ ($p) /ig){
        #$_=~/ ($p) ($repal)/i;
        #$tt="$1 $2 ";
        $_=~s/($p)/<font color=red><b>$1<\/b><\/font>/i;
        ($nue==0)?eval($LineaTitulo):0;
        $nue=1;
        $tot++;
        eval($LineaItem);
        }
    $nlin++;
    }

    $ret.= "</table>Encontrado $tot veces<hr>";
    close(LEE);
    if ($tot>0){print $ret;
    }
    return $tot;
}

1;

