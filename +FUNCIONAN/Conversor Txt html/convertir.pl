$DEB=1;
$file="Proyecto.htm";




open(FIL,"<$file") or die("error tonto");
@lines=<FIL>;
close FIL;

$e="&nbsp;";
$tab="&nbsp;&nbsp;&nbsp;&nbsp;";
$stilo="<style[^>]*>";
$cstilo='<\/style[^>]*>';
$etiq='<(\w+)[^>]*>';
$cetiq='<\/(\w+)[^>]*>';
$initenum=0;
$enum=0;
$mkstilo=0;
$num=0;
$numeti=0;

for (@lines){
   if(/$stilo/i){
   #SI TIENE ETIQUETA DE ESTILO
print "ESTILO INICIA" if $DEB;
   $mkstilo=1;
   next;
   }
   if(/$cstilo/i){
      $mkstilo=0;
print "ESTILO FIN\n" if $DEB;
   }elsif ($mkstilo==1){
      #print "NEX\n" if $DEB;
      next;
   }
   if(/^\s*-/){
      if($initenum){
#print "NUM $enum";
         s/^\s*-/<li>/;
      $enum++;
      }else{
print "INITENUM-" if $DEB;
         $initenum=1;
         $enum++;
         s/^\s*-/<ul>\n<li>/;
      }
   }elsif($initenum){
      $initenum=0;
      print "CLOSENUM\n";
      $_="</ul>\n$_";
   }
   
   if(/^($etiq|$cetiq)+$/i){
   #TIENE ETIQ AL PRINCIPIO Y AL FINAL
      #print $_ if $DEB;
      $numeti++;
   }else{
   #ES TEXTO NOTRMAL
      $num++;
      if(/^ /){
         s/^ /&nbsp;/g;
         while(s/&nbsp; /&nbsp;&nbsp;/){};
      }      
      s/\t/$tab/g;
      if (length($_)>120){
         $br="\n<br><p>";
      }elsif(length($_)>240){
         $br="\n<br><br><p>";
      }else{
         $br="\n<bR>";
      }
      chop($_);
      $_.=$br;
      }
      
      
      
}
print "$enum lineas de ENUMERACION\n" if $DEB;
print "\n$num LINEAS SOLO TEXTO ENCONTRADAS\n";
print "$numeti LINEAS SOLO ETIQUETA ENCONTRADAS\n" if $DEB;
print "$#lines LINEAS TOTALES\n" if $DEB;
open (WRI,">0$file.HTM") or die ("CAnnot Escribir ops");
print WRI @lines;
close WRI;
