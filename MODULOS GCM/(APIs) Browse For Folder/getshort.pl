use Win32::API;

$error=new Win32::API("kernel32","GetLastError",[],N);
$getshort=new Win32::API("kernel32","GetShortPathName",[P,P,N],N);
$long="C:/Mis documentos/perl scripts";
$buf=80;
$short=" " x $buf;

$len=$getshort->Call($long,$short,$buf);
if($len==0){
$err=$error->Call();
die "ERROR_API_:$err_\n\n";
#error 2 == no existe la ruta
}
$dir=substr($short,0,$len);
print $dir;
