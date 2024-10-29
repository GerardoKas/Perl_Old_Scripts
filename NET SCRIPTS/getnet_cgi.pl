#!/usr/pkg/bin/perl
use CGI qw(:standard);

print start_html('Pruebas');
print start_form."Direccion IP?".textfield('ip');
print end_form;
if(param()){
  print h2("IP:".param('ip'));
  print getnetbyaddr(param('ip'));

}