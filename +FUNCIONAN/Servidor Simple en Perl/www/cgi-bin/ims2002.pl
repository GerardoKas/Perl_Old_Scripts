use CGI qw(:standard);
my $root_files="C:/+/DIBUJOS";
print header;
opendir(DR,$root_files) or die "EERO TOTO";
@fs=readdir(DR);
closedir DR;
foreach (@fs){
  next if(-d "$root_files/$_");
  print "<img src='$root_files/$_' width=300>\n";
  }


__END__