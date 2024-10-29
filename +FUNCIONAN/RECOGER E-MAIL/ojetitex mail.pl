use Net::POP3;
use Time::Local;
$m=Net::POP3->new('pop3.teleline.es',debug=>1);
die "\nNO HAY CONEXION\n" unless $m;
$m->login("ojetitex.teleline.es","tuuevo");

($total,$size)=$m->popstat();
$size=int($size/1024);
print "$total MENSAJES ocupan $size KB\n\n";
print "_"x80;
for(1..$total){
$head=$m->top($_,24);
$subj=head(@$head);
print "[$_]: $subj\n";
$titulo=traduce($subj);
#print "$titulo\n";
$body=$m->get($_);
$m->delete($_);
if(is_html($body)){$ext="html"}else{$ext="txt"}
$f="$titulo.$ext";
open(FILE,">$f") or die "ERRO TONOT $?  $!";
print FILE @$body;
close FILE;

}
$m->quit();

sub traduce{
  my $h=shift;
  $h=~s/[\*\|\?\/\\:<>\"]/!/g;
  chomp($h);
  #print "ES:$h\n";
  return $h;

}
sub head{
  ($subject)=grep {/^Subject:/i} @_;
  $subject=~s/^subject://i;
  chomp $subject;
  return $subject;
}
sub is_html{
    if(grep{/<(html)|(div)|(font).*>/i} @{$_}){
      return 1;
    }
    return 0;
}


__END__
METHODS 
Unless otherwise stated all methods return either a true or false value, with true meaning that the operation was a success. When a method states that it returns a value, failure will be returned as undef or an empty list. 

user ( USER ) 
Send the USER command. 

pass ( PASS ) 
Send the PASS command. Returns the number of messages in the mailbox. 

login ( [ USER [, PASS ]] ) 
Send both the the USER and PASS commands. If PASS is not given the Net::POP3 uses Net::Netrc to lookup the password using the host and username. If the username is not specified then the current user name will be used. 
Returns the number of messages in the mailbox. 

If the server cannot authenticate USER the undef will be returned. 


apop ( USER, PASS ) 
Authenticate with the server identifying as USER with password PASS. Similar ti login, but the password is not sent in clear text. 
To use this method you must have the MD5 package installed, if you do not this method will return undef 


top ( MSGNUM [, NUMLINES ] ) 
Get the header and the first NUMLINES of the body for the message MSGNUM. Returns a reference to an array which contains the lines of text read from the server. 

list ( [ MSGNUM ] ) 
If called with an argument the list returns the size of the message in octets. 
If called without arguments a reference to a hash is returned. The keys will be the MSGNUM's of all undeleted messages and the values will be their size in octets. 


get ( MSGNUM ) 
Get the message MSGNUM from the remote mailbox. Returns a reference to an array which contains the lines of text read from the server. 

last () 
Returns the highest MSGNUM of all the messages accessed. 

popstat () 
Returns an array of two elements. These are the number of undeleted elements and the size of the mbox in octets. 

uidl ( [ MSGNUM ] ) 
Returns a unique identifier for MSGNUM if given. If MSGNUM is not given uidl returns a reference to a hash where the keys are the message numbers and the values are the unique identifiers. 

delete ( MSGNUM ) 
Mark message MSGNUM to be deleted from the remote mailbox. All messages that are marked to be deleted will be removed from the remote mailbox when the server connection closed. 

reset () 
Reset the status of the remote POP3 server. This includes reseting the status of all messages to not be deleted. 

quit () 
Quit and close the connection to the remote POP3 server. Any messages marked as deleted will be deleted from the remote mailbox. 