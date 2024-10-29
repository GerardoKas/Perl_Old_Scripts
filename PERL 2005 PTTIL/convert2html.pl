$file=shift;
open(FILE,"<$file") or die "cant open $file";
@lines=<FILE>;
close FILE;
$backup="$file\.bak";
rename $file,$backup;

foreach(@lines){
  $_=~s/$/<br>/;
}

@words=qw(amor amar perd(o|ó)n madre odio cariño miedo culpa);
$todo=join("",@lines);

  foreach $w(@words){
    $todo=~s/($w)/<b>$1<\/b>/g;
  }

open (SAVE,">$file") or die "cant open for save $file";
print SAVE $todo;
close SAVE;






__END__
