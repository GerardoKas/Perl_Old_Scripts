use File::Find;

$dir=shift;

File::Find::find(\&renamear,$dir);

sub renamear{
  $file=$_;
  return unless (!-d $_);
  $file=~/^(.+)\.bak$/i;
  $new=$1;
  rename $file,$new;



}
