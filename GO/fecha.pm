package fecha;
#rint "time::".time."\n";
sub fecha::fecha{
($sec,$min,$hour,$mday,$mon,$year)=localtime(time);
#$mday+=1;
$mon+=1;
if ($year>99){
	$year=$year-99;
	$year=1999+$year;
	}
return "<font size=-1>Pagina creada en $mday/$mon/$year, a las $hour:$min:$sec</font><br>\n";
}
1