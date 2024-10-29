@echo off
:begin
if z%1==z goto end
perl "C:\Perl\utiles\Retoque de Imagenes\Normalize.pl" %*
shift
goto begin
:end
pause