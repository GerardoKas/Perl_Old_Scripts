use File::Find;
use Data::Dumper;
my $FILES={};
$raiz="c:/htmlperl";
find(\&anadir,$raiz);
#$DEB=2;
open(FL,">C:/PAGINA.HTML") or die "RROR TONOT";
select FL;
($DEB>1)?print Dumper($FILES):0;
inicio();

primir($FILES);
###################################################
sub primir{
   my $subdir=shift;
   print "<ul>\n";
   foreach(sort keys %$subdir){
      my $a=$subdir->{$_};
         if(ref($a) eq "HASH"){
            print "<li class=DIR>$_\::\n";
               primir ($a);
         }
         if($_ eq ".ITEMS"){
               @its=@{$a};
               $link="javascript:alert('NO IMPELEMENTADO')";
            foreach $i(@its){
             print "\t<li class=ITEM><a href=\"$link\">$i\n";  
            }   
         }
   }
   print "</ul>\n";
}
close FL;
sub anadir{
   $fl=$File::Find::name;
   if(-d $fl) {return 0};
   $fl=~s/$raiz\///;
   ($DEB)?print "FL=$fl\n":0;
   @sd=partes($fl);
   $name=pop @sd;
   my $t="\$FILES";
   ($DEB)?print "SD=@sd\n":0;
   foreach(@sd){
   $t.="->{\"$_\"}";   
   }
   $t.="->{'.ITEMS'}";
   $cadev="push(\@{$t},\"$name\")";
   eval($cadev);
   if($@){
      die "ERROR CADENA EVAL\n$cadev\n\n";
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
.ITEM{list-style-type:square;font-weight:300;color:blue}
.DIR{list-style-type:circle;font-weight:700;}
//.R{display:list-item;color:red;font-weight:900}
UL UL{cursor:hand;display:none}
UL{display:list-item;cursor:crosshair}
</style>
<script>
function disp(){
   var obj=event.srcElement
   if(obj.nodeName != "LI") return false
   if(obj.childNodes.length<2) return false
   obj=obj.childNodes(1)
   window.status=obj.nodeName+", "+obj.style.display;
      if(obj.style.display=="none"){
         obj.style.display="list-item"
      }else{
         obj.style.display="none"
      }
}
</script>
</head>
<body onclick=disp()>
END
}