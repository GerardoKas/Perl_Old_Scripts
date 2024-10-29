use Image::Magick;
my $im = Image::Magick->new();

# Read all the images you want with the Read()
# or BlobToImage() methods into $im
$im->Read("acc3.jpg","acc1.jpg","acc2.jpg");
my $montage = $im->Montage(
geometry => '400x400+10+10', # tile size and border
tile => '4x3',
#frame => '2x2',
shadow => 1,
#label => '%f %wx%h',
);
$montage->Write('c:\perl\montage.gif');








__END__
