@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!perl
#line 15
use Image::Size 'html_imgsize';
use CGI 'escapeHTML';
$dir=shift @ARGV;
#$dir='E:\Abracadabra\VARIOIMAGEN\Trabajos Niños 1998';
print "Listado de \"$dir\"\n";
opendir(DR,$dir) or die "NO EXISTE $dir";
@fs=readdir(DR);
closedir DR;

@fs=grep {!/^\./} @fs;
@fs=grep {/\.jpe?g$/i} @fs;


print ($#fs+1)." Archivos";
print "$dir\n\n";
foreach(@fs){
	print "$_\n";
open(FL,">$dir/$_\.html") or die "ERROR EsCRITURA";
print FL <<END;
<style>
IMG{border:thin solid black}
</style>
<link rel='stylesheet' type='text/css' href='hoja.css'>
END
print FL "<img src=\"".escapeHTML($_)."\" ".html_imgsize("$dir/$_")." align=left><span align=right> TEXTOAQUI </span>";
close FL;

}
print "HECHO\n";
system "pause";







__END__
__END__
:endofperl
