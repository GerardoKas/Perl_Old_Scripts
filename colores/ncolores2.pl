
$step=30;
@cols=('rojo','verde','azul');
$t=localtime(time());

##############################################################################
print <<END;
$t<br>
<script>
function OP(){
    var p=document.all.p
    if (p.tag=="oculto"){
    for (i in document){p.innerHTML+=i+"=<b>"+document[i]+"</b><br>";}
    p.tag="mostrado";
    }else{
    p.tag="oculto"
    p.innerHTML="DOCUMENT<br>"
    }
}
function mos(item){
//AL OVER
var color=item.style.backgroundColor
document.all.dix.value=color
}
function BG(item){
//AL CLICK
var color=item.style.backgroundColor
if (!TipoPoner){
    window.status="Pulsa un boton para elegir el color de ese elemento ... "+color
    return;
}
//document.bgColor=color
window.status="EL COLOR PARA "+TipoPoner+" = "+color

escribir(TipoPoner,color);

}
var TipoPoner
function poner(tipo){
TipoPoner=tipo//para cuando se clickee el color
}
//////////////////
var CAMPOS=new Array();//sera TEXT=ff00ff....
function escribir(tipo,color){
found=0
for (i in CAMPOS){
    if(CAMPOS[i].match(tipo)){
        CAMPOS[i]=tipo+"=#"+color
        found=1;
        break;
    }
}
if (!found){
    CAMPOS.push(tipo+"=#"+color)
}
var tbody
t="<BODY "
for (i in CAMPOS){
    t+=" "+CAMPOS[i]+" "
}
t+=">"
document.M.TTT.value=t
}
///////////////
function mostrarejemplo(){
var obj=document.all.EJ.style;
var TTV=document.M.TTT.value
TTV+="TEXTO NORMAL<br><a href='nowhere'>LINK</a><br></BODY>"
var ventana=window.open("V","","width=300,height=200");
ventana.document.write(TTV)
}
</script>
<div id=EJ style="position:absolute;top:0;left:400">
</div>
<div id=p style="background-color:black;color:white" tag=oculto onclick=OP()>DOCUMENT<br></div>
<input type=textbox id=dix style="font-size:20" value="ELIGE COLOR">&nbsp;
<form name=M>
<input type=text name=TTT size=100 value="&lt;BODY&gt;"><br>
<input type=button value="BGCOLOR" onclick=poner(this.value)>
<input type=button value="TEXT" onclick=poner(this.value)>
<input type=button value="LINK" onclick=poner(this.value)>
<input type=button value="VLINK" onclick=poner(this.value)>
<input type=button value="ALINK" onclick=poner(this.value)>
<input typE=button value=MoStRaR onclick=mostrarejemplo()>
</form>

END
##############################################################################

@VAS=GeneraCombi();
for $i (@VAS){
    TablaUna($i);
    print "\n\n<br>\n\n";
}
####################################
sub GeneraCombi{
@COR=@CM=('$A','$B','$C');
@VARIACIONES=();
#do{
    $va=cambiar(\@CM,0,1);
    push(@VARIACIONES,$va);
    $va=cambiar(\@CM,2,1);
    push(@VARIACIONES,$va);
    $va=cambiar(\@CM,0,1);
    push(@VARIACIONES,$va);

#}while(join('',@CM) ne join('',@COR));

return @VARIACIONES;

}
    
    
sub cambiar{
    my($AR,$a,$b)=@_;
    $t1=@$AR[$b];
    @$AR[$b]=@$AR[$a];
    @$AR[$a]=$t1;
    return join('.',@$AR);
}

sub TablaUna{
    my($combinacion)=@_;
    #TABLAS A LA DERECHA###
print "<table border=1 width=100%><td>\n\n";
    for($i=0;$i<=255;$i+=64){
    print "<table width=23% border=1 cellspacing=0 cellpadding=0 align=left>";
    #COLOR A#TABLAS DERCHA
    $C=doscifrashexa($i);
    
    #FILAS###
    for ($j=0;$j<=255;$j+=$step){
    
    #COLOR B#FILAS ABAJO
    $B=doscifrashexa($j);
                print "<tr>\n";
    #COLUMNAS######
    for($p=0;$p<=255;$p+=$step){
    
    #COLOR C#COLUMNAS DERECHA
    $A=doscifrashexa($p);
    
    #COMBINACION
    
    $color=eval($combinacion);         #$A.$B.$C;
    
    #IMPRESION
print "<td><span style='background-color:$color;width=100%' onmouseover='mos(this)' onclick='BG(this)'></span></td>\n";
# onmouseover="mos(this)" onclick='BG(this)'
                }
                print "\n</tr>";
            }
            
        print "\n</table>";
        }
print "\n\n</table>\n\n";

}


sub doscifrashexa{
        my($num)=@_;
        $x=sprintf("%x",$num);
        return (hex($x)>hex(10))?$x:"0".$x;
}