#!/bin/sh
# Descarga las fotos de Pexels (licencia libre) en img/ y las prepara para subir.
cd "$(dirname "$0")"
ok=0; fallo=0
while read -r nombre id pagina; do
  [ -z "$nombre" ] && continue
  printf "Descargando %-24s " "$nombre"
  if curl -fsSL -A "Mozilla/5.0" -o "img/$nombre" "https://images.pexels.com/photos/$id/pexels-photo-$id.jpeg?auto=compress&cs=tinysrgb&w=1600" \
     || curl -fsSL -A "Mozilla/5.0" -o "img/$nombre" "https://www.pexels.com/photo/$id/download/?w=1600"; then
    echo "OK"; ok=$((ok+1))
  else
    rm -f "img/$nombre"; echo "FALLO -> bájala a mano desde $pagina"; fallo=$((fallo+1))
  fi
done < fotos.txt
echo ""
echo "Descargadas: $ok   Fallidas: $fallo"
open img 2>/dev/null
