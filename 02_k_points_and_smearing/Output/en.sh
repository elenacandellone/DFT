#!/bin/sh
kgrid="2 3 4 5 6 7 8 9 10 11 12 13 14"
smear="0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1"

for k in $kgrid 
do
for sigma in $smearing
do 
printf "${k}"
printf "	"
printf "${sigma}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print " " a[1]}' pb_${k}_${sigma}.scf.out 
done
done > energy_k.csv

