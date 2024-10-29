#to hexa;

$n=254;
#$x=pack('C',$n);
$x=chr($n);
print "$x - ";
$p=unpack('H2',$x);
print $p;
print "\n";