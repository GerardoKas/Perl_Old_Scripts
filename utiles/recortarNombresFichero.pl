my $dir=shift;
print "BASE:".$dir."\n";
use File::Find 'find';
find(\&doIt,$dir);

sub doIt{
  my ($file)=$_;
#   if(-d $file and $file=~/_archivos$/ and 0){
#   
#     if(noInteresante($File::Find::name)){
#       rmdir $file;
#     }
#   }
  $rename=$file;
  if($rename=~s/^ATAME //){
  print "RENAMIN $file\n";
  rename($file,$rename);
  }
  if (length($File::Find::name)>66){
    print "MUY LARGO EL NOMBRE:";
    #exec "explorer.exe /c $File::Find::name";
  }
}

sub noInteresante{
  use File::Glob ':glob';
  my $file=$_;
  #chdir($file);
  $borrar=0;
  print "\nHTML_ARCHIVOS:$file\n";
  @contenido=bsd_glob("*.*");
  foreach $itemF(@contenido){
     print "*$itemF\n"  ;
     $size=("/$itemF");
  }
  if( $borrar==1 ){
    print "borrando $file";
    rmdir($file) or print "ERROR : $!";
  }else{
    #print "NO SE BORRA POR EL FICHERO $itemF\n";
  } 
}