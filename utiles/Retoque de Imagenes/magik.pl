use Image::Magick
my $i=new Image::Magick;
$i->Set(geometry=>'500x500');
$i->Read("xc:black");
$i->Write("SS.jpg");







__END__