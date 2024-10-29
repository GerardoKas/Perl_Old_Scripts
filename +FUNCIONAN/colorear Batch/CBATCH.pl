@COMS=qw(if errorlevel title echo off cls pause goto start exit set);

$file=shift;
$file="elperl_MOD.bat";
open(FL,"$file") or die "NIO ESISTE";
open(SV,">sourced.html") or die "ERROR SALIDA";
select SV;
while(<FL>){
$l=$_;

if($l=~/^(@?rem.*)/i){
  $l="<font color=green>$1</font>";
}else{
  #perl
  $l=~s/(perl(\.exe)? +)/<font color=maroon>perl.exe<\/font> /i;
  #ETIQUETAS
  $l=~s/^(:\w+)/<font color=red>$1<\/font>/ig;
  $l=~s/goto\s+(\w+)/GOTO <font color=red>$1<\/font>/ig;
  #VARIABLES
  $l=~s/(%\d)/<font color=orange>$1<\/font>/g;
  $l=~s/(%\w+%)/<font color=orange>$1<\/font>/g;
  $l=~s/set\s+(\w+)/SET <font color=orange>$1<\/font>/g;
  #ECHOS
  $l=~s/echo\s+(.*)$/ECHO <font color=gray>$1<\/font>/i;
  #COMANDOS
  foreach(@COMS){
  $l=~s/($_)/<font color=blue>$1<\/font>/ig;
  }
}
chomp($l);
$l.="<br>\n";

print $l;
}
close SV;
close FL;
