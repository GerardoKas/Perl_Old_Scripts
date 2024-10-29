use Socket;
$iadd=inet_aton("209.185.108.1");
@f=gethostbyaddr($iadd,AF_INET);

print @f;
print "\nERR: $?\n";
#($name,$aliases,$addrtype,$length,@addrs)
