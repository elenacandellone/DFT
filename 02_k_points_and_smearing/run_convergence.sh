#!/bin/sh
kgrid="2 3 4 5 6 7 8 9 10 11 12 13 14"
smear="0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1"

for k in $kgrid
do
for s in $smear
do
cat > Pb.scf.in << EOF
&CONTROL
 calculation = 'scf',
 restart_mode='from_scratch',
 prefix = 'Pb',
 pseudo_dir = '/home/elenacandellone/qe-6.8/pseudo',
 outdir = './tmp',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 2, 
 celldm(1) = 9.355659,
 nat=1, 
 ntyp=1,
 ecutwfc = 70,
 ecutrho = 560,
 occupations='smearing',
 smearing='mp',
 degauss=$s
/
&ELECTRONS
 conv_thr = 1.0d-9
/
ATOMIC_SPECIES
 Pb 207.2 Pb.pbesol-dn-kjpaw_psl.1.0.0.UPF

ATOMIC_POSITIONS crystal
Pb 0.00000 0.00000 0.00000

K_POINTS automatic
$k $k $k 0 0 0
EOF

/home/elenacandellone/qe-6.8/bin/pw.x < ./Pb.scf.in > ./Output/Pb_${k}_${s}.scf.out
rm -rf tmp
done
done

