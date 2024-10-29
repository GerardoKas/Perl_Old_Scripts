open(FL,"ej1.html") or die "ERTO";
@f=<FL>;
close FL;


# Thu, 26 Sep 2002 13:33:53 -0400
fecha(@f);
sub fecha{
  my(@fl)=@_;
  for(@fl){
    print $_;
    if($_=~s/^Date: //i){print "ENCONGTRADO $_";$linea=$_;last};}
  @fd=split(/ /,$linea);
  $num=$fd[1];$mes=$fd[2];$ano=$fd[3];$hora=$fd[4];
  @h=split(":",$hora);
  print "\nDIA:$dia NUM:$num MES:$mes AÑO:$ano a las $hora\n";
  return timelocal($h[2],$h[1],$h[0],$num,$mes,$ano);
}