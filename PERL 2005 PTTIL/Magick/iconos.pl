use Image::Magick;
my $im = Image::Magick->new(size=>'64x64');

$im->Read("xc:white");
#$im->Draw(primitive=>'text',pen=>'black',text=>'ABCD',geometry=>'64x64');
#$res=$im->Draw(primitive=>'Text',geometry=>'60x60+0+0',text=>'ABCD',fill=>'green');
$res=$im->Draw(primitive=>'Text',geometry=>'60x60+0+0',text=>'ABCD',fill=>'green',points=>'0,40 "hoal"');
print $res."\n";
print $im->Write("bmp:c:\icono.bmp");



__END__
$im->Read('xc:white')
$rc = $im->Annotate(
x => 10,
y => 20,
text => 'Some String');
$rc = $im->Annotate(
text => 'Green Text',
font => '@timesbd.ttf',
fill => 'green',
geometry => '+20+30',
pointsize => 8);
$rc = $im->Draw(
primitive => 'Text',
points => '0,40 "Other String"');
$rc = $im->Read('label:New Image');
