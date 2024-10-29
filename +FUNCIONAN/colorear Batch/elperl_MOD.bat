echo off
REM Un debuger a la GerardoCastro
REM para ejecutar sin problemas un script perl
REM [No hay entrada de parametros (a&uacute;n) ]


REM cambiar el titulo (solo NT)
TITLE %1

:INICIO

cls

ECHO ===%1====
echo 1  NORMAL (EN PANTALLA)
echo 2. VERBOSE (EN PANTALLA)
echo 3. CHECKEAR SINTAXIS (OK)
echo 4. SALIDA TEXTO 
echo 5. SALIDA HTML
echo 6. -DEBUG
echo 7. MSDOS
echo 8. SALIR   
echo 9. SACaR POD-HELP
ECHO ============
choice.com /C:123456789 /S ELIGE OPCION

if errorlevel 9 goto POD
if errorlevel 8 goto END
if errorlevel 7 goto MDOS
IF ERRORLEVEL 6 GOTO DEB
if errorlevel 5 goto EXP
if errorlevel 4 GOTo NOTE
if ERRORLEVEL 3 GOTO CHECK
IF ERRORLEVEL 2 GOTO VERBO
IF ERRORLEVEL 1 GOTO NORMAL

pause
REM si no es ninguna de esas opciones
goto INICIO

:NORMAL
REM Sin switches
perl %1
pause
goto INICIO

:CHECK
REM Switch para comprobar sintaxis
perl -c %1
pause 
GOTO INICIO

:NOTE
REM Guardar salida y abrir con notepad
set ET=Perl_Out.txt
perl %1 >%ET%
start NOTEPAD.EXE %ET%
goto INICIO

:EXP
REM Guardar salida con extension html y abrir con el navegador por defecto
set ET=Perl_Out.html
perl %1>%ET%
start %ET%
goto INICIO

:DEB
REM Switch para entrar en el depurador (complejo) de Perl
perl -d %1
pause
goto INICIO

:MDOS
REM Entrar en msdos por si hace falta
command.com
goto INICIO

:VERBO
REM modo verbose o con warnings (lo primero para corregir un programa)
cls
perl -w %1
pause
goto INICIO

:POD
REM sacar la ayuda del modulo
pod2html %1 --outfile=%1.htm

:END
echo Adios
exit