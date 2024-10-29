package cadenas;

sub cadenas::cabecera{
	my($pagina)=@_;
	 print "SERVIDOR: <b>$ENV{'SERVER_NAME'}</b><br>USUARIO:<b>$ENV{'REMOTE_ADDR'}</b><br><b><i>$pagina</b></i><br><hr>\n";
	print "DOCUMENT_ROOT::$ENV{'DOCUMENT_ROOT'}<br>\n";

}

sub cadenas::info{
	while (($key,$val) = each(%ENV))
	{
	  print "<B>$key</B>: $val <br>\n";
	}
}

sub cadenas::scripts{
$cad="<script>var inicio=new Date</script><script src=tiempo.js></script><script src=comon.js></script>";
return $cad
}

sub cadenas::bodyoscuro{
$body="<body bgcolor=black text=yellow link=99ff00 vlink=99ff00 alink=red>\n<basefont face=arial>";
}
sub cadenas::bodyclaro{
$body="<body bgcolor=white text=black link=green vlink=green alink=red>";
}
1