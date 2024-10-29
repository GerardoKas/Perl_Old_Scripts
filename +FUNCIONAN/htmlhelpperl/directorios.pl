use File::Find;
use Data::Dumper;
my $FILES={};
$raiz="C:/htmlperl";
select STDOUT;
find(\&anadir,$raiz);
$DEB=1;
open(FL,">C:/PAGINA.HTML") or die "RROR TONOT";
select FL;
($DEB>1)?print Dumper($FILES):0;
inicio();
print "<span style='float:left;width:320;height:430;overflow:scroll;display:inline'>\n";
primir($FILES);
print "</span>";
#print "<span style='float:right;background-color:black;color:white' id=TIT>jjjjj</span><br>\n";
print "<iframe style='float:right;width:450;height:430;'  name='CONT'>";

close FL;
select STDOUT;
###################################################
sub primir{
   my $subdir=shift;
   print "<ul>\n";
   foreach(sort keys %$subdir){
      my $a=$subdir->{$_};
         if($_ eq ".ITEMS"){
            foreach $i(keys %$a){
               $ln=$a->{$i};
               $titulo=titulo("$raiz/$ln");
             print "\t<li class=ITEM><a href=\"$ln\">$i</a><br><i>$titulo</i>\n";  
            }   
         }elsif(ref($a) eq "HASH"){
            print "<li class=DIR>$_\::\n";
               primir ($a);
         }
   }   
   print "</ul>\n";
}
sub anadir{
   $fl=$File::Find::name;
   if(-d $fl) {return 0};
   $fl=~s[\\][/]g;
   $fl=~s[$raiz/][]i;
   ($DEB)?print STDOUT "FL=$fl\n":0;
   @sd=partes($fl);
   $name=pop @sd;
   my $t="\$FILES";
   ($DEB)?print "SD=@sd\n":0;
   foreach(@sd){
   $t.="->{\"$_\"}";   
   }
   $t.="->{'.ITEMS'}";
   $name=~s/'/\\'/g;
   $cadev="$t->\{'$name'}=\"$fl\"";
   eval($cadev);
   if($@){
      die "ERROR CADENA EVAL\n$cadev\n$@\n";
   }
}

sub partes{
   my $dir=shift @_;
   $dir=~s[\\][/]g;
   @sd=split("/",$dir);
   return @sd;
}

sub inicio{
print <<END;
<head>
<title>Me olvidé del Título</title>
<style>
.ITEM{list-style-type:square;font-weight:300;}
.DIR{list-style-type:circle;font-weight:700;}
UL UL{cursor:crosshair;display:none;margin: 0 0 0 0}
UL{display:list-item;cursor:crosshair}
I{color:green}
BODY{margin:5 0 0 0}
</style>
<script>
function disp(){
   var obj=event.srcElement
   if(obj.nodeName != "LI") return false
   if(obj.childNodes.length<2) return false
   obj=obj.childNodes(1)
   window.status=obj.nodeName+", "+obj.style.display;
      if(obj.style.display=="list-item"){
         obj.style.display="none"
      }else{
         obj.style.display="list-item"
      }
}
function ll(){
   iframe=event.srcElement
   alert(iframe.title)
   window.defaultStatus=iframe.title
   window.status=iframe.title
   TIT.innerHTML=iframe.title
   
}

</script>
</head>
<body onclick=disp()>
<base target="CONT" href="$raiz/">
END
}


sub titulo{
  my($file)=@_;
  $h="";
  if(-d $file) {return "DIRECTORIO";}
  open(F,$file) or die "NO ABRE FILE $file";
  for(0..5){
    $h.=<F>;  
  }
  close F;
$h=~/<title>([^<]+)</i;
  if($1){
    return $1;
  }else{
    return "-S/T-";
  }
  
}