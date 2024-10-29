
use Win32::API;
#ESTO NO FUNCIONA TODAVIA ???
$getshort=new Win32::API("Kernel32","GetShortPathName",[P,P,N],N);
$long="C:\\Mis documentos";
$buf=80;
$short=" " x $buf;

$len=$getshort->Call($long,$short,$buf);
print "$len\n\n";
print $short;

__END__
LLAMADA A PERL WIN32::API
use Win32::API;
@arguments=(I,N,P) #Integer,LongNumber,Pointer(string,structure),
                  y ademas de retorno existe V(void)
  $function = new Win32::API($library, 
                             $functionname, 
                             \@argumenttypes, 
                             $returntype);
  $return = $function->Call(@arguments);

SI TENEMOS UNA ESTRUCTURA COMO PARAMETRO O COMO RETORNO, HAY QUE USAR PACK y UNPACK

 $lpPoint = pack("LL", 0, 0); # store two LONGs
    $GetCursorPos->Call($lpPoint);
    ($x, $y) = unpack("LL", $lpPoint); # get the actual values

--------------------------------------------------------------
$getshort=new Win32::API("Kernel32","GetShortPathName",[P,P,N],N)
$long="C:\Mis documentos"
$buf=225
$short="*" x $buf

$len=$getshort->Call($long,$short,$buf);
-------------
kernel32.lib

DWORD GetShortPathName(

    LPCTSTR  lpszLongPath,	// points to a null-terminated path string
    LPTSTR   lpszShortPath,	// points to a buffer to receive the null-terminated short form of the path 
    DWORD  cchBuffer 	// specifies the size of the buffer pointed to by lpszShortPath
   );	
Parameters

lpszLongPath

Points to a null-terminated path string. The function obtains the short form of this path.

lpszShortPath

Points to a buffer to receive the null-terminated short form of the path specified by lpszLongPath.

cchBuffer

Specifies the size, in characters, of the buffer pointed to by lpszShortPath.

Return Value

If the function succeeds, the return value is the length, in characters, of the string stored in *
lpszShortPath, not including the terminating null character.
