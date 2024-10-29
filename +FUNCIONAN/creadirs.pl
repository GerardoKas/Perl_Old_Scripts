creadir("c:\\htmlperl","lib/ExtUtils/es/to/es/(o/mas/imo");

sub creadir{
  my($root,$d)=@_;
  $root=~s[/][\\]g;
  $root=~s[\\$][];
  $d=~s[/][\\]g;
  return 1 if(-e "$root\\$d");   
  my @dirs=split(/\\/ , $d);
  $a=$root;
  foreach (@dirs){
  $a.="\\".$_;
  #print "$a\n";
  }
}