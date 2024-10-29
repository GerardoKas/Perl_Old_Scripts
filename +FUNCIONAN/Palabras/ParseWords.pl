use Text::ParseWords;
$file = shift @ARGV;
$keep=0;
$delim='[\s:;\.,]';

open(FILE,"<$file") or die "No se pudo abrir '$file'";
@lines=<FILE>;
close FILE;

@words = &quotewords($delim, $keep, @lines);
#%hash=map {$_=>$_++} @words;
foreach(@words){
  if($hash{$_}){
    $hash{$_}++;
  }else{
    $hash{$_}=1;
   } 
}
foreach(keys(%hash)){
  if($hash{$_}>1 && length($_)>3){
    print "'$_' = $hash{$_}\n";
  }
}

