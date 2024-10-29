 use SMS::Ringtone::RTTTL::Parser;
 use SMS::Ringtone::RTTTL::MIDI qw(rtttl_to_midi);
 #my $rtttl = 'Flntstn:d=4,o=5,b=200:g#,c#,8p,c#6,8a#,g#,c#,' .
 #            '8p,g#,8f#,8f,8f,8f#,8g#,c#,d#,2f,2p,g#,c#,8p,' .
 #            'c#6,8a#,g#,c#,8p,g#,8f#,8f,8f,8f#,8g#,c#,d#,2c#';
 
 my @n=qw(b g f# p );
 #my @p=("a,g,f","f#,b","a,d,a","d","e,d,a","p","2p","4c,4c");
 #my @p=("g,a,a#","g,a,c","g,f#,c","g,c,c","g,c,f#");
 #my @p=("c,d,e,f","c,d,f","c,f","c,f,e","c,g,c,g,f,e,d","c,e,g");
 my $rtttl="ALEA:d=4,o=4,b=200:";
  srand(time ^ $$ or time ^ ($$ + ($$ << 15)));
 for(1..64){
  $nota=$n[int(rand(@n))];
  #rtttl.="$nota,";
  $pat=$p[int(rand(@p))];
  $rtttl.="$pat,";
}
print $rtttl."\n";
  #my $rtttl  = "Oder:d=4,o=4,b=180:32c,2d,2e,2f,2g,2a,2b,32a,p";
 my $p = new SMS::Ringtone::RTTTL::Parser($rtttl);
 # Check for errors
 if ($p->has_errors()) {
  print "The following RTTTL errors were found:\n";
  foreach (@{$p->get_errors()}) {
   print "$_\n";
  }
  exit;
 }
 # Convert RTTTL to MIDI
 my $midi = rtttl_to_midi($p);
 # Write MIDI to file
 open(F, ">midi2.mid");
 binmode(F);
 print F $midi;
 close(F);
