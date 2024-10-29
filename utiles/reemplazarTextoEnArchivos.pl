$dir=shift @ARGV;
die "No es un dir $dir" unless (-d $dir);
$original='<script\s+[\w\W\n\t\r]+<\/script>';
$reemplazo="<!-- null -->";
opendir(DIR,$dir) or die "no sep uede abrir dir:$dir";
@files=readdir(DIR);
closedir DIR;
chdir($dir);
$total=0;
foreach $file(@files){
next if $file=~/^\./;
open(FILE,"<$file") or die "no se puede abrir $file";
@lines=<FILE>;
close FILE;
$texto=join("",@lines);
$total=$texto=~s/$original/$reemplazo/gmi;
print "$file : $total Remplazos\n";
open(FILE,">$file");
print FILE $texto;
close FILE;
}
