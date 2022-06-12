#!/bin/sh
Ecut="10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100"

for ec in $Ecut
do
printf "${ec}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print " " a[1]}' Pb_${ec}.scf.out 
done > energy.csv
