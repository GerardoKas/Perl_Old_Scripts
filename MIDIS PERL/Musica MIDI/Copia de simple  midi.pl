 use SMS::Ringtone::RTTTL::Parser;
 use SMS::Ringtone::RTTTL::MIDI qw(rtttl_to_midi);
 #my $rtttl = 'Flntstn:d=4,o=5,b=200:g#,c#,8p,c#6,8a#,g#,c#,' .
 #            '8p,g#,8f#,8f,8f,8f#,8g#,c#,d#,2f,2p,g#,c#,8p,' .
 #            'c#6,8a#,g#,c#,8p,g#,8f#,8f,8f,8f#,8g#,c#,d#,2c#';
 
  my $rtttl  = "Oder:d=4,o=4,b=180:c,d,e,f,g,a,b";
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
