$rule1=<<END;
A->B
B->AB
END
$rule=<<END;
A->DB
B->C
C->D
D->E
E->A
END

$start="A";

$iter=8;
$res="";

my @rs=split("\n",$rule);


foreach(@rs){
($var,$val)=split("->",$_);
$RULES{$var}=$val;
print "$var ==> $val\n";
}


$res=$start;
for(1..$iter){
print "$res\n";
$res=sust($res,\%RULES);

}
print $res;





sub sust{
my ($fase,$RS)=@_;
foreach(sort keys %$RS){
$k=$_;
$v=$RS->{$k};
${$k}=$v;
$fase=~s/$k/\$$k/g;
#$fase=~s/$k/$v/g;
}
#print "-$fase\n";
$r=eval("\"$fase\"");
return $r;
}




