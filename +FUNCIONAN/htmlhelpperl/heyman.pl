use Pod::Html;
$root="c:\\htmlperl";
$file=shift @ARGV;
if ($file eq ""){
  print "LEYENDO STDINPUT\n";
  while(<>){
    $file=$_;
    HACE($file) if (!-d $file && $file=~/\.(pod|pm)$/);
  }
}elsif(-d $file){
use File::Find;
find(\&item,$file);
HACE();
}else{
HACE($file);
}

sub item{
$fl=$File::Find::name;
if(!-d $fl){
#print $fl."\n";
HACE($fl);
}
}
sub HACE{
  my $file=shift;
$file=~s/\//\\/g;
$file=~/([^\\]+)$/;
$nomext=$1;
$nomext=/([^\.]+)(\.([^\.]{1,}))$/;
$name=$1;
$ext=$3;
if($ext=!/(pod|pm|pl)/){
   return 0;
   }
if($name){
print "\nNAME=$name\n";
}else{
print "NONAME FOR : $file\n";
return;
}
$file=~/C:\\Perl\\(.+)\\[^\\]+$/i;
$path=$1;
print "PATH=$path\n";

$fileroot="$root\\$path";
if (-s "$fileroot\\$name.html"){
  print "YA existe $fileroot\\$name\n";
  return;
}
&creadir($root,$path);
pod2html(
             "--podroot=C:\\perl",
             "--podpath=lib:site", 
             "--htmldir=$root",
             "--htmlroot=$root",
             "--libpods=perlfunc:perlguts:perlvar:perlrun:perlop",
             "--recurse",
             "--infile=$file",
             "--outfile=$fileroot\\$name.html",
             "--verbose",
             "--quiet"
             );

unlink <*.x~~>;
}

sub creadir{
  my($root,$d)=@_;
  $root=~s[/][\\]g;
  $root=~s[\\$][];
  $d=~s[/][\\]g;
  return if(-e "$root\\$d");
    
  my @dirs=split(/\\/, $d);
  $a=$root;
  foreach (@dirs){
  $a.="\\".$_;
  #print "$a\n";
  mkdir($a,700);
  }
}