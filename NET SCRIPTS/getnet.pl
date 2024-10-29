use Net::netent qw();
$n=Net::netent::getnetbyname("loopback");
print $n->name;

#ESTO DA ERROR QUE NO EXISTE LA FUNCION