use getfolder;

$folder=getfolder::getfolder();
opendir(DR,$folder);
while($f=readdir(DR)){
      print "$f\n";
}
closedir DR;
