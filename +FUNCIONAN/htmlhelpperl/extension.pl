@fs=("C:\\perl\\lib\\site\\otro\\esto\\modulouno",
      "C:\\perl\\lib\\modulopm.pm",
      "c:\\porl\lob\\e\\modpod.pod");
$exts="(pm|pod)";
foreach (@fs){
   $_=~/([^\\]+)$/;
   $it=$1;
$1=~/([^\.]+)(\.$exts)$/;
print "N:$1\tE:$2\n";
}