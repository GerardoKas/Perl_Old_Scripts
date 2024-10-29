use File::Find;
use Data::Dumper;
use Image::Magick;
use File::Copy;
my $FILES={};
my $savedir="E:/MINIATURAS";
my @dirs_ok=("gcm","gerardo","imagenes","abracadabra");
my @dirs_not=("tias","otras","sexo");
print "MES_ANNO DEL DISCO? : ";
$mes=<>;
chomp($mes);

print "ORIGEN (en I:/)(o nada, y recorrer los comunes): ";
$raiz=<>;
chomp($raiz);
print "EMPEZAMOS : \n\n";
if($raiz){
  if($raiz=~/^\\|\/$/){#se quiere recorrer todo
    @dirs_ok=("");
  }else{
    @dirs_ok=("$raiz");
  }
}
print "SE GUARDAR'A EN $savedir/$mes";
mkdir("$savedir/$mes",700);
for(@dirs_ok){
  next unless (-e "i:/$_");
  $raiz="i:/$_";
  $dest="$savedir/$mes/$_";
  $dest=~s/\/$//;$raiz=~s/\/$//;
  print "_"x80;
  print "\nRAIZ: $raiz\nDEST: $dest\n\n";
find(\&anadir,$raiz);
}
#$DEB=2;

sub anadir{
   if(map{$File::Find::dir=~/$_/i} @dirs_not){
    return 0;
   }
   $fl=$File::Find::name;
   
   if(-d $fl) {return 0};
   $fl=~s/$raiz\///i;
  
   #print "\n --$raiz--\n$fl\n--\n";
   @sd=partes($fl);
   $name=pop @sd;

   $name=~s/\.([\w\d]{1,4})$//i;
   $ext=$1;
   creardir(@sd);
      if($ext=~/(jpg|png|tif|pcx|bmp)/i){
        $newext="jpg";
      }elsif($ext=~/gif/i){
        $newext="gif";
      }elsif($ext=~/(mid|swf|ico|ani|cur)/i){
        if(! -e "$dest/$fl"){
        print "COPIANDO ARCHIVO ... $fl\n\n";
        copy("$raiz/$fl","$dest/$fl");
        }
        return 1;
      }else{
        return 0;
      }

      $name.=".$newext";
      push(@sd,$name);
      $newfile=join("/",@sd);
      $newfile="$dest/$newfile";
      if(-e $newfile){return 0}
   
   my $ima=new Image::Magick;
   print "LEyendo $fl ...\n";
   $ima->Read("$raiz/$fl");
   if(!($ima->Get('width') < 250)){
    print "Resize ...\n";
    $ima->Sample(geometry=>'250');
   }
   print "Saving $newfile ...\n\n";
   $ima->Write("$newfile");

}
sub creardir{
  my(@dir)=@_;
  if(!-e $dest){mkdir $dest,700}
  $dd=$dest;
  foreach(@dir){
    #print "ENTRA $_\n";
    $dd.="/$_";
    if(!-e $dd){
      #print "---------$dd------------";
      mkdir $dd,"700";
    }
  }
}
sub partes{
   my $dir=shift @_;
   $dir=~s[\\][/]g;
   @sd=split("/",$dir);
   return @sd;
}
