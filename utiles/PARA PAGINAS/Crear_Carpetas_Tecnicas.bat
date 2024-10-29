@echo off
set folder=%1
if '%folder%'=='' goto ERROR
for %%i in (Oleo Grabado Dibujo Dibujo_con_Color Texturas Rotuladores Pasteles Varios Barnices Construcciones) do mkdir %folder%/%%i


goto END

:ERROr
echo No has soltado una carpeta
echo No hay parametro de entrada
goto END

:END
pause