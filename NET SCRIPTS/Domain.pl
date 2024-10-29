use Net::Domain qw(hostname hostfqdn hostdomain);

print "HOSTFQDN: ".hostfqdn()."\n";
print "HOSTNAME: ".hostname()."\n";
print "HOSTDOMAIN: ".hostdomain()."\n";
