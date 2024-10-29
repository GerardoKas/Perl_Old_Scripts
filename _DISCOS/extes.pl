use GCM::Files;
use File::Find;

my %FS;
find(\&procesa,"E:/_DISCOS");
open(FL,">indexOTRO.html");
select FL;
foreach $k(keys %FS){
print "<h2>$k</h2>\n";
foreach $i(@{$FS{$k}}){
  print "$i | \n";
  
}
  
}
close FL;
sub procesa{
return if(-d $_);
my ($dir,$n,$ext)=GCM::Files::partes($File::Find::name);
$ext=lc($ext);
push(@{$FS{$ext}},"$n.$ext");

#print "$n\n";
}








__END__