use Socket;
$addr = pack('C4', (140,203,7,103));
($name, $alias, $addrtype, $length, @addrs) =
gethostbyaddr($addr, AF_INET);
print("gethostbyaddr() [$alias].\n");
