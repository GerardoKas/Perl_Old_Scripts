$dir=shift @ARGV;
print "\nListado de - $dir -\n";
print "-"x80;
opendir(DR,"$dir/miniaturas") or die "NO EXISTE $dir";
$dir=~m|\\([^\\]+?)$|;
$autor=$1;

@fs=readdir(DR);
closedir DR;

@fs=grep {!/^\./} @fs;
@fs=grep {/\.jpe?g$/i} @fs;

print "\n\n".@fs." Archivos de Imagen\n\n";

@fs=map{$_="\"$_\""} @fs;

$lista=join(", ",@fs);

open(FL,">>$dir/../indice.js") or die "ERROR EsCRITURA";
print FL <<END;
var $autor=new Array(
$lista
);
/*
  --PARA ARTISTAS
  <span class=G><a target=Main href="$autor/index.html" class=ARTISTA><b> $autor </b><br>
	<img align=top src="ojo_cromatico.gif" onmouseover="this.src=imago(this,'$autor')"  width=100 height=100></a>
  </span>
  --PARA EL INDICE DE ADULTOS
  <a href="../artistas/$autor/index.html"> $autor </a>
*/
END
close FL;

#open(INDICE,">>$dir/../indiceJs.html") or die "error en indice al escribir";
#print INDICE "\n<script src=\"$autor/ListadoImagenes.js\"></script>";
#close INDICE;

print "\n\nHECHO\n";
system "pause";







__END__