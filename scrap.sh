#!/bin/sh
ans=$(whiptail --title "https://atareao.es" \
   --checklist "Elige uno o varios colores" 10 80 4 \
   "AZUL" "azul" OFF \
   "ROJO" "rojo" ON \
   "GRIS" "gris" ON \
   "LILA" "lila" OFF \
   3>&1 1<&2 2>&3)

echo ans   