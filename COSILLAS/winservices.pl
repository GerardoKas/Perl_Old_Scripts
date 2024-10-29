use Win32::Service;

my(%h);
my $file="C:\\SERVICIOS.HTM";
print Win32::Service::GetServices("",\%h);
open(FL,">$file");
for $k(keys %h){
  print FL "<pre>$h{$k}</pre><b>$k</b>";
  Win32::Service::GetStatus("",$h{$k},\%sta);
  print FL "<table border=1>";
 for $s(keys %sta){
  print FL "<tr><td>$s</td><td>$sta{$s}</td></tr>";
}
  print FL "</table><hr>";
  
}

close FL;
system("start $file");