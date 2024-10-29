package forms;

sub forms::getdata{
	  my ($cadena)=@_;
	   my %form=();
	($cadena eq '')?$cadena=$ENV{'QUERY_STRING'}:0;
	@line=split(/&/,$cadena);
	foreach $valor(@line){
	  ($nombre,$val)=split(/=/,$valor);
	  $val=~tr/+/ /;
	  $val=~s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/eg;
	  $form{$nombre}=$val;
	}
	return %form;

}
sub forms::printquery{
	my $cadena=$ENV{'QUERY_STRING'};
	#return $cadena;
	#print $cadena;
}
sub forms::getvalue{
	my ($value)=@_;
	my $cadena=$ENV{'QUERY_STRING'};
	my %form=();
	#print $value;
	@line=split(/&/,$cadena);
	foreach $valor(@line){
	  ($nombre,$val)=split(/=/,$valor);
	  $form{$nombre}=$val;
	}
	#print $form{$value};
	return $form{$value};


}
sub forms::form{
  my ($cadena)=$ENV{'QUERY_STRING'};
  my %form=();
  @line=split(/&/,$cadena);
  foreach $valor(@line){
	  ($nombre,$val)=split(/=/,$valor);
	  $val=~tr/+/ /;
	  $val=~s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/eg;
	  $form{$nombre}=$val;
  }
  return %form;
}

sub forms::postdata(){
read (STDIN,$buffer,$ENV{'CONTENT_LENGTH'});
@pairs=split(/&/,$buffer);
	foreach $pair (@pairs){
	($name,$value)=split(/=/,$pair);
		$value=~tr/+/ /;
		$value=~s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/eg;
			$form{$name}=$value;
	}
	#print %form;
return %form;
}


1