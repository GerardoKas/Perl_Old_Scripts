use Image::Magick;
use GCM::getfolder;
use File::Find;
print "INI\n";
my $dir=GCM::getfolder::getfolder();
$logo="el13.com_2002_cc.gif";
my $ologo=new Image::Magick;
print "CARGA LOGO...";
$ologo->Read($logo);
#$ologo->Set(fuzz=>5,matte=>'True', matecolor=>'Black');
if(bool("SOBREESCRIBIR LOS ORIGINALES?")){
$new=0;
}else{
$new=1;
}
find(\&procesa,$dir);


sub procesa{
if(-d $_){return 0}
return unless ($_=~/((gif)|(jpg)|(bmp)|(png))/i);
my $ima=new Image::Magick;
print "LEE $_ ...";
$ima->Read($_);
$dest=$_;
if($new){
$dest=~s/\.(\w{1,4})/_el13\.$1/;
}
print "COMPONE...";
$ima->Composite(image=>$ologo,compose=>"Over",gravity=>'SouthEast');#Probar Over (transp) o Copy (opaco)
print "GRABA...\n";
$ima->Write($dest);
}

#system "start $dest";

sub bool{
my $text=shift;
print "$text ? [0,1] ? ";
$r=<>;
chomp($r);
return $r;
}

